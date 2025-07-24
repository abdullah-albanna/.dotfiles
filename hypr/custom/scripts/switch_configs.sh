#!/usr/bin/env fish

set CONF ~/.config/hypr/hyprland.conf

if grep -q 'qsConfig = ii' $CONF
    sed -i 's/qsConfig = ii/qsConfig = caelestia/' $CONF
    set -Ux qsConfig caelestia
    notify-send "Switched config to caelestia"
else
    sed -i 's/qsConfig = caelestia/qsConfig = ii/' $CONF
    set -Ux qsConfig ii
    notify-send "Switched config to ii"
end
