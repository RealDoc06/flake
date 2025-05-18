#!/bin/bash
monitor=$(hyprctl activeworkspace -j | jq -r .monitor)
grim -o "$monitor" - | wl-copy
