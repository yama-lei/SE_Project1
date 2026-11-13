# Dev rules
- Commit only after the user gives permission.
- Use `{chore,feat,bugs,docs}/slug: content` for commit messages. Add the `ai-` prefix when the commit should be marked as AI-generated. Otherwise, omit it.
- If you find conflicting content or opportunities for improvement, notify the user and obtain permission before making changes. Examples include improving grammar and clarity in `AGENTS.md` and fixing bugs in code.


# Dev notes
- Run  `npx -y @penpot/mcp@latest` to start server  and connect http://localhost:4401/mcp (in .mcp.json) to design ui. See https://github.com/penpot/penpot/blob/develop/mcp/README.md