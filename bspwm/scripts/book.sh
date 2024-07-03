#!/bin/bash

BOOKMARKS_FILE="$HOME/Templates/bookmarks.txt"

# Function to show a notification
show_notification() {
    notify-send "Bookmark Manager" "$1"
}

# Function to add a bookmark
add_bookmark() {
    read -p "Enter bookmark name: " name
    read -p "Enter bookmark URL: " url

    # Append the new bookmark to the file
    echo "$name $url" >> "$BOOKMARKS_FILE"

    # Copy the URL to the clipboard using xclip
    echo "$url" | xclip -selection clipboard
    show_notification "Bookmark '$name' added. URL copied to clipboard!"
}

# Function to remove a bookmark
remove_bookmark() {
    # Read bookmarks from the file and format them for Rofi
    BOOKMARKS=$(awk '{print $1}' "$BOOKMARKS_FILE")

    # Show Rofi for bookmark selection
    selected=$(echo -e "$BOOKMARKS" | rofi -dmenu -i -p "Select Bookmark to Remove")

    # If a bookmark is selected, remove it from the file
    if [ -n "$selected" ]; then
        sed -i "/^$selected/d" "$BOOKMARKS_FILE"
        show_notification "Bookmark '$selected' removed."
    fi
}

# Function to show a list of bookmarks
list_bookmarks() {
    # Read bookmarks from the file
    BOOKMARKS=$(cat "$BOOKMARKS_FILE")

    # Show Rofi with the list of bookmarks
    selected=$(echo -e "$BOOKMARKS" | rofi -dmenu -i -p "Select Bookmark")

    # If a bookmark is selected, open it in the default browser
    if [ -n "$selected" ]; then
        URL=$(echo "$selected" | awk '{print $2}')
        xdg-open "$URL"
    fi
}

# Show Rofi with options to Add, Remove, List, or Open bookmarks
selected=$(echo -e "Add\nRemove\nList\nOpen\n" | rofi -dmenu -i -p "Bookmarks")

case $selected in
    "Add")
        add_bookmark;;
    "Remove")
        remove_bookmark;;
    "List")
        list_bookmarks;;
    "Open")
        # If Open is selected, open a specific bookmark
        read -p "Enter bookmark name: " bookmark_name
        URL=$(grep "^$bookmark_name" "$BOOKMARKS_FILE" | awk '{print $2}')
        xdg-open "$URL";;
    *)
        # If a bookmark is selected, open it in the default browser
        if [ -n "$selected" ]; then
            URL=$(grep "^$selected" "$BOOKMARKS_FILE" | awk '{print $2}')
            xdg-open "$URL"
        fi
        ;;
esac
