sh github-accounts.sh results/$1-broken.txt | xargs -n1 -P10 -I {} sh search.sh $1 "{}"
