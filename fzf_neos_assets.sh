#!/usr/bin/env sh

# Author: Mohammed Albatati
# Date: 20251110
# Get the Asset details using fzf
#

set -e
# Ensure the asset csv file is available and if not then create it
[ ! -f "~/org/Exported_database_20251110.csv" ] && echo 'File not available at temp directory  Creating a new csv file'

fzfAssets() {
  # grepID= awk -F"," '{print $1"|"$2"|"$3"|"$4"|"$5"|"$6"|"$7"|"$8"|"$9"|"$10"|"$11"|"$12"|"$13}' "/Users/mohammedalbatati/org/Exported_database_20251110.csv" | fzf -m # Working code but looks not so good in the output
  grepID= awk -F"," '{printf "%-8s %-12s %-20s %-20s %-5s %-10s %-5s %-5s %-5s %-5s %-5s %-5s %-5s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13}' "/Users/mohammedalbatati/org/Exported_database_20251110.csv" | fzf -m
  echo $grepID
}

fzfAssets
