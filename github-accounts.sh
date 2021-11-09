cat $1 | grep BROKEN | grep 'github.com/' | awk -F ' ' '{print $2}' | awk -F '/' '{print $3"/"$4}' | grep "^github.com" | grep -v 'issues\|pull\|USERNAME\|username' | awk -F '/' '{print $1"[:/]"$2}'
