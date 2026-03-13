#!/bin/bash
# Transcribe audio file using whisper-ctranslate2

if [ -z "$1" ]; then
    echo "Usage: $0 <audio_file>"
    echo "Supported formats: wav, mp3, ogg, m4a, flac"
    exit 1
fi

AUDIO_FILE="$1"
OUTPUT_DIR="$HOME/.openclaw/workspace/transcriptions"
mkdir -p "$OUTPUT_DIR"

# Get base filename without extension
BASENAME=$(basename "$AUDIO_FILE" | sed 's/\.[^.]*$//')
OUTPUT_FILE="$OUTPUT_DIR/${BASENAME}.txt"

echo "Transcribing: $AUDIO_FILE"
echo "Model: tiny (fast, good accuracy)"
echo ""

# Transcribe using tiny model (fastest)
whisper-ctranslate2 --model tiny --language en --output_format txt --output_dir "$OUTPUT_DIR" "$AUDIO_FILE"

echo ""
echo "Transcription saved to: $OUTPUT_FILE"
echo ""
echo "--- Transcription ---"
cat "$OUTPUT_FILE"
