#!/bin/bash

if [ -z "$1" ]; then 
	echo "Penggunaan: ./nama_file.sh nama_file.json"
	exit 1
fi

FILE_JSON=$1

#untuk node 001
sed -n '12,22p' "$FILE_JSON" | awk -F ":" ' {gsub (/[", ]/, "", $2) } NR == 3 {printf "%s,", $2} NR == 5 {printf "%s,", $2} NR == 7 {printf "%s,", $2} NR == 8 {printf "%s\n", $2}'

#untuk node 002
sed -n '28,38p' "$FILE_JSON" | awk -F ":" '{gsub (/[", ]/, "", $2) } NR == 3 {printf "%s,", $2} NR == 5 {printf "%s,", $2} NR == 7 {printf "%s,", $2} NR == 8 {printf "%s\n", $2}'

#untuk node 003
sed -n '44,54p' "$FILE_JSON" | awk -F ":" '{gsub (/[", ]/, "", $2) } NR == 3 {printf "%s,", $2} NR == 5 {printf "%s,", $2} NR == 7 {printf "%s,", $2} NR == 8 {printf "%s\n", $2}'

#untuk node 004
sed -n '60,70p' "$FILE_JSON" | awk -F ":" '{gsub (/[", ]/, "", $2) } NR == 3 {printf "%s,", $2} NR == 5 {printf "%s,", $2} NR == 7 {printf "%s,", $2} NR == 8 {printf "%s\n", $2}'
