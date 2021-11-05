mkdir -p $1

cd $1

RESULT_PER_PAGE=100
PAGE=1

while true 
do
    
    echo "Processing page $PAGE"
    echo "https://api.github.com/orgs/$1/repos?per_page=100&page=$PAGE"

    # With Token
    # response=$(curl -H "Authorization: token GH_TOKEN" -s "https://api.github.com/orgs/$1/repos?per_page=100&page=$PAGE")   
    response=$(curl -s "https://api.github.com/orgs/$1/repos?per_page=100&page=$PAGE") 
    response_length=$(echo "$response" | jq '. | length')
    
    echo "Response length: "$response_length
    
    if [ $response_length -lt 1 ]; then
	    echo "No more results. Exiting..."
	    
	    cd ..

	    exit 1
    fi

    PAGE=$(($PAGE+1))

    echo "$response" | jq 'if (.[].archived == false) then .[].html_url else "" end' | grep -v "\"\"" | xargs -I {} git clone {}

done
