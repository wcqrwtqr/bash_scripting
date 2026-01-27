#! /bin/bash

# 25 Dec 2025, I've made this code after asking warp agent to show me how to know if an app was
# used in the past few months so I can delete it or my system needs it.
# So it made several steps and I put it in this script.

appName=$1

echo "============================================"
echo "Check the sta of" $appName
echo "============================================"
stat -f "%Sa %N" -t "%Y-%m-%d %H:%M:%S" $(which $appName)

echo "============================================"
echo "Check the zsh history of" $appName
echo "============================================"
grep -i $appName ~/.zsh_history

echo "============================================"
echo "Check process of" $appName
echo "============================================"
log show --predicate "process == \"$appName\"" --info --last 30d

echo "============================================"
echo "Check brew info of" $appName
echo "============================================"
brew info $appName

echo "============================================"
echo "Check brew dependancies of" $appName
echo "============================================"
brew uses --installed $appName
