#!/bin/bash

killall stalonetray
stalonetray &
polybar-msg hook tray 2 &

