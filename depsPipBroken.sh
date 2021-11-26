
cat dependencies/pip/$1.txt | awk -F '/' '{print $1}' | xargs -n1 -P5 -I {} pip-name {} | tee -a dependencies/pip/$1-available.txt


