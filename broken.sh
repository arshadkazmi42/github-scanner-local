cd ../is-broken-link-github/
sh urls.sh ../github-scanner-local/results/$1.txt | tee -a ../github-scanner-local/results/$1-broken.txt

cd ../github-scanner-local

cat results/$1.txt | grep -v github.com | xargs -n1 -P100 -I {} sh ../bash-scripts/curl/scan-broken.sh {} | tee -a results/$1-broken.txt

