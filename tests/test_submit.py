"""临时仓库中验证提交包，不接触真实作业或标签。"""
import os
from pathlib import Path
import shlex
import shutil
import subprocess
import tempfile
import unittest
import zipfile


ROOT = Path(__file__).resolve().parents[1]


@unittest.skipUnless(
    all(shutil.which(tool) for tool in ("git", "typst", "zip", "cmp")),
    "需要 git、typst、zip 和 cmp",
)
class SubmitTest(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="submit test ")
        self.addCleanup(self.tmp.cleanup)
        self.repo = Path(self.tmp.name)
        shutil.copy2(ROOT / "submit.sh", self.repo)
        shutil.copytree(ROOT / "report", self.repo / "report", ignore=shutil.ignore_patterns("*.pdf"))
        self.report_env = {
            "STUID": "20260001",
            "STUNAME": "测试 同学",
            "PARTNER_NAME": "甲方#[]",
            "PARTNER_ID": "20260002",
            "PROJECT_NAME": "共享记账测试项目",
            "REPORT_DATE": "2026-10-16",
        }
        (self.repo / ".env").write_text(
            "".join(f"{key}={shlex.quote(value)}\n" for key, value in self.report_env.items()),
            encoding="utf-8",
        )
        self.git("init", "-q")
        self.git("config", "user.email", "test@example.invalid")
        self.git("config", "user.name", "Test")
        self.git("config", "commit.gpgsign", "false")
        self.git("config", "tag.gpgsign", "false")
        self.git("remote", "add", "origin", "git@example.invalid:student/project.git")
        for name in ("requirements.md", "chat.txt"):
            (self.repo / name).write_text("测试初稿\n", encoding="utf-8")
        self.git("add", "requirements.md", "chat.txt")
        self.git("commit", "-qm", "draft")
        self.git("tag", "lab1-ai-draft")
        for name in ("requirements.md", "chat.txt"):
            (self.repo / name).write_text("最终基线\r\n测试\n", encoding="utf-8")
        self.git("commit", "-qam", "final")
        self.git("tag", "lab1-final")
        self.archive = self.repo / "dist/实验1_20260001_测试 同学.zip"

    def git(self, *args):
        return subprocess.check_output(["git", *args], cwd=self.repo, text=True).strip()

    def submit(self, **env):
        # 从仓库以外运行，也验证脚本定位与含空格路径。
        result = subprocess.run(
            ["bash", str(self.repo / "submit.sh")], cwd="/tmp",
            env={**os.environ, "REPO_URL": "", **env},
            capture_output=True, text=True,
        )
        return result

    def test_archive_and_rebuild(self):
        result = self.submit()
        self.assertEqual(result.returncode, 0, result.stderr)
        prefix = "实验1_20260001_测试 同学/"
        with zipfile.ZipFile(self.archive) as archive:
            files = {name for name in archive.namelist() if not name.endswith("/")}
            self.assertEqual(files, {prefix + name for name in ("request.pdf", "requirements.md", "chat.txt")})
            for name in ("requirements.md", "chat.txt"):
                expected = subprocess.check_output(["git", "show", f"lab1-final:{name}"], cwd=self.repo)
                self.assertEqual(archive.read(prefix + name), expected)
            self.assertEqual(archive.read(prefix + "request.pdf"), (self.repo / "report/request.pdf").read_bytes())
            self.assertTrue(archive.read(prefix + "request.pdf").startswith(b"%PDF-"))
        if shutil.which("pdftotext"):
            text = subprocess.check_output(
                ["pdftotext", str(self.repo / "report/request.pdf"), "-"], text=True,
            )
            for value in self.report_env.values():
                self.assertIn("".join(value.split()), "".join(text.split()))
            self.assertNotIn("待填写学号", text)
            self.assertNotIn("待填写甲方", text)
            self.assertIn("https://example.invalid/student/project", text)
        with zipfile.ZipFile(self.archive, "a") as archive:
            archive.writestr("unwanted.env", "secret")
        result = self.submit()
        self.assertEqual(result.returncode, 0, result.stderr)
        with zipfile.ZipFile(self.archive) as archive:
            self.assertNotIn("unwanted.env", archive.namelist())
        self.assertFalse(list((self.repo / "dist").glob(".submit.*")))

    @unittest.skipUnless(shutil.which("pdftotext"), "需要 pdftotext")
    def test_report_contains_baseline_hashes(self):
        result = self.submit()
        self.assertEqual(result.returncode, 0, result.stderr)
        text = subprocess.check_output(
            ["pdftotext", str(self.repo / "report/request.pdf"), "-"], text=True,
        )
        for tag in ("lab1-ai-draft", "lab1-final"):
            self.assertIn(self.git("rev-parse", tag), text)

    def test_environment_without_dotenv(self):
        (self.repo / ".env").unlink()
        result = self.submit(**self.report_env)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue(self.archive.exists())
        if shutil.which("pdftotext"):
            text = subprocess.check_output(
                ["pdftotext", str(self.repo / "report/request.pdf"), "-"], text=True,
            )
            for value in self.report_env.values():
                self.assertIn("".join(value.split()), "".join(text.split()))

    def test_missing_partner_is_rejected(self):
        with (self.repo / ".env").open("a", encoding="utf-8") as config:
            config.write("PARTNER_NAME=''\n")
        result = self.submit()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("PARTNER_NAME", result.stderr)
        self.assertFalse(self.archive.exists())

    def test_changed_baseline_is_rejected(self):
        (self.repo / "requirements.md").write_text("未提交的修改", encoding="utf-8")
        result = self.submit()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("与 lab1-final 不一致", result.stderr)
        self.assertFalse(self.archive.exists())
        self.assertFalse(list((self.repo / "dist").glob(".submit.*")))

    def test_missing_tag_is_rejected(self):
        self.git("tag", "-d", "lab1-final")
        result = self.submit()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("缺少 lab1-final", result.stderr)
        self.assertFalse(self.archive.exists())

    def test_empty_source_is_rejected(self):
        (self.repo / "chat.txt").write_bytes(b"")
        result = self.submit()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("chat.txt 不存在或为空", result.stderr)

    def test_invalid_identity_is_rejected(self):
        (self.repo / ".env").write_text("STUID=20260001\nSTUNAME='../outside'\n", encoding="utf-8")
        result = self.submit()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("STUNAME", result.stderr)
        self.assertFalse(self.archive.exists())


if __name__ == "__main__":
    unittest.main()
