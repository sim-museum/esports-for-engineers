#!/bin/bash
while IFS= read -r line; do
  xrandr --output $line --auto
done

