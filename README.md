# SISOP-1-2026-IT-050
| No. | Nama                   | NRP             |
|-----|------------------------|-----------------|
| 1.  | Sean Arthur Tamajaya   | 5027251050      |
## Reporting
### Soal_1

Penjelasan

Untuk langkah pertama kita perlu untuk mendownload file passenger.csv menggunakan wget.  

```console

seanarthur17@tamam~/SISOP-1-2026-IT-050/soal_1$ wget -O passenger.csv https://docs.google.com/spreadsheets/d/1NHmyS6wRO7To7ta-NLOOLHkPS6valvNaX7tawsv1zfE/export?format=csv&gid=0

```
Setelah itu kita bisa menlajutkan dengan membuat file scripth bernama KANJ.sh sesuai dengan contoh struktur repository yang diberikan.

```console

seanarthur17@tamam~/SISOP-1-2026-IT-050/soal_1$ nano KANJ.sh

```
Kemudian kita membuat kode didalam file KANJ.sh agar bisa mengakses file dengan perintah awk -f KANJ.sh passengger.csv (a/b/c/d/e) dengan menggunakan variabel dan perintah if else seperti berikut:

```bash
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

```
Di kode tersebut kita menyimpan char a ke dalam variabel subsoal lalu mendeletenya agar perintah awk tidak menganggapnya sebagai suatu file, sehingga kita bisa melakukan pengkondisian jika subsoal = a maka akan menjalankan perintah dalam if(subsoal == "a")

**Soal_1 a**

Di soal a kita diminta untuk menghitung jumlah penumpang yang ada di dalam kereta tersebut, hal ini bisa kita lakukan dengan menggunakan kode awk seperti diatas dimana -F "," digunakan karena text di file csvnya dipisahkan oleh koma lalu kita mengeprint tabel di kolom satu {print $1} dengan pengkondisian baris lebih dari satu NR > 1 agar header tabel tidak ikut terprint. Setelah itu kita menyortir nama-nama orang yang unik in case ada yang double lalu kita hitung jumlahnya menggunakan kode wc -l. Selanjutnya output dari kode tersebut akan disalurkan ke printah getline karena awk tidak bisa langsung mengetahui apa yang terjadi di sistem linux dan menyimpannya ke variabel count sehingga bisa digunakan oleh perintah awk dan mengeluarkan output seperti ini:

![Output soal_1 a](<Assets/Soal_1/Output soal_1 a.png>)

**Soal_1 b**

Lanjut ke soal b kita disuruh untuk menghitung jumlah gerbong yang ada di kereta tersebut, untuk melakukan hal tersebut kita bisa menggunakan kode seperti dibawah ini:

```bash

} else if (subsoal == "b") {

command="awk -F \",\" 'NR > 1 {print $4}' passenger.csv | sort | uniq | wc -l"

if((command | getline count) > 0) {

print "Jumlah gerbong penumpang KANJ adalah "count""

}

close(command)

```

Kode tersebut mengeprint kolom ke 4 dari file passenger.csv dengan pengkondisian baris lebih dari satu agar header tidak ikut terprint seperti kode di soal a dan menyortir nama gerbong yang unik karena suatu gerbong bisa ditempati oleh banyak orang sehingga terjadi duplikasi lalu dihitung jumlah dari nama gerbong yang unik dengan wc -l. Output dari kode tersebut adalah sebagai berikut:

![Output soal_1 b](<Assets/Soal_1/Output soal_1 b.png>)

**Soal_1 c**

Kemudian kita ke soal c dimana kita disuruh untuk mencari nama dan umur dari orang tertua di kereta tersebut, kita bisa menemukannya dengan kode dibawah ini:

```bash

} else if (subsoal == "c") {

command_usia="awk -F \",\" '{print $2}' passenger.csv | sort -rn | head -1"
command_nama="awk -F \",\" '/85/ {print $1}' passenger.csv"

if((command_usia | getline usia) > 0 && (command_nama | getline nama) > 0) {


print nama  " adalah penumpang tertua dengan usia " usia " tahun"

}

close(command)

```
Disitu saya membagi command menjadi dua yaitu comamnd_usia untuk mencari usia yang paling tua dan command_nama untuk mencari nama dari orang yang memiliki usia tertua. Jadi untuk command_usia perintah awk kan mengeprint kolom ke dua dari file passenger.csv dan mengurutkan usianya dari yang paling tinggi ke rendah menggunakan perintah sort -rn setelah itu saya mengambil output teratas yaitu angka tertinggi dengan kode head -1. Setelah saya dapat usia tertua saya dapat mencari nama dari orang yang memiliki usia tersebut dengan command_nama. Output dari kode tersebut adalah sebagai berikut:

![Output soal_1 c](<Assets/Soal_1/Output soal_1 c.png>)

**Soal_1 d**

Di soal_1 d kita disuruh untuk menghitung rata-rata dari usia penumpang yang ada di kereta tersebut dengan outputnya dibulatkan sehingga bukan angka desimal.

```bash

} else if (subsoal == "d") {

command="awk -F \",\" 'NR > 1 {sum += $2; count++} END {printf \"%.0f\\n\", sum/count}' passenger.csv"

if((command | getline rata) > 0) {

print "Rata rata usia penumpang adalah " rata " tahun"

}

close(command)

```
Jadi di kode tersebut perintah awk menjumlahkan seluruh isi dari kolom 2 kecuali header karena ada pengkondisian _NR > 1_ dengan kode _sum += $2_ setelah itu dihitung juga jumlah baris dari tabel tersebut dengan kode _count++_ sehingga kita tahu jumlah dari usia penumpang di kereta tersebut dan dapat mencari rata-rata dengan membagi _sum/count_ lalu tidak lupa agar output bukan angka desimal saya menggunakan _\".0f\\n"_. Output dari kode diatas adalah sebagai berikut:  

![Output soal_1 d](<Assets/Soal_1/Output soal_1 d.png>)

**Soal_1 e**
Di soal_1 e kita diminta untuk menghitung jumlah penumpang yang menggunakan business class, hal tersebut bisa kita lakukan dengan menggunakan kode dibawah ini:

```bash

} else if (subsoal == "e") {

command="awk -F \",\" '/Business/ {count++} END {print count}' passenger.csv"

if((command | getline b) > 0) {

print "Jumlah penumpang business class ada " b " orang"

}

close(command)

```

Jadi kode diatas menggunakan perintah awk untuk mencari kata __Business__ di file passenger.csv dan menghitungnya. Output dari kode diatas adalah sebagai berikut: 

![Output soal_1 e](<Assets/Soal_1/Output soal_1 e.png>)

Terakhir di Soal_1 kita diminta untuk memberikan output jika user salah menginput soal.

```bash
} else {

print "Soal tidak dikenali. Gunakan a, b, c, d, atau e."
print "Contoh penggunaan: awk -f file.sh data.csv a"

}

close(command)

}
```

Hasil dari kode diatas adalah sebagai berikut:

![Output soal_1 salah input](<Assets/Soal_1/Output salah input.png>)

### Soal_2

Penjelasan

Untuk langkah pertama menyelesaikan Soal_2 kita perlu memyiapkan semua peralatan yang diperlukan yang pertama itu gdown kita bisa menggunakan kode dibawah ini: 

```console

seanarthur17@tamam~/SISOP-1-2026-IT-050$ sudo pip install gdown

```

Setelah itu kita bisa download file dari google drive yang bernama peta-ekspedisi-amba.pdf ke folder ekspedsi yang telah kita buat di soal_2.

```console

seanarthur17@tamam~/SISOP-1-2026-IT-050/soal_2/ekspedsi$ gdown https://drive.google.com/uc?id=1q10pHSC3KFfvEiCN3V6PTroPR7YGHF6Q

```

Lanjut kita membaca file yang telah kita download dengan menggunakan _cat peta-ekspedisi-amba.pdf_ yang menampilkan seperti ini:

![Isi file peta-ekspedisi-amba.pdf](<Assets/Soal_2/Isi file.png>)

Di file tersebut terdapat link github yang bisa kita download dengan menggunakan cara clone repository seperti dibawah ini, pastikan kamu sudah memiliki paket git!:

```console

seanarthur17@tamam~/SISOP-1-2026-IT-050/soal_2/ekspedsi$ git clone https://github.com/pocongcyber77/peta-gunung-kawi.git

```

Nah setelah kita download kita mendapatkan folder bernama peta-gunung-kawi didalam folder tersebut terdapat file gsxtrack.json yang isinya seperti ini:

![Isi file gsx](<Assets/Soal_2/Isifilegsx.png>)

Di file tersebut terdapat data-data berupa site_name, latitude, dan longitude yang perlu kita ambil dan masukkan ke dalam file titik-penting.txt kita dapat melakukan tersebut dengan membuat file scripth bernama parserkoordinat.sh dan membuat perintah seperti dibawah ini: 

```bash
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

```
Jadi di kode tersebut if akan mengecek apakah string setelah nama file.sh itu kosong atau tidak menggunakan _[ -z "$1" ]_ jika kosong maka user akan diberi tutorial cara penggunaan dari file.sh tersebut. Disitu saya menggunakan sed untuk mengambil bagian yang berisi data-data yang diperlukan, saya menghitung untuk data pertama yaitu node 001 itu berada di baris 12 - 22, setelah saya mengambil bagian yang penting itu saya pisahkan lagi site_nama, latitude, dan longitude dengan menggunakan awk, semua data yang ada di file tersebut memiliki penempatan yang sama yaitu site_nama berada di baris ke 3, latitude berada di baris ke 5 dan longitude berada di baris ke 7 sehingga di semua kode untuk node 002-004 itu pada bagian awk memiliki kode yang sama. Yang membedakan hanyalah perintah sed karena mereka berada di baris yang berbeda dalam file.json. Lalu kita bisa menggunakan perintah seperti ini _./parserkoordinat.sh gsxtrack.json > titik-penting.txt_ dan output dari kode tersebut adalah sebagai berikut:








