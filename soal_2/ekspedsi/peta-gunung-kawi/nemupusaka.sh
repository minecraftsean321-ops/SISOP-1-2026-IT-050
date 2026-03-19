#!/bin/bash

x1=112.450000
y1=-7.920000

x4=112.450000
y4=-7.937960

pusatx=$(echo "scale=6;  ($x1 + $x4) / 2" | bc )
pusaty=$(echo "scale=6; ($y1 + $y4) / 2" | bc )

echo "Koordinat pusat: "
echo "($pusatx, $pusaty)"


