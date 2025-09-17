#!/usr/bin/env bash

# NOTE: This script is a temporary solution for logging tweet confirmations.
# It will be replaced by a Rust implementation for automation in the future.

LOG_SCRIPT="/data/data/com.termux.nix/files/home/pick-up-nix/source/github/meta-introspector/streamofrandom/scripts/log_to_fiber.sh"

CONFIRMATION_URL="$1"

if [ -z "$CONFIRMATION_URL" ]; then
  echo "Usage: $0 <confirmation_url>"
  exit 1
fi

LOG_MESSAGE="Tweet successfully posted: $CONFIRMATION_URL"
LOG_TYPE="Tweet Confirmation"

"$LOG_SCRIPT" "$LOG_MESSAGE" "$LOG_TYPE"

echo "Confirmation logged to fiber log."
