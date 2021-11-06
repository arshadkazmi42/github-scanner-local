mkdir -p $1

if [ ! -f "$1/$1.txt" ]; then
   sh github-repo-list.sh $1         
fi

cd $1
echo "Start Cloning"
cat $1.txt | xargs -I {} git clone {}

cd ..
