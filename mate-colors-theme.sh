#!/bin/bash

BG_COLOR="#0C0D0E"
FG_COLOR="#FCFDFE"
PALETTE_OCEANIC_NEXT="#1B2B34:#E06C75:#99C794:#FAC863:#6699CC:#C594C5:#5FB3B3:#A7ADBA:#4F5B66:#EC5F67:#99C794:#FAC863:#6699CC:#C594C5:#5FB3B3:#D8DEE9"
PALETTE_BASE16_BREWER="#0C0D0E:#E31A1C:#31A354:#DCA060:#3182BD:#756BB1:#80B1D3:#B7B8B9:#737475:#E31A1C:#31A354:#DCA060:#3182BD:#756BB1:#80B1D3:#FCFDFE"
PALETTE_BASE16_BRIGHT="#000000:#fb0120:#a1c659:#fda331:#6fb3d2:#d381c3:#76c7b7:#e0e0e0:#b0b0b0:#fb0120:#a1c659:#fda331:#6fb3d2:#d381c3:#76c7b7:#ffffff"

dconf write /org/mate/terminal/profiles/default/palette "'$PALETTE_BASE16_BRIGHT'"
dconf write /org/mate/terminal/profiles/default/background_color "'$BG_COLOR'"
dconf write /org/mate/terminal/profiles/default/foreground_color "'$FG_COLOR'"
