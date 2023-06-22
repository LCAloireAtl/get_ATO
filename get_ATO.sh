#install python3
#sudo pip3 install beautifulsoup4

cd
cd get_ATO
find -name \.ATO\*csv -mtime +0 -exec gzip {} \;

cp -p ATO.html .ATO.html || touch .ATO.html
sync
sleep .3
rm -f ATO.html
sync
sleep .2
curl -o ATO.html https://www.boursorama.com/cours/1rPATO/_toutes-les-transactions?limit=2000o
sync
sleep .2
diff ATO.html .ATO.html >/dev/null
if [ $? -gt 0 ]; then
# traitement si différent
#grep th ATO > ATO.csv
#grep -E "tr|td" ATO | cut -c1-40 | tr '.' ',' | tr -d ' ' | sed -e 's/$/;/g' | sed -e 's/^;$/_;_/g' | tr -d '\n' | sed -e 's/_;__;__;_/\n/g' | sed -e 's/_;_/;/g' | sed -e 's:</tr;;;:</tr;;;\n:' >> ATO.html
cat ATO.html | ~/html2csv.py > ATO.csv
sed -i 's/ //g' ATO.csv
cat ATO.csv
cp ATO.csv .ATO-$(date +%Y%m%d_%H%M%S).csv
else
mv .ATO.html ATO.html
echo "Pas de différence avec ATO.html / ATO.csv"
fi
echo "..."
tail -n 5 ATO.csv
head -n 2 ATO.csv

