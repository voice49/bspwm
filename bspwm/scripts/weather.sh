#!/usr/bin/env bash

weather=$(curl -s wttr.in/Galatsi?format=3)

if [ $(echo "$weather" | grep -E "(Unknown|curl|HTML)" | wc -l) -gt 0 ]; then
    echo "WEATHER UNAVAILABLE"
else
    echo "$weather" | awk '{print $2" "$3}'
fi

