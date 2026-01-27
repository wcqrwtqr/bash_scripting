#!/bin/bash

# Check if file path is provided
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <file_path> [times]"
  exit 1
fi

# Assign file path and times (default if not provided)
file_path="$1"
times="${2:-15:31:44,15:41:45,15:51:46}" # Default times if not provided

# Run AWK with the file path and times
awk -v times="$times" '
BEGIN { split(times, target_times, ",") }
{
    for (t in target_times) {
        if ($2 == target_times[t]) {
            for (i = -5; i <= 5; i++) {
                line_num = NR + i
                if (line_num > 0) {
                    system("sed -n " line_num "p " FILENAME)
                }
            }
        }
    }
}' "$file_path"
