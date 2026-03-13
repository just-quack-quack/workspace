#!/bin/bash
# Fetch new robotics papers from arXiv
# Output: JSON with paper metadata

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PAPERS_DIR="$HOME/.openclaw/workspace/papers"
PAPERS_FILE="$PAPERS_DIR/sent_papers.txt"
TODAY_FILE="$PAPERS_DIR/today_papers.json"

mkdir -p "$PAPERS_DIR"

# Get today's date in Vietnam time (GMT+7)
TODAY=$(TZ='Asia/Saigon' date +%Y-%m-%d)

# Check if we've already fetched papers today
if [ -f "$TODAY_FILE" ]; then
    echo "Already fetched papers for $TODAY"
    cat "$TODAY_FILE"
    exit 0
fi

# Query arXiv robotics category
# Get papers submitted in the last 24 hours
ARXIV_QUERY="search_query=cat:cs.RO&start=0&max_results=15&sortBy=submittedDate&sortOrder=descending"

echo "Fetching papers from arXiv..." >&2

# Fetch and parse arXiv response
ARXIV_XML=$(curl -s "https://export.arxiv.org/api/query?$ARXIV_QUERY")

# Start JSON file
echo '[' > "$TODAY_FILE"

# Process entries - use a temp file to avoid subshell issues
TEMP_FILE=$(mktemp)

# Extract each entry and build JSON
echo "$ARXIV_XML" | grep -o '<entry[^>]*>.*</entry>' | nl -w1 -s'|' | while IFS='|' read -r num entry; do
    # Extract fields
    TITLE=$(echo "$entry" | sed -n 's/.*<title>\(.*\)<\/title>.*/\1/p' | head -1)
    ARXIV_ID=$(echo "$entry" | sed -n 's/.*<id>http:\/\/arxiv\.org\/abs\/\([^<]*\)<\/id>.*/\1/p' | head -1)
    SUMMARY=$(echo "$entry" | sed -n 's/.*<summary>\(.*\)<\/summary>.*/\1/p' | head -1 | tr '\n' ' ')
    PUBLISHED=$(echo "$entry" | sed -n 's/.*<published>\([^<]*\)<\/published>.*/\1/p' | head -1 | cut -dT -f1)

    # Skip if no arXiv ID
    [ -z "$ARXIV_ID" ] && continue

    # Check if we've already sent this paper
    if grep -q "^$ARXIV_ID$" "$PAPERS_FILE" 2>/dev/null; then
        continue
    fi

    # Clean up summary
    SUMMARY=$(echo "$SUMMARY" | sed 's/&amp;/\&/g; s/&lt;/</g; s/&gt;/>/g; s/&quot;/"/g; s/&#39;/'"'"'/g' | tr -s ' ')

    # Build JSON entry
    if [ "$num" -gt 1 ]; then
        echo ',' >> "$TEMP_FILE"
    fi

    cat >> "$TEMP_FILE" << EOF
{
  "id": "$ARXIV_ID",
  "title": "$TITLE",
  "summary": "$SUMMARY",
  "published": "$PUBLISHED",
  "url": "https://arxiv.org/abs/$ARXIV_ID"
}
EOF

    # Mark as sent
    echo "$ARXIV_ID" >> "$PAPERS_FILE"
done

# Append temp file to main JSON file
cat "$TEMP_FILE" >> "$TODAY_FILE"
echo ']' >> "$TODAY_FILE"

# Clean up
rm -f "$TEMP_FILE"

# Output results
PAPER_COUNT=$(grep -c '"id":' "$TODAY_FILE" 2>/dev/null || echo "0")
echo "Fetched $PAPER_COUNT new papers" >&2
cat "$TODAY_FILE"
