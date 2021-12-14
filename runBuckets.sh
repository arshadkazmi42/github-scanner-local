grep -roh -E "(s3|gs)://[-a-zA-Z0-9_\.]+" $1 | grep -vi "example\|bucketname$\|bucket-name$\|BUCKET_NAME$\|mybucket$\|my_bucket$" | sort | uniq
