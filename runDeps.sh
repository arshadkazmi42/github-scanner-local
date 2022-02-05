sh runNpmDeps.sh $1
sh runPipDeps.sh $1
sh runRubyDeps.sh $1

echo "\n"

echo "NPM Available?"
cat dependencies/npm/$1-available.txt | grep "is available"

echo "\n"

echo "Pip Available?"
cat dependencies/pip/$1-available.txt | grep "is available"

echo "\n"

echo "Ruby Available?"
cat dependencies/ruby/$1-available.txt | grep "is available"

echo "\n"

echo "Running gh workflow"

sh runGithubWorkflow.sh $1

echo "\n"

echo "Running buckets"

sh runBuckets.sh $1

echo "\n"

echo "Running docker"

sh runDocker.sh $1

echo "\n"

echo "Running action"

sh action.sh $1

echo "Running github deps"

sh github-deps.sh $1
