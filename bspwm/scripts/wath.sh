#!/bin/bash

# Define Rofi options for location selection
ROFI_LOC_OPTIONS="-dmenu -i -p \"Select Location\" -lines 3 -font 'Noto Sans 10' -theme ~/.config/rofi/Dracula.rasi"

# Prompt user to select a location
selected_location=$(echo -e "Galatsi\nOther" | rofi $ROFI_LOC_OPTIONS)

# Check the selected location
case $selected_location in
    Galatsi)
        CITY="Galatsi"
        ;;
    Other)
        # Prompt user for a custom location
        CITY=$(rofi -dmenu -p "Enter Location" -lines 1 -font 'Jetbrains Mono 12' -theme ~/.config/rofi/Dracula.rasi)
        ;;
    *)
        # Handle other options or exit
        exit 0
        ;;
esac

# Define Rofi options for weather selection
ROFI_WEATHER_OPTIONS="-dmenu -i -p \"$CITY Weather\" -lines 3 -font 'Jetbrains Mono 12' -theme ~/.config/rofi/Dracula.rasi"

# Display weather options using Rofi
selected_option=$(echo -e "Now\nTomorrow\nWeek" | rofi $ROFI_WEATHER_OPTIONS)

# Show weather forecast based on selected option
case $selected_option in
    Now)
        alacritty --hold -e wttr $CITY
        ;;
    Tomorrow)
        alacritty --hold -e wttr --forecast $CITY
        ;;
    Week)
        alacritty --hold -e wttr --forecast --days 7 $CITY
        ;;
    *)
        # Handle other options or do nothing
        ;;
esac
