
echo "Crawling urls from: "$1

# MacOS
grep -E -roh '(http.?://(www\.)?[-a-zA-Z0-9@:%._+~#=]+(\.[a-zA-Z0-9]{1,6})?|github\.com)\b([-a-zA-Z0-9@:%_\+.~#?&/=]*)' $1 > results/$1.txt
# Ubuntu
#grep -roh '(http.?://(www.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}.[a-zA-Z0-9]{1,6}|github.com)\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)' $1 > results/$1.txt

grep -roEh 'git?://\S+' $1 | awk -F ":" '{print "https://github.com/"$2}' >> results/$1.txt
grep -roEh 'git@github.com\:[-a-zA-Z0-9\/.]*' $1 | awk -F ':' '{print "https://github.com/"$2}' >> results/$1.txt

#grep -roh 'git@bitbucket.org\:[-a-zA-Z0-9\/.]*' $1 | awk -F ':' '{print "https://bitbucket.org/"$2}' >> results/$1.txt

#grep -roh 'git@gitlab.com\:[-a-zA-Z0-9\/.]*' $1 | awk -F ':' '{print "https://gitlab.com/"$2}' >> results/$1.txt

cat results/$1.txt | grep -v "localhost" | grep -v "youtube.com" | grep -v "^Binary" | grep -v "https://t.co/" | grep -v "example.com" | grep -v "example.org" | grep -v "stackoverflow.com" | grep -v "github.com/orgs"  | awk NF > results/temp.txt

rm -rf results/$1.txt
	
cat results/temp.txt | awk -F "//" '{print ($2 == "")?"https://"$1:"https://"$2}' | tee -a results/$1.txt

rm -rf results/temp.txt

cat results/$1.txt | sort | uniq > results/temp.txt

mv results/temp.txt results/$1.txt

rm -rf results/temp.txt
