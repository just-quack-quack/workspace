# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## Communication Channels

- **Telegram** → normal chat (here)
- **tmux session "main"** → binh's screen on his desk - can send commands/messages there

## GitHub Access

- **Account:** Dposion ([github.com/Dposion](https://github.com/Dposion))
- **CLI:** gh (installed and authenticated)
- **Permissions:** gist, read:org, repo, workflow
- **Can:** create repos, gists, PRs, issues, manage workflows

## Research Ingest Repo

- **Name:** research-ingest
- **URL:** https://github.com/Dposion/research-ingest
- **Purpose:** Archive of all robotics papers ingested from arXiv
- **Structure:** papers/YYYY/YYYY-MM-DD-arxivID.md
- **Workflow:** fetch → ingest → commit → push
- **Script:** `research-ingest/ingest_papers.py`

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.
