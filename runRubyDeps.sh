set -e

sh getRubyDeps.sh $1

sh depsRubyBroken.sh $1

cat dependencies/ruby/$1-available.txt | grep "is available" 
