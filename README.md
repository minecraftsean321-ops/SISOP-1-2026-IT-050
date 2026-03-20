# SISOP-1-2026-IT-050
| No. | Nama                   | NRP             |
|-----|------------------------|-----------------|
| 1.  | Sean Arthur Tamajaya   | 5027251050      |
## Reporting
**Soal 1**

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

Di soal a kita diminta untuk menghitung jumlah penumpang yang ada di dalam kereta tersebut, hal ini bisa kita lakukan dengan menggunakan kode awk seperti diatas dimana -F "," digunakan karena text di file csvnya dipisahkan oleh koma lalu kita mengeprint tabel di kolom satu {print $1} dengan pengkondisian baris lebih dari satu NR > 1 agar header tabel tidak ikut terprint. Setelah itu kita menyortir nama-nama orang yang unik in case ada yang double lalu kita hitung jumlahnya menggunakan kode wc -l. Selanjutnya output dari kode tersebut akan disalurkan ke printah getline karena awk tidak bisa langsung mengetahui apa yang terjadi di sistem linux dan menyimpannya ke variabel count sehingga bisa digunakan oleh perintah awk dan mengeluarkan output seperti ini:

![Output soal_1 a](<img width="1730" height="64" alt="Screenshot 2026-03-20 142516" src="https://github.com/user-attachments/assets/9556e747-9e51-4b57-8715-9c2c09a57b9c" />)

Lanjut ke soal b kita disuruh untuk menghitung jumlah gerbong yang ada di kereta tersebut, untuk melakukan hal tersebut kita bisa menggunakan kode seperti dibawah ini:

```bash





