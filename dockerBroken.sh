
cat docker/$1.txt | xargs -n1 -P5 -I {} sh docker-name.sh {} | tee -a docker/$1-available.txt


