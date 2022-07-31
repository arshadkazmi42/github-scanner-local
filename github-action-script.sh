# Create target directory
mkdir -p docker/
mkdir -p results-github-workflow
mkdir -p dependencies/pip/
mkdir -p dependencies/npm/
mkdir -p results
mkdir -p $1
cd $1

# Clone the repository
git clone $2
cd ..

# Grep URLs
grep -r -ohP '(http.?://(www.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}.[a-zA-Z0-9]{1,6}|github.com)\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)' $1 | tee -a results/$1.txt
grep -r -ohP 'git@github.com\:[-a-zA-Z0-9\/.]*' $1 | awk -F ':' '{print "https://github.com/"$2}' | tee -a results/$1.txt
grep -r -ohP 'git@bitbucket.org\:[-a-zA-Z0-9\/.]*' $1 | awk -F ':' '{print "https://bitbucket.org/"$2}' | tee -a results/$1.txt
grep -r -ohP 'git@gitlab.com\:[-a-zA-Z0-9\/.]*' $1 | awk -F ':' '{print "https://gitlab.com/"$2}' | tee -a results/$1.txt

# NPM Dependencies
find $1 -name package.json | xargs -I {} get-dependencies {} | sort | uniq | tee -a dependencies/npm/$1.txt

# Pip Dependencies
find $1 -name requirements.txt | xargs -I {} awk '{print}' {} | grep -v "git:\|https\:\|http\:\|\#\|\""  | awk -F '=' '{print $1}' | awk -F ';' '{print $1}' | awk -F '(' '{print $1}' | awk -F '<' '{print $1}' | awk -F '>' '{print $1}' | awk -F '~' '{print $1}' | awk -F '[' '{print $1}' | awk NF | sed 's/ //g' | grep -v "^-" | sort | uniq | tee -a dependencies/pip/$1.txt

find $1 -name requirements-dev.txt | xargs -I {} awk '{print}' {} | grep -v "git:\|https\:\|http\:\|\#\|\""  | awk -F '=' '{print $1}' | awk -F ';' '{print $1}' | awk -F '(' '{print $1}' | awk -F '<' '{print $1}' | awk -F '>' '{print $1}' | awk -F '~' '{print $1}' | awk -F '[' '{print $1}' | awk NF | sed 's/ //g' | grep -v "^-" | sort | uniq | tee -a dependencies/pip/$1.txt

# Github Workflow
grep -roh -E "uses: [-a-zA-Z0-9\.]+/[-a-zA-Z0-9.]+\@[-a-zA-Z0-9\.]+" $1 | awk -F ": " '{print $2}' | awk -F "/" '{print "https://github.com/"$1}' | sort | uniq | grep -v "github.com/actions$" | tee -a results-github-workflow/$1.txt

# Buckets
grep -ro -E "(s3|gs)://[-a-zA-Z0-9_\.]+" $1 | grep -vi "example\|bucketname$\|bucket-name$\|BUCKET_NAME$\|mybucket$\|my_bucket$" | sort | uniq | tee -a results/$1-buckets.txt

# Docker
grep -roh -E "docker (pull|run|push) [-a-zA-Z0-9_]+/[-a-zA-Z0-9_]+" $1 | awk -F " " '{print $3}' | awk -F "/" '{print $1}' | sort | uniq | tee -a docker/$1.txt

# Remove cloned repository 
rm -rf $1 
