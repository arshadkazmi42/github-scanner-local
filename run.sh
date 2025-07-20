set -e

sh clone.sh $1 $2

sh grepURL.sh $1

sh broken.sh $1

sh ghurls.sh $1

sh runGithubWorkflow.sh $1 $2

sh runDeps.sh $1

sh takeovers.sh $1

cat dependencies/npm/$1-available.txt | grep "is available"
cat dependencies/pip/$1-available.txt | grep "is available"
cat dependencies/ruby/$1-available.txt | grep "is available"
cat docker/$1-available.txt | grep "is available"

cat dependencies/github/$1-broken.txt | grep BROKEN
cat results-github-workflow/$1-broken.txt | grep BROKEN
