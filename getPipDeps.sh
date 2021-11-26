mkdir -p dependencies/pip/


find $1 -name requirements.txt | xargs -I {} awk '{print}' {} | grep -v "git:\|https\:\|http\:\|\#"  | awk -F '=' '{print $1}' | awk -F '<' '{print $1}' | awk -F '>' '{print $1}' | awk -F '~' '{print $1}' | awk NF | sed 's/_/-/g' | sort | uniq | tee -a dependencies/pip/$1.txt
