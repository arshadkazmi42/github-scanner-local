DOCKER_DIR=./results/docker
WORKFLOW_DIR=./results/results-github-workflow
PIP_DIR=./results/dependencies/pip
NPM_DIR=./results/dependencies/npm
RESULTS_DIR=./results

#mkdir -p $DOCKER_DIR
#mkdir -p $WORKFLOW_DIR
#mkdir -p $PIP_DIR
#mkdir -p $NPM_DIR
#mkdir -p $RESULTS_DIR

# Broken Links Filter
cat $RESULTS_DIR/$1.txt | grep -v "youtube.com" | grep -v "^Binary" | grep -v "https://t.co/" | grep -v "example.com" | grep -v "example.org" | grep -v "stackoverflow.com" | grep -v "github.com/orgs"  | awk NF > $RESULTS_DIR/temp.txt
rm -rf $RESULTS_DIR/$1.txt
cat $RESULTS_DIR/temp.txt | awk -F "//" '{print ($2 == "")?"https://"$1:"https://"$2}' | tee -a $RESULTS_DIR/$1.txt
rm -rf $RESULTS_DIR/temp.txt
cat $RESULTS_DIR/$1.txt | sort | uniq > $RESULTS_DIR/temp.txt
mv $RESULTS_DIR/temp.txt $RESULTS_DIR/$1.txt
rm -rf $RESULTS_DIR/temp.txt

# Broken Links Checker
cd ../is-broken-link-github/
sh urls.sh ../github-scanner-local/$RESULTS_DIR/$1.txt | tee -a ../github-scanner-local/$RESULTS_DIR/$1-broken-github.txt
cd ../github-scanner-local
cat $RESULTS_DIR/$1.txt | grep -v 'github.com' | grep -v 'bitbucket.org' | xargs -n1 -P100 -I {} sh ../bash-scripts/curl/scan-broken.sh {} | tee -a $RESULTS_DIR/$1-broken.txt

# Get Broken Links
cat $RESULTS_DIR/$1-broken.txt | grep BROKEN | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" | tee -a $RESULTS_DIR/$1-broken-links.txt
# Get Takeover links
cat $RESULTS_DIR/$1-broken.txt | grep -v "ajax.googleapis.com\|awscli.amazonaws.com\|docs.aws.amazon.com\|ec2.amazonaws.com\|fonts.googleapis.com\|maps.googleapis.com\|oauth2.googleapis.com\|openidconnect.googleapis.com\|play.googleapis.com\|sns.amazonaws.com\|go-integration-test" | grep "actions-contrib\|googleapis\|amazonaws\|vercel.app\|netlify\|herokuapp\|surge.sh\|now.sh\|plugins.svn.wordpress.org\|npmjs.org\/package" | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" | tee -a $RESULTS_DIR/$1-takeover-links.txt

# Dependencies
## NPM
cat $NPM_DIR/$1.txt | awk -F '/' '{print tolower($1)}' | sort | uniq | xargs -n1 -P5 -I {} npm-name {} | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" | tee -a $NPM_DIR/$1-available.txt
cat $NPM_DIR/$1-available.txt | grep "✔" | tee -a $NPM_DIR/$1-available-package.txt

## Pip
cat $PIP_DIR/$1.txt | awk -F '/' '{print $1}' | xargs -n1 -P5 -I {} sh pip-name.sh {} | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" | tee -a $PIP_DIR/$1-available.txt
cat $PIP_DIR/$1-available.txt | grep "is available" | tee -a $PIP_DIR/$1-available-package.txt

# Workflows
cat $WORKFLOW_DIR/$1.txt | sort | uniq | xargs -n1 -P100 -I {} sh ../bash-scripts/curl/scan-broken.sh {} | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" | tee -a $WORKFLOW_DIR/$1-broken.txt
cat $WORKFLOW_DIR/$1-broken.txt | grep "BROKEN" | tee -a $WORKFLOW_DIR/$1-broken-links.txt

# Docker
cat $DOCKER_DIR/$1.txt | xargs -n1 -P5 -I {} sh docker-name.sh {} | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" | tee -a $DOCKER_DIR/$1-available.txt
cat $DOCKER_DIR/$1-available.txt | grep "is available" | tee -a $DOCKER_DIR/$1-available-docker.txt

