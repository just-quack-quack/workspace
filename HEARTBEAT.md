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
  - Update quack dashboard: `python3 ~/.openclaw/workspace/quack-dashboard/heartbeat_update.py update-research`
  - Ingest to repo: `python3 ~/.openclaw/workspace/research-ingest/ingest_papers.py`
  - Push research-ingest to github

**State tracking:**
- Papers saved to: `~/.openclaw/workspace/papers/today_papers_YYYY-MM-DD.json`
- Sent papers tracked: `~/.openclaw/workspace/papers/sent_papers.txt`
- Dashboard data: `~/.openclaw/workspace/quack-dashboard/data/`

### Every Heartbeat - Dashboard Updates

Always update quack dashboard during heartbeats:
- Check if dashboard tmux session is running (`tmux has-session -t dashboard`)
- If papers were fetched and ingested today, update research panel
- Add any active tasks to tasks panel
- Update system status panel
- Dashboard refreshes automatically every 5 seconds
