rm -rf results/$1-search-broken.txt
cat results/$1-broken.txt | grep BROKEN | grep -v "github" | awk -F ' ' '{print $2}' | xargs -n1 -P5 -I {} sh search.sh $1 "{}" | tee -a results/$1-broken-search.txt
