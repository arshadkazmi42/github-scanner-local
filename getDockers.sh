mkdir -p docker/

grep -roh -E "docker (pull|run) [-a-zA-Z0-9_]+/[-a-zA-Z0-9_]+" $1 | awk -F " " '{print $3}' | awk -F "/" '{print $1}' | sort | uniq | tee -a docker/$1.txt

# find $1 -name "Dockerfile" | xargs -I {} grep -P "FROM " {} | grep -v "gcr.io\|registry\|microsoft.com\|quay.io\|amazonaws.com" | awk -F "$" '{print $1}' | awk -F " " '{print $2}' | awk -F ":" '{print $1}' | awk -F "/" '{print $1}'  | sort | uniq | tee -a docker/$1.txt
