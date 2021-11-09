ls -d -1 $1/* | grep -v $1.txt | xargs -n1 -P10 -I {} sh grepPattern.sh {} "$2"

