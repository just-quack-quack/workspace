# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## Communication Channels

- **Telegram** → normal chat (here)
- **tmux session "main"** → binh's screen on his desk - can send commands/messages there
- **tmux session "dashboard"** → quack dashboard running with textual TUI

## Quack Dashboard

- **Name:** quack-dashboard
- **URL:** https://github.com/just-quack-quack/quack-dashboard
- **Framework:** Textual (terminal UI)
- **Location:** `~/.openclaw/workspace/quack-dashboard/`
- **Tmux session:** `main` (binh's desk screen)

**Panels:**
- 📊 Daily Research - arXiv robotics papers
- 📝 Active Tasks - current projects and work
- 🔧 System Status - system information and health

**Usage:**
```bash
# Start dashboard (runs in main session, shows on desk screen)
cd ~/.openclaw/workspace/quack-dashboard && ./start.sh

# Dashboard is visible on binh's desk screen
# To interact directly: tmux attach -t main

# Stop dashboard
tmux send-keys -t main C-c
```

**Heartbeat Integration:**
```bash
# Update research panel
python3 ~/.openclaw/workspace/quack-dashboard/heartbeat_update.py update-research

# Add task
python3 ~/.openclaw/workspace/quack-dashboard/heartbeat_update.py add-task "Working on X" active

# Update status
python3 ~/.openclaw/workspace/quack-dashboard/heartbeat_update.py update-status
```

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

## Research System

- **Name:** research-system
- **URL:** https://github.com/just-quack-quack/research-system
- **Purpose:** Help binh publish 1 novel paper or article every month
- **Location:** `~/.openclaw/workspace/research-system/`

**Components:**
- **research_analyzer.py** - Analyze arXiv papers and suggest directions
- **experiment_runner.py** - Create and track experiments for ideas
- **monthly_tracker.py** - Track progress toward monthly publication goal
- **daily_workflow.py** - Automated daily workflow

**Usage:**
```bash
# Run daily research workflow (after paper ingestion)
cd ~/.openclaw/workspace/research-system
uv run python daily_workflow.py

# Check monthly progress
uv run python monthly_tracker.py progress

# Create experiment manually
uv run python experiment_runner.py create '<idea_json>'
```

**Output:**
- Daily research suggestions and analysis
- Experiment directories with implementation templates
- Monthly goal tracking (ideas, experiments, drafts)
- Progress reports for publication goal

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
