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
Kemudian kita membuat kode didalam file KANJ.sh agar bisa mengakses file dengan perintah awk -f KANJ.sh passengger.csv (a/b/c/d/e) dengan menggunakan variabel dan petintah if else:

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
Di kode tersebut kita menyimpan char a ke dalam variabel subsoal lalu mendeletenya agar perintah awk tidak menganggapnya sebagai suatu file, sehingga kita bisa melakukan pengkondisian jika subsoal a maka akan menjalankan perintah dalam if setelah itu hasil dari perintah awk tersebut akan disimpan ke variabel count melalui getline dan di print menghasilkan output seperti berikut:

