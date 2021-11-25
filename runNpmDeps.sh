set -e

sh getNpmDeps.sh $1

sh depsNpmBroken.sh $1
