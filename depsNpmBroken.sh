#cat dependencies/npm/$1.txt | awk -F ' ' '{print "https://registry.yarnpkg.com/"$1}' | xargs -n1 -P100 -I {} sh ../bash-scripts/curl/scan-broken.sh {} | tee -a dependencies/npm/$1-broken.txt

cat dependencies/npm/$1.txt | awk -F '/' '{print tolower($1)}' | sort | uniq | xargs -n1 -P5 -I {} npm-name {} | tee -a dependencies/npm/$1-available.txt


