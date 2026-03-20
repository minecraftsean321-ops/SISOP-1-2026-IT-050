# SISOP-1-2026-IT-050
| No. | Nama                   | NRP             |
|-----|------------------------|-----------------|
| 1.  | Sean Arthur Tamajaya   | 5027251050      |
## Reporting
### Soal_1

Penjelasan

Untuk langkah pertama kita perlu untuk mendownload file passenger.csv menggunakan wget.  

```console

seanarthur17@tamam~$: wget -O passenger.csv https://docs.google.com/spreadsheets/d/1NHmyS6wRO7To7ta-NLOOLHkPS6valvNaX7tawsv1zfE/export?format=csv&gid=0

```
Setelah itu kita bisa menlajutkan dengan membuat file scripth bernama KANJ.sh sesuai dengan contoh struktur repository yang diberikan.

```console

seanarthur17@tamam~$: nano KANJ.sh

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

![Output soal_1 a](<img width="1730" height="64" alt="Screenshot 2026-03-20 142516" src="https://github.com/user-attachments/assets/9556e747-9e51-4b57-8715-9c2c09a57b9c" />)

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



### Soal_2
