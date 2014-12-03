
#remove olr
#sed -i 's/olr://g' $1

#Open GeoJSON
echo  "{ \"type\": \"FeatureCollection\", \"features\": [" > $2

#query reportSegments
 cat $1 | jq -c '.Inrix.Dictionary.Report.reportSegments[] | .ReportSegmentLRC.method.locationReference.optionLinearLocationReference.first.coordinate.latitude as $lat1 | .ReportSegmentLRC.method.locationReference.optionLinearLocationReference.first.coordinate.longitude as $lon1 | .ReportSegmentLRC.method.locationReference.optionLinearLocationReference.last.coordinate.longitude as $lon2 | .ReportSegmentLRC.method.locationReference.optionLinearLocationReference.last.coordinate.latitude as $lat2 | def signO(f): if f> 0 then 1 elif f==0 then 0 else -1 end;   {  "properties": { "Name": .SegmentNames.Name, "ReportSegmentID": .ReportSegmentID }, "geometry": { "type": "LineString", "coordinates": [ [(($lon1-(signO($lon1)*0.5))*360)/16777216, (($lat1-(signO($lat1)*0.5))*360)/16777216], [((($lon1-(signO($lon1)*0.5))*360)/16777216) + $lon2/100000, ((($lat1-(signO($lat1)*0.5))*360)/16777216) + $lat2/100000]]}, "type": "Feature"} ' >> $2


#close GeoJSON 
echo "]}" >> $2

#add comas
sed -i 's/}}/}},/g' $2
