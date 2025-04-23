#!/bin/bash

# @TODO: fetch the user dynamically or from config
export XDG_RUNTIME_DIR=/run/user/1000

# Get number of URLs and sleep time from config
CONFIG="/opt/piosk/config.json"
URLS=$(jq -r '.urls | length' "$CONFIG")
SLEEP=$(jq -r '.sleep // 10' "$CONFIG")

# switch tabs each $SLEEP seconds, refresh tabs each 10th cycle & then reset
for ((TURN=1; TURN<=$((10*URLS)); TURN++)) do
  if [ $TURN -le $((10*URLS)) ]; then
    wtype -M ctrl -P Tab
    if [ $TURN -gt $((9*URLS)) ]; then
      wtype -M ctrl r
      if [ $TURN -eq $((10*URLS)) ]; then
        (( TURN=0 ))
      fi
    fi
  fi
  sleep "$SLEEP"
done
