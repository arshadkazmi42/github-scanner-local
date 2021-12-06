set -e

sh getNpmRegistryDeps.sh $1

sh depsNpmRegistryBroken.sh $1

cat dependencies/npm-registry/$1-available.txt | grep "is available" 
