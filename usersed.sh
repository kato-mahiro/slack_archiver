file=users.json
target=$1

json=`cat ${file}`
len=$(echo $json | jq length)

for i in $( seq 0 $(($len - 1)) ); do
    id=$(echo $json | jq -r .[$i].id)
    name=$(echo $json | jq -r .[$i].real_name)
    echo $id $name
    sed $1 -i -e "s/$id/$name/g"
done
