#!/usr/bin/env bash

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

pkill xidlehook
# Run xidlehook
/home/nero/.cargo/bin/xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Dim the screen after 60 seconds, undim if user becomes active` \
  --timer 60 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .1' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  `# Undim & lock after 10 more seconds` \
  --timer 20 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1; i3lock -c 000000' \
    '' \
  `# Finally, suspend an hour after it locks` \
  --timer 3600 'systemctl suspend' ''
