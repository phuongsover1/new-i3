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
  `# Undim & lock after 10 more seconds` \
  --timer 300 \
    '/home/nero/.config/i3/i3lock.sh' \
    '' \
  `# Finally, suspend an hour after it locks` \
  --timer 1000 'systemctl suspend' ''
