set -e

sh grepGithubWorkflow.sh $1

sh brokenGithubWorkflow.sh $1

