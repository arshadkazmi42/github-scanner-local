mkdir -p results-github-workflow

#echo "Searching for github accounts from workflows"

grep -roh -E "uses: [-a-zA-Z0-9\.]+/[-a-zA-Z0-9.]+\@[-a-zA-Z0-9\.]+" $1 | awk -F ": " '{print $2}' | awk -F "/" '{print "https://github.com/"$1}' | sort | uniq | grep -v "github.com/actions$" | tee -a results-github-workflow/$1.txt
