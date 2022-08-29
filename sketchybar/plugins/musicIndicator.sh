#!/usr/bin/env bash
RUNNING=$(osascript -e 'if application "Music" is running then return 0')
if [ "$RUNNING" == "" ]; then
  RUNNING=1
fi
PLAYING=1
TRACK=""
ALBUM=""
ARTIST=""

# if [ "$(osascript -e 'if application "Music" is running then tell application "Music" to get player state')" == "playing" ]; then
if [ $RUNNING -eq 0 ]; then
  if [ "$(osascript -e 'tell application "Music" to get player state')" == "playing" ]; then
    # label=""
    icon=""
    highlight="off"
  elif [ "$(osascript -e 'tell application "Music" to get player state')" == "paused" ]; then
    # label=""
    icon=""
    highlight="on"
  elif [ "$(osascript -e 'tell application "Music" to get player state')" == "stopped" ]; then
    # label=""
    icon=""
    highlight="on"
  fi
  TRACK=$(osascript -e 'tell application "Music" to get name of current track')
  ARTIST=$(osascript -e 'tell application "Music" to get artist of current track')
  ALBUM=$(osascript -e 'tell application "Music" to get album of current track')
  if [ "$ARTIST" == "" ]; then
    label+="  $TRACK  $ALBUM"
  else
    label+="  $TRACK  $ARTIST"
  fi
  sketchybar --set $NAME label="$label" icon="$icon" icon.highlight=$highlight
else
  sketchybar --set $NAME label="" icon=""
fi

