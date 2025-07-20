set -e

sh clone.sh $1 $2

export GITHUB_TOKEN=$2
sh grepGithubWorkflow.sh $1
cat results-github-workflow/$1.txt | xargs -I {} sh githubBroken.sh {}
