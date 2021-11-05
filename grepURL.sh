echo "Crawling urls from: "$1

grep -r -ohP '(http.?://(www.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}.[a-zA-Z0-9]{1,6}|github.com)\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)' $1 > results/$1.txt

cat results/$1.txt | grep -v "^Binary" | awk NF > results/temp.txt

rm -rf results/$1.txt
	
cat results/temp.txt | awk -F "//" '{print ($2 == "")?"https://"$1:"https://"$2}' | tee -a results/$1.txt

rm -rf results/temp.txt

cat results/$1.txt | sort | uniq > results/temp.txt

mv results/temp.txt results/$1.txt

rm -rf results/temp.txt
