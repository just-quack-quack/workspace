#!/bin/bash
# Daily research workflow - run at 9:00 AM Vietnam time
# Runs: fetch papers -> send telegram -> update dashboard -> ingest -> research workflow

# Fetch robotics papers
echo "$(date): Fetching robotics papers..."
python3 ~/.openclaw/workspace/scripts/fetch_robotics_papers.py

# Update quack dashboard
echo "$(date): Updating quack dashboard..."
python3 ~/.openclaw/workspace/quack-dashboard/heartbeat_update.py update-research

# Ingest to repo
echo "$(date): Ingesting papers to repo..."
python3 ~/.openclaw/workspace/research-ingest/ingest_papers.py

# Push research-ingest to github
echo "$(date): Pushing research-ingest to github..."
cd ~/.openclaw/workspace/research-ingest && git add -A && git commit -m "ingest: add new papers $(date +%Y-%m-%d)" && git push

# Run research workflow
echo "$(date): Running research workflow..."
cd ~/.openclaw/workspace/research-system && uv run python daily_workflow.py

echo "$(date): Daily research workflow complete!"
