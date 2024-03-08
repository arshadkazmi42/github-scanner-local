mkdir -p $1
cd $1

RESULT_PER_PAGE=100
PAGE=1

while true; do

	URL="https://api.github.com/search/users?q=$1&per_page=100&page=$PAGE"
	echo "Processing page $PAGE"

	echo "https://api.github.com/orgs/$1/repos?per_page=100&page=$PAGE"

	# With Token
	response=$(curl -H "Authorization: token $2" -s $URL)
	# echo $response

	response_length=$(echo "$response" | jq '.items | length')


	echo "Response length: "$response_length

	if [ $response_length -lt 1 ]; then
		echo "No more results. Exiting..."
		break
	fi

	PAGE=$(($PAGE + 1))

	echo "$response" | jq -r '.items[] | .login' | tee -a $1.txt

done

cat $1.txt | sort | uniq >test.txt
mv test.txt $1.txt

cd ..
