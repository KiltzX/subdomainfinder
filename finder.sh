#!/bin/bash
echo "Input domain name"
read domain


arc=$(uname -m)
if [[ $arc == *"x86_64"* ]]; then
  ./binaries/subfinder-elf -d $domain -o domain.txt
else
  ./binaries/subfinder-arm64 -d $domain -o domain.txt
fi


input="domain.txt"
while IFS= read -r line
do
    echo "Testing -> $line";
    if curl -I $line 2>&1 | grep -w "200\|301" ; then
        echo "$line" >> HostsUp-$domain.txt;
    fi
done < "$input"

echo "Finished !";