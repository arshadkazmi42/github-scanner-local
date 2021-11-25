mkdir -p dependencies/npm/

find $1 -name package.json | xargs -I {} cat {} | jq -r '.dependencies'  | grep -v "{}\|null" | jq -r '. as $in| keys[]' | sort | uniq | tee -a dependencies/npm/$1.txt

find $1 -name package.json | xargs -I {} cat {} | jq -r '.devDependencies'  | grep -v "{}\|null" | jq -r '. as $in| keys[]' | sort | uniq | tee -a dependencies/npm/$1.txt

