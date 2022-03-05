GITHUB_PATH=dependencies/github

mkdir -p $GITHUB_PATH

grep -r -oP 'github:[-a-zA-Z0-9\/\.\_]+' $1 | tee -a $GITHUB_PATH/$1.txt 

cat $GITHUB_PATH/$1.txt | awk -F ":" '{print $3}' | awk -F "/" '{print "https://github.com/"$1}' | grep -v "github.com/before" | sort | uniq | tee -a $GITHUB_PATH/$1-links.txt

cd ../is-broken-link-github/

sh urls.sh ../github-scanner-local/$GITHUB_PATH/$1-links.txt | tee -a ../github-scanner-local/$GITHUB_PATH/$1-broken.txt

cd ../github-scanner-local
