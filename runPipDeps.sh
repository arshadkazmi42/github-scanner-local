set -e

sh getPipDeps.sh $1

sh depsPipBroken.sh $1

cat dependencies/pip/$1-available.txt | grep "is available" 
