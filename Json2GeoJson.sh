

#Open GeoJSON
echo  "{ \"type\": \"FeatureCollection\", \"features\": [" > $2

#query tramos 
cat $1 | jq  -c '.tramos[]| {"type": "Feature","geometry": {"type": "LineString", "coordinates": .points | map([.lon,.lat])},"properties":{"name": .name, "id": .id}}' >> $2
 
#close GeoJSON 
echo "]}" >> $2

#remove line breaks
sed -i ':a;N;$!ba;s/\n/\t/g' $2

#add comas
sed -i 's/}\t{/},{/g' $2 
 
 
