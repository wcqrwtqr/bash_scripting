#!/usr/bin/env sh

# Prompt the user for input
read -p "Input the chapter number: " chapter_number

# line=$(awk -F"," '{print $1}' "/Users/mohammedalbatati/.myrepos/bash_scripting/bible parsing/bible_list.txt" | fzf)
line=$(awk -F"," '{print $1}' "/Users/mohammedalbatati/.myrepos/bash_scripting/bible parsing/bible_list_for_chapter.txt" | fzf)
# Construct the URL with the provided numbers
# https://biblehub.com/niv/john/8.htm
url="$line${chapter_number}.htm"
echo "$url"
# Execute the command with the constructed URL
command="http \"$url\" | pup 'div.chap text{}'"
content=$(eval "$command")
echo "$content"
