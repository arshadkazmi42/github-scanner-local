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

sh runGithubWorkflow.sh $1
