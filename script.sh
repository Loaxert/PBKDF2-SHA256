# /bin/bash

help ()
{
    echo "Usage: ./pbkdf2.sh 'pbkdf2:sha256:ITERATIONS:SALT:HASH'"
}

if [ "$#" -lt 1 ]; then
  echo "Error: there is no hash"
  help
  exit 1
fi

pbkdf2=$1

iterations=$(echo "$pbkdf2" | cut -d':' -f3)
format=$(echo "$pbkdf2" | cut -d':' -f2)
salt=$(echo "$pbkdf2" | cut -d':' -f4)
hash=$(echo "$pbkdf2" | cut -d':' -f5)

if [ -z "$salt" ]; then
  echo "Replace the '$' with ':'"
  exit 0
fi

nice_salt=$(echo -n "$salt" | base64)
nice_hash=$(echo "$hash" | xxd -r -p | base64)

echo "This is the hash in the new format:"

echo "$format:$iterations:$nice_salt:$nice_hash"
