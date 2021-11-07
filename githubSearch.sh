sh github-accounts.sh results/$1-broken.txt | xargs -I {} sh search.sh $1 "{}"
