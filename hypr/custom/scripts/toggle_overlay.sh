#!/usr/bin/env bash

CONF=~/.config/hypr/custom/general.conf

if grep -q "overlay = true" "$CONF"; then
  sed -i 's/overlay = true/overlay = false/' "$CONF"
else
  sed -i 's/overlay = false/overlay = true/' "$CONF"
fi

# hyprctl reload
