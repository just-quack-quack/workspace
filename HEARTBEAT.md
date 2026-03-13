# HEARTBEAT.md

# Keep this file empty (or with only comments) to skip heartbeat API calls.

# Add tasks below when you want the agent to check something periodically.

## Daily Tasks

### 9:00 AM Vietnam Time (GMT+7) - Robotics Papers Update

- Check if it's past 9am vietnam time (Asia/Saigon timezone)
- If yes and haven't sent papers today:
  - Run: `python3 ~/.openclaw/workspace/scripts/fetch_robotics_papers.py`
  - Format papers for telegram (title, authors, 2-line summary, link)
  - Send to binh via telegram
  - Send to tmux screen if he's watching

**State tracking:**
- Papers saved to: `~/.openclaw/workspace/papers/today_papers_YYYY-MM-DD.json`
- Sent papers tracked: `~/.openclaw/workspace/papers/sent_papers.txt`
- Send time tracked: `~/.openclaw/workspace/papers/last_sent_YYYY-MM-DD.txt`
