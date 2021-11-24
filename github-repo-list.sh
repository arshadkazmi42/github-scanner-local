mkdir -p $1
cd $1

RESULT_PER_PAGE=100
PAGE=1

while true 
do
    
    echo "Processing page $PAGE"
    echo "https://api.github.com/orgs/$1/repos?per_page=100&page=$PAGE"

    # With Token
    response=$(curl -H "Authorization: token $2" -s "https://api.github.com/orgs/$1/repos?per_page=100&page=$PAGE")   
    #response=$(curl -s "https://api.github.com/orgs/$1/repos?per_page=100&page=$PAGE")
    #echo $response    
    
    response_length=$(echo "$response" | jq '. | length')
    
    echo "Response length: "$response_length
    
    if [ $response_length -lt 1 ]; then
	    echo "No more results. Exiting..."
	    break
    fi

    PAGE=$(($PAGE+1))
    
    echo "$response" | jq -r '.[] | select(.archived == false) | select(.fork == false) | .html_url' | tee -a $1.txt

done

cat $1.txt | sort | uniq > test.txt
mv test.txt $1.txt

cd ..
