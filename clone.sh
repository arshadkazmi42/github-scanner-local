mkdir -p $1

if [ ! -f "$1/$1.txt" ]; then
   sh github-repo-list.sh $1 $2        
fi

cd $1
echo "Start Cloning"
cat $1.txt | xargs -n1 -P5 -I {} git clone {}

cd ..
