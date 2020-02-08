mkdir logfiles 2> /dev/null
targetfilename=`echo $1 | sed -e 's/.zip$//g'`

mkdir ./logfiles/$targetfilename 2> /dev/null

ls -l | grep -v logfiles | grep ^d | rev | cut -d ' ' -f 1 | rev | xargs rm -r
rm *.json

yes | unzip $1
ls -l | grep -v logfiles | grep ^d | rev | cut -d ' ' -f 1 | rev | xargs -L 1 bash reshape.sh

ls -l | grep -v logfiles |  grep ^d | rev | cut -d ' ' -f 1 | rev | xargs rm -r
rm *.json

mv *.txt ./logfiles/$targetfilename
