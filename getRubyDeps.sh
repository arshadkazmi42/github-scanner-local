mkdir -p dependencies/ruby/

find $1 -name Gemfile | xargs -I {} awk '{print}' {} | grep -v https://rubygems.org | grep -v gemspec | grep gem | awk -F "'" '{print $2}' | awk NF | sort | uniq | tee -a dependencies/ruby/$1.txt


