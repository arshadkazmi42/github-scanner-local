#!/bin/bash

# Check if URL is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <github-url>"
    exit 1
fi

# Check if GITHUB_TOKEN is set
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN environment variable is not set"
    exit 1
fi

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to check URL
check_url() {
    local url=$1
    
    # Remove trailing slash if present
    url=${url%/}
    
    # Make API request with GitHub token
    response=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: token $GITHUB_TOKEN" $url)
    
    # Check response
    if [ "$response" -eq 200 ]; then
        echo "$url ${GREEN}OK${NC}"
    else
        echo "$url ${RED}BROKEN${NC}"
    fi
}

# Call function with provided URL
check_url "$1"
