#!/bin/bash
while IFS= read -r line; do
  xrandr --output $line --mode 1024x768
done

