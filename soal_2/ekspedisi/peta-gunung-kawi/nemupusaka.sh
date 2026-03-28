#!/bin/bash


{

x1=$(awk -F "," 'NR == 1 {print $3}' titik-penting.txt)
y1=$(awk -F "," 'NR == 1 {print $4}' titik-penting.txt)


x4=$(awk -F "," 'NR == 4 {print $3}' titik-penting.txt)
y4=$(awk -F "," 'NR == 4 {print $4}' titik-penting.txt)

pusatx=$(echo "scale=6; ($x1 + $x4) / 2" | bc )
pusaty=$(echo "scale=6; ($y1 + $y4) / 2" | bc )


echo "Koordinat pusat: "
echo "($pusatx, $pusaty)"

} | tee -a posisipusaka.txt
