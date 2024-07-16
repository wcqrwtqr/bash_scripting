#!/usr/bin/env sh

# Author: Mohammed Albatati
# Date: 06 Jan 2024
# Get the crew ID's and initial information
# This script is to search for my best movie on the webpage and check if its available
# for wachting or not!, very simple 😁


result=$(http "https://cimaclub.us" | grep -o "jujutsu-kaisen" | head -n 1)

if [ -n "$result" ]; then
    echo "Let's watch jujutsu"
else
    echo "No result"
fi
