#/bin/bash

channel=$1
outputfile=$1.txt

for file in `\find ./${channel}/ -maxdepth 1 -type f | sort`; do
    json=`cat ${file}`
    len=$(echo $json | jq length)
    days=$(echo ${file} | cut -d '/' -f 3| cut -d '.' -f 1)

    echo ' ' >> $outputfile
    echo " --- $days ---" >> $outputfile

    for i in $( seq 0 $(($len - 1)) ); do
        user=$(echo $json | jq -r .[$i].user)
        text=$(echo $json | jq -r .[$i].text)
        echo "@${user}: " >> $outputfile
        echo "${text}" | sed -e 's/^/    /' >> $outputfile
    done
done

file=users.json
json=`cat ${file}`
len=$(echo $json | jq length)

for i in $( seq 0 $(($len - 1)) ); do
   id=$(echo $json | jq -r .[$i].id)
   name=$(echo $json | jq -r .[$i].real_name)
   sed $outputfile -i -e "s/$id/$name/g" 2> /dev/null
done

# nkf -s $1.log > $1.txt

echo $1 completed.
