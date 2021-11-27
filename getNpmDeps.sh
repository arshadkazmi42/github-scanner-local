mkdir -p dependencies/npm/

#find $1 -name package.json | xargs -I {} awk '{print}' {} | grep -v "{{" | jq '. | select(.dependencies!=null)' | jq '. | select(.dependencies!=true)' | jq -r '.dependencies' | grep -v "{}\|null" | jq -r '. as $in| keys[]' | sort | uniq | tee -a dependencies/npm/$1.txt

#find $1 -name package.json | xargs -I {} awk '{print}' {} | grep -v "{{" | jq '. | select(.devDependencies!=null)' | jq '. | select(.devDependencies!=true)' | jq -r '.devDependencies' | grep -v "{}\|null" | jq -r '. as $in| keys[]' | sort | uniq | tee -a dependencies/npm/$1.txt

find $1 -name package.json | xargs -I {} get-dependencies {} | sort | uniq | tee -a dependencies/npm/$1.txt
