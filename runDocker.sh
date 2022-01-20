set -e

sh getDockers.sh $1

sh dockerBroken.sh $1

cat docker/$1-available.txt | grep "is available" 
