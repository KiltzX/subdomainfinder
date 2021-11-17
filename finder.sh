#!/bin/bash
echo "Input domain name"
read domain

./subfinder -d $domain -o domain.txt

input="domain.txt"
while IFS= read -r line
do
    echo "Testing -> $line";
    if curl -I $line 2>&1 | grep -w "200\|301" ; then
        echo "$line" >> HostsUp-$domain.txt;
    fi
done < "$input"

echo "Finished !";