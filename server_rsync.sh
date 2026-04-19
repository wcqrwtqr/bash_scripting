#!/usr/bin/env bash
source /usr/local/bin/bash_colors.sh

# Created on: 11 Oct 2024
# rsync NEOS files and folder from the server to my hard desk
# if ! mount | grep -q WL-SL ; then
#     echo -e "${RED}The mount /Volumes/WL-SL/ not available${NC}"
#     exit 1
# fi
if ! mount | grep -q Passport ; then
    echo "Hard desk is not installed"
    exit 10
fi

# rsync WTS foldes and files with absolute paths so I can run it from any place
# echo -e "${GREEN}Sync files of Downloads${NC}"
# rsync -avzr --progress --delete /Volumes/WL-SL/ /Volumes/My\ Passport\ for\ Mac/NEOS/Server\ Backup/WL-SL/

# rsync WTS foldes and files with absolute paths so I can run it from any place
# echo "Rsync files of WTS"
# rsync -avzr --progress --delete /Volumes/WTS/ /Volumes/My\ Passport\ for\
# Mac/NEOS/Server\ Backup/WTS/

# echo "Sync the html script for webpage"
# rsync -avzr --progress --delete ~/Desktop/html_generator/ ~/.myrepos/NEOS-html

echo -e "${YELLOW}Sync files of Downloads to hard desk${NC}"
rsync -avzr --progress --delete \
    --exclude='.env' \
    --exclude='.env.*' \
    --exclude='*.py' \
    --exclude='*.pyc' \
    --exclude='__pycache__/' \
    ~/Downloads /Volumes/My\ Passport\ for\ Mac/2025_backup/Downloads/
