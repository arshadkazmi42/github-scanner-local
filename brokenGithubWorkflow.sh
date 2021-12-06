cat results-github-workflow/$1.txt | xargs -n1 -P100 -I {} sh ../bash-scripts/curl/scan-broken.sh {} | tee -a results-github-workflow/$1-broken.txt

