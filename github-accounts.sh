TEMP_FILE_NAME=github-accounts-temp.txt
TAKENOVER_FILE_NAME=github-takenovers.txt


rm -rf $TEMP_FILE_NAME

cat $1 | grep BROKEN | grep -E 'github.com|bitbucket.org' | awk -F ' ' '{print $2}' | awk -F '/' '{print $3"/"$4}' | grep -E "^github.com|^bitbucket.org" | grep -v 'issues\|pull\|USERNAME\|username|\GIT_USER_ID' | awk -F '/' '{print $1"[:/]"$2}' >> $TEMP_FILE_NAME

cat $TAKENOVER_FILE_NAME | awk -F '/' '{print $3"/"$4}' | grep -E "^github.com|^bitbucket.org" | grep -v 'issues\|pull\|USERNAME\|username|\GIT_USER_ID' | awk -F '/' '{print $1"[:/]"$2}' >> $TEMP_FILE_NAME

cat $TEMP_FILE_NAME
