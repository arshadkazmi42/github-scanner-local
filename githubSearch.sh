rm -rf results/$1-github-search.txt
sh github-accounts.sh results/$1-broken.txt | xargs -n1 -P10 -I {} sh search.sh $1 "{}" | tee -a results/$1-github-search.txt
