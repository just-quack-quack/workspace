# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## Communication Channels

- **Telegram** → normal chat (here)
- **tmux session "main"** → binh's screen on his desk - can send commands/messages there

## Audio Transcription

- **Tool:** whisper-ctranslate2 (faster than original whisper)
- **Model:** tiny (fast, good accuracy)
- **Script:** `scripts/transcribe.sh <audio_file>`
- **Supported formats:** wav, mp3, ogg, m4a, flac
- **Language:** English (auto-detected)
- **Transcriptions saved to:** `~/.openclaw/workspace/transcriptions/`

**Usage:**
```bash
bash ~/.openclaw/workspace/scripts/transcribe.sh /path/to/audio.ogg
```

## Python Development

- **Package Manager:** uv (required for all Python projects)
- **Version:** 0.10.9
- **Why:** Fast, modern, better than pip
- **Location:** `~/.local/bin/uv`

**Commands:**
```bash
# Create new project
uv init project-name

# Add dependencies
uv add package-name

# Run scripts in project
uv run python script.py

# Install from requirements
uv pip install -r requirements.txt
```

## GitHub Access

- **Account:** just-quack-quack ([github.com/just-quack-quack](https://github.com/just-quack-quack))
- **CLI:** gh (installed and authenticated)
- **Permissions:** gist, read:org, repo, workflow
- **Can:** create repos, gists, PRs, issues, manage workflows

## Research Ingest Repo

- **Name:** research-ingest
- **URL:** https://github.com/just-quack-quack/research-ingest
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
