#!/bin/bash

GREEN='\033[1;32m'
RED='\033[1;31m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m'
HTTP_CODE=404

response_code=$(curl --max-time 5 -Ls -o /dev/null -w "%{http_code}" https://hub.docker.com/v2/users/$1)

if [ $response_code -eq $HTTP_CODE ]; then
    echo "${GREEN}"$1"${NC} is available"
else
    echo "${RED}"$1"${NC} is unavailable"
fi
