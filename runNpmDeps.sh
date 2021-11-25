set -e

sh getNpmDeps.sh $1

sh depsNpmBroken.sh $1

cat dependencies/npm/$1-available.txt | grep "✔" 
