#echo "Searching $2 in $1" 

grep -r -o -E $2 $1
