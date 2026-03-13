#!/usr/bin/env python3
"""
Transcribe audio file sent by binh via telegram.
Usage: python3 transcribe_telegram.py <audio_file_path>
"""

import sys
import subprocess
from pathlib import Path

# Configuration
TRANSCRIBE_SCRIPT = Path.home() / '.openclaw' / 'workspace' / 'scripts' / 'transcribe.sh'

def transcribe_audio(audio_path):
    """Transcribe audio file using whisper-ctranslate2."""
    result = subprocess.run(
        [str(TRANSCRIBE_SCRIPT), audio_path],
        capture_output=True,
        text=True
    )

    if result.returncode == 0:
        return result.stdout
    else:
        return f"Error transcribing audio: {result.stderr}"

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 transcribe_telegram.py <audio_file_path>")
        sys.exit(1)

    audio_path = sys.argv[1]

    if not Path(audio_path).exists():
        print(f"Error: Audio file not found: {audio_path}")
        sys.exit(1)

    print(f"🎤 Transcribing audio...")
    transcription = transcribe_audio(audio_path)
    print(transcription)

if __name__ == '__main__':
    main()
