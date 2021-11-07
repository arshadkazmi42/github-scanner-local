ls -d -1 $1/* | grep -v $1.txt | xargs -I {} sh grepPattern.sh {} "$2"
