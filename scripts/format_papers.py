#!/usr/bin/env python3
"""
Format robotics papers for telegram display.
"""

import json
import sys
from datetime import datetime
from pathlib import Path

TODAY_FILE = Path.home() / '.openclaw' / 'workspace' / 'papers' / f'today_papers_{datetime.now().strftime("%Y-%m-%d")}.json'

def format_papers(papers_data):
    """Format papers data for telegram message."""
    if not papers_data or papers_data.get('count', 0) == 0:
        return "📚 No new robotics papers today."

    date = papers_data.get('date', 'today')
    count = papers_data.get('count', 0)
    papers = papers_data.get('papers', [])

    # Build message
    lines = [
        f"🤖 Robotics Papers Update - {date}",
        f"",
        f"📊 {count} new papers from arXiv:",
        f"",
        f"---"
    ]

    for i, paper in enumerate(papers, 1):
        title = paper.get('title', 'No title')
        summary = paper.get('summary', 'No abstract')
        url = paper.get('url', '')
        authors = paper.get('authors', [])

        # Truncate summary to 2 lines (roughly 200 chars)
        if len(summary) > 200:
            summary = summary[:197] + "..."

        # Format authors (first 2, then + more)
        if len(authors) > 2:
            author_str = f"{authors[0]}, {authors[1]} +{len(authors)-2}"
        elif authors:
            author_str = ", ".join(authors)
        else:
            author_str = "Unknown authors"

        lines.extend([
            f"",
            f"📄 Paper {i}:",
            f"🔗 {url}",
            f"👤 {author_str}",
            f"",
            f"{title}",
            f"",
            f"{summary}",
            f"---"
        ])

    lines.extend([
        "",
        f"Full list: https://arxiv.org/list/cs.RO/recent",
        "",
        f"🦆 ~ quack quack"
    ])

    return "\n".join(lines)

def main():
    if len(sys.argv) < 2:
        print("Usage: format_papers.py <json_file>", file=sys.stderr)
        sys.exit(1)

    json_file = sys.argv[1]
    with open(json_file) as f:
        papers_data = json.load(f)

    print(format_papers(papers_data))

if __name__ == '__main__':
    main()
