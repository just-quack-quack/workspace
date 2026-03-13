#!/usr/bin/env python3
"""
Fetch new robotics papers from arXiv and output as JSON.
"""

import json
import os
import sys
from datetime import datetime, timezone
from pathlib import Path
import urllib.request
import xml.etree.ElementTree as ET

# Configuration
PAPERS_DIR = Path.home() / '.openclaw' / 'workspace' / 'papers'
PAPERS_FILE = PAPERS_DIR / 'sent_papers.txt'
TODAY_FILE = PAPERS_DIR / f'today_papers_{datetime.now().strftime("%Y-%m-%d")}.json'
ARXIV_ROBOTICS = 'http://export.arxiv.org/api/query?search_query=cat:cs.RO&start=0&max_results=15&sortBy=submittedDate&sortOrder=descending'

def ensure_dirs():
    """Create necessary directories."""
    PAPERS_DIR.mkdir(parents=True, exist_ok=True)

def get_sent_papers():
    """Load list of papers we've already sent."""
    if PAPERS_FILE.exists():
        return set(PAPERS_FILE.read_text().strip().split('\n'))
    return set()

def save_sent_papers(paper_ids):
    """Save list of sent papers."""
    PAPERS_FILE.write_text('\n'.join(sorted(paper_ids)))

def parse_arxiv_xml(xml_text):
    """Parse arXiv XML response and extract paper data."""
    root = ET.fromstring(xml_text)

    # arXiv uses Atom namespace
    ns = {
        'atom': 'http://www.w3.org/2005/Atom',
        'arxiv': 'http://arxiv.org/schemas/atom'
    }

    papers = []
    for entry in root.findall('atom:entry', ns):
        # Extract arXiv ID from the URL
        paper_id_elem = entry.find('atom:id', ns)
        if paper_id_elem is None:
            continue

        paper_url = paper_id_elem.text
        # Extract ID like "2603.12263v1" from URL
        if 'arxiv.org/abs/' in paper_url:
            paper_id = paper_url.split('arxiv.org/abs/')[1]
        else:
            continue

        # Extract title
        title_elem = entry.find('atom:title', ns)
        title = title_elem.text.strip() if title_elem is not None else "No title"

        # Extract summary (abstract)
        summary_elem = entry.find('atom:summary', ns)
        summary = summary_elem.text.strip() if summary_elem is not None else "No abstract"
        # Clean up whitespace
        summary = ' '.join(summary.split())

        # Extract published date
        published_elem = entry.find('atom:published', ns)
        published = published_elem.text.split('T')[0] if published_elem is not None else "unknown"

        # Extract authors
        authors = []
        for author_elem in entry.findall('atom:author', ns):
            name_elem = author_elem.find('atom:name', ns)
            if name_elem is not None:
                authors.append(name_elem.text.strip())

        paper = {
            'id': paper_id,
            'title': title,
            'summary': summary,
            'published': published,
            'url': f'https://arxiv.org/abs/{paper_id}',
            'authors': authors
        }

        papers.append(paper)

    return papers

def fetch_papers():
    """Fetch papers from arXiv."""
    print("Fetching papers from arXiv...", file=sys.stderr)

    with urllib.request.urlopen(ARXIV_ROBOTICS) as response:
        xml_text = response.read().decode('utf-8')

    return parse_arxiv_xml(xml_text)

def main():
    ensure_dirs()

    # Check if we've already fetched papers today
    if TODAY_FILE.exists():
        print(f"Already fetched papers for {TODAY_FILE.stem}", file=sys.stderr)
        print(TODAY_FILE.read_text())
        return

    # Get papers
    all_papers = fetch_papers()
    sent_papers = get_sent_papers()

    # Filter out already-sent papers
    new_papers = [p for p in all_papers if p['id'] not in sent_papers]

    # Save new papers to today's file
    output = {
        'date': datetime.now().strftime('%Y-%m-%d'),
        'count': len(new_papers),
        'papers': new_papers
    }

    TODAY_FILE.write_text(json.dumps(output, indent=2))

    # Update sent papers list
    new_ids = [p['id'] for p in new_papers]
    updated_sent = sent_papers.union(set(new_ids))
    save_sent_papers(updated_sent)

    print(f"Fetched {len(new_papers)} new papers", file=sys.stderr)
    print(json.dumps(output, indent=2))

if __name__ == '__main__':
    main()
