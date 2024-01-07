set -e

sh clone.sh $1

sh grepURL.sh $1

sh broken.sh $1

sh ghurls.sh $1
