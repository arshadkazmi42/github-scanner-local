mkdir -p dependencies/ruby/

find $1 -name Gemfile | xargs -I {} awk '{print}' {} | grep "^gem" | grep -v gemspec | sed "s/\"/\'/g" | awk -F "\'" '{print $2}' | awk NF | sort | uniq | tee -a dependencies/ruby/$1.txt

