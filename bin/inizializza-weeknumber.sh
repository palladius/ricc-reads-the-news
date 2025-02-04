#! /bin/bash

# https://stackoverflow.com/questions/70226713/how-do-i-get-next-week-number-in-bash
#WEEK_NUMBER=$(echo $(($(date +%-V)+1)))
WEEK_NUMBER=$(echo $(($(date +%-V))))


verde "WK=$WEEK_NUMBER"

echodo ./initpost.sh -c "week$WEEK_NUMBER-from-script"
