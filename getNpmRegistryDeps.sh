mkdir -p dependencies/npm-registry/

cat results/$1-broken.txt | grep "https://registry.npmjs.org" | awk -F " " '{print $2}' | awk -F "/" '{print $4}' | sort | uniq | tee -a dependencies/npm-registry/$1.txt
