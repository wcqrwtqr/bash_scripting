#!/usr/bin/env sh

# line= awk -F"," '{print $1}' "bible.txt" | fzf
# command=$(echo "$line")
# content=$(eval "$command")
# echo "$content"

# Prompt the user for input
read -p "Input the first number: " first_number
read -p "Input the second number: " second_number

line=$(awk -F"," '{print $1}' "/Users/mohammedalbatati/.myrepos/bash_scripting/bible parsing/bible_list.txt" | fzf)
# Construct the URL with the provided numbers
url="$line${first_number}-${second_number}.htm"
echo "$url"
# Execute the command with the constructed URL
command="http \"$url\" | pup 'div#par text{}' | grep -A 1 -e 'James' -e 'New'"
content=$(eval "$command")
echo "$content"
