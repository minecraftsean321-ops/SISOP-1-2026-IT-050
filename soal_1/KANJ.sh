#!/bin/bash

BEGIN{
#ARGV[1] adalah untuk passenger.csv
#ARGC[2] adalah untuk sub-soal

subsoal=ARGV[2]

delete ARGV[2]

if(subsoal == "a") {

command="awk -F \",\" 'NR > 1 {print $1}' passenger.csv | sort | uniq | wc -l"


if((command | getline count) > 0) {

print "Jumlah seluruh penumpang KANJ adalah "count" orang"

}

close(command)

} else if (subsoal == "b") {
#tr -d '\r' digunakan untuk menghapus karakter tak terlihat
command="awk -F \",\" ' NR > 1 {print $4}' passenger.csv | tr -d '\r' | sort | uniq | wc -l"

if((command | getline count) > 0) {

print "Jumlah gerbong penumpang KANJ adalah "count""

}

close(command)

}else if (subsoal == "c") {

command_usia="awk -F \",\" '{print $2}' passenger.csv | sort -rn | head -1"
command_nama="awk -F \",\" '/85/ {print $1}' passenger.csv"

if((command_usia | getline usia) > 0 && (command_nama | getline nama) > 0) {


print nama  " adalah penumpang tertua dengan usia " usia " tahun"

}

close(command)

} else if (subsoal == "d") {

command="awk -F \",\" 'NR > 1 {sum += $2; count++} END {printf \"%d\", int(sum/count)}' passenger.csv"

if((command | getline rata) > 0) {

print "Rata rata usia penumpang adalah " rata " tahun"

}

close(command)

} else if (subsoal == "e") {

command="awk -F \",\" '/Business/ {count++} END {print count}' passenger.csv"

if((command | getline b) > 0) {

print "Jumlah penumpang business class ada " b " orang"

}

close(command)

} else {

print "Soal tidak dikenali. Gunakan a, b, c, d, atau e."
print "Contoh penggunaan: awk -f file.sh data.csv a"

}

close(command)

}

