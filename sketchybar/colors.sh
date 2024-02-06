#!/bin/bash

# background-alt = #3d4150
# background = #1f2430
# foreground = #DADBC0
# foreground-alt = #484d5e

# primary = #8BCBD6
# secondary = #BAE67D

# success = #40916c
# alert = #d23c3d

# colors
export DARK_GUNMETAL=0xff1f2430
export LIGHT_GUNMETAL=0xff3d4150
export BONE=0xffDADBC0
export RED=0xffd23c3d
export GREEN=0xff40916c

# General bar colors
export BAR_COLOR=$DARK_GUNMETAL
export LABEL_COLOR=$BONE

export CHARGED_BATTERY_COLOR=$GREEN
export LOW_BATTERY_COLOR=$RED
export FILLED_SPACE_LABEL_COLOR=$BONE
export EMPTY_SPACE_ICON_COLOR=$LIGHT_GUNMETAL

export WIDGET_LABEL_COLOR=$BONE
export WIDGET_LABEL_BG_COLOR=$LIGHT_GUNMETAL
export WIDGET_ICON_COLOR=$DARK_GUNMETAL
export WIDGET_ICON_BG_COLOR=$BONE
