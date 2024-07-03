#!/bin/bash

# Run wttr.in in XFCE4 terminal
#xfce4-terminal --hold -e wttr 
alacritty --hold -e wttr  galatsi


# Wait for 30 seconds
sleep 30

# Close the terminal
xdotool key Ctrl+Shift+Q