#!/usr/bin/env bash

# NOTE: This script is a temporary solution for tweet generation.
# It will be replaced by a Rust implementation for automation in the future.

TWEET_CONTENT="$1"
MAX_CHARS=25000 # X Premium character limit

if [ -z "$TWEET_CONTENT" ]; then
  echo "Usage: $0 \"Your tweet content here\""
  exit 1
fi

TWEET_LENGTH=${#TWEET_CONTENT}

echo "--- Your Tweet ---"
echo "$TWEET_CONTENT"
echo "------------------"
echo "Character count: $TWEET_LENGTH / $MAX_CHARS"

if (( TWEET_LENGTH > MAX_CHARS )); then
  echo "WARNING: Tweet exceeds character limit!"
fi
