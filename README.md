# SISOP-1-2026-IT-050
| No. | Nama                   | NRP               |
|-----|------------------------|-------------------|
| 1.  | Sean Arthur Tamajaya   | 5027251050        |
## Reporting
### Soal_1

Penjelasan

Untuk langkah pertama kita perlu untuk mendownload file passenger.csv menggunakan wget.  

```console

seanarthur17@tamam~/SISOP-1-2026-IT-050/soal_1$ wget -O passenger.csv https://docs.google.com/spreadsheets/d/1NHmyS6wRO7To7ta-NLOOLHkPS6valvNaX7tawsv1zfE/export?format=csv&gid=0

```
Setelah itu kita bisa melanjutkan dengan membuat file scripth bernama KANJ.sh sesuai dengan contoh struktur repository yang diberikan.

```console

seanarthur17@tamam~/SISOP-1-2026-IT-050/soal_1$ nano KANJ.sh

```
Kemudian kita membuat kode didalam file KANJ.sh, agar bisa mengakses file dengan perintah awk -f KANJ.sh passengger.csv (a/b/c/d/e) kita perlu menggunakan variabel dan perintah if else seperti berikut:

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

Di soal a kita diminta untuk menghitung jumlah penumpang yang ada di dalam kereta tersebut, hal ini bisa kita lakukan dengan menggunakan kode awk seperti diatas dimana -F "," digunakan karena text di file csvnya dipisahkan oleh koma, lalu kita mengeprint tabel di kolom satu {print $1} dengan pengkondisian baris lebih dari satu NR > 1 agar header tabel tidak ikut terprint. Setelah itu kita menyortir nama-nama orang yang unik in case ada yang duplikat lalu kita hitung jumlahnya menggunakan kode wc -l. Selanjutnya output dari kode tersebut akan disalurkan ke printah getline karena awk tidak bisa langsung mengetahui apa yang terjadi di sistem linux dan menyimpannya ke variabel count sehingga bisa digunakan oleh perintah awk dan mengeluarkan output seperti ini:

![Output soal_1 a](<Assets/Soal_1/Output soal_1 a.png>)

**Soal_1 b**

Lanjut ke soal b kita disuruh untuk menghitung jumlah gerbong yang ada di kereta tersebut, untuk melakukan hal tersebut kita bisa menggunakan kode seperti dibawah ini:

```bash

} else if (subsoal == "b") {
#tr -d '\r' digunakan untuk menghapus karakter tak terlihat
command="awk -F \",\" ' NR > 1 {print $4}' passenger.csv | tr -d '\r' | sort | uniq | wc -l"

if((command | getline count) > 0) {

print "Jumlah gerbong penumpang KANJ adalah "count""

}

close(command

```

Kode tersebut mengeprint kolom ke 4 dari file passenger.csv dengan pengkondisian baris lebih dari satu agar header tidak ikut terprint seperti kode di soal a, dan menyortir nama gerbong yang unik karena suatu gerbong bisa ditempati oleh banyak orang sehingga bisa terjadi duplikasi, sebelum itu saya juga telah menghapus karakter tersembunyi menggunakan _tr -d '\r'_ agar tidak ikut terhitung, lalu dihitung jumlah dari nama gerbong yang unik dengan wc -l. Output dari kode tersebut adalah sebagai berikut:

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
Disitu saya membagi command menjadi dua yaitu comamnd_usia untuk mencari usia yang paling tua dan command_nama untuk mencari nama dari orang yang memiliki usia tertua. Jadi untuk command_usia perintah awk akan mengeprint kolom ke dua dari file passenger.csv dan mengurutkan usianya dari yang paling tinggi ke rendah menggunakan perintah sort -rn setelah itu saya mengambil output teratas yaitu angka tertinggi dengan kode head -1. Setelah saya dapat usia tertua saya dapat mencari nama dari orang yang memiliki usia tersebut dengan command_nama. Output dari kode tersebut adalah sebagai berikut:

![Output soal_1 c](<Assets/Soal_1/Output soal_1 c.png>)

**Soal_1 d**

Di soal_1 d kita disuruh untuk menghitung rata-rata dari usia penumpang yang ada di kereta tersebut dengan outputnya dibulatkan sehingga bukan angka desimal.

```bash

} else if (subsoal == "d") {

command="awk -F \",\" 'NR > 1 {sum += $2; count++} END {printf \"%d\", int(sum/count)}' passenger.csv"

if((command | getline rata) > 0) {

print "Rata rata usia penumpang adalah " rata " tahun"

}

close(command)

```
Jadi di kode tersebut perintah awk menjumlahkan seluruh isi dari kolom 2 kecuali header karena ada pengkondisian _NR > 1_ dengan kode _sum += $2_ setelah itu dihitung juga jumlah baris dari tabel tersebut dengan kode _count++_ sehingga kita tahu jumlah dari penumpang di kereta tersebut dan dapat mencari rata-rata dengan membagi _sum/count_ lalu tidak lupa agar output bukan angka desimal saya menggunakan _int(sum/count)_. Output dari kode diatas adalah sebagai berikut:  

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

Untuk langkah pertama menyelesaikan Soal_2 kita perlu menyiapkan semua peralatan yang diperlukan, yang pertama itu gdown kita bisa menggunakan kode dibawah ini: 

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
Jadi di kode tersebut if akan mengecek apakah string setelah nama file.sh itu kosong atau tidak menggunakan _[ -z "$1" ]_ jika kosong maka user akan diberi tutorial cara penggunaan dari file.sh tersebut. Disitu saya menggunakan sed untuk mengambil bagian yang berisi data-data yang diperlukan, saya menghitung untuk data pertama yaitu node 001 itu berada di baris 12 - 22, setelah saya mengambil bagian yang penting itu saya pisahkan lagi site_nama, latitude, dan longitude dengan menggunakan awk. Semua data yang ada di file tersebut memiliki penempatan yang sama yaitu site_nama berada di baris ke 3, latitude berada di baris ke 5 dan longitude berada di baris ke 7 sehingga di semua kode untuk node 002-004 itu pada bagian awk memiliki kode yang sama. Yang membedakan hanyalah perintah sed karena mereka berada di baris yang berbeda dalam file.json. Lalu kita bisa menggunakan perintah seperti ini _./parserkoordinat.sh gsxtrack.json > titik-penting.txt_ dan output dari kode tersebut adalah sebagai berikut:

![Output kode di titik-penting](<Assets/Soal_2/Titikpenting.png>)

Setelah itu kita lanjut untuk mencari titik pusaka paman kita dengan menghitung titik tengah dari koordinat yang telah kita dapatkan, hal ini bisa dilakukan dengan menggunakan metode titik simetri diagonal, yaitu menghitung titik tengah dari dua koordinat yang saling berseberangan. Disini saya membuat file scripth lagi bernama _nemupusaka.sh_ yang memiliki kode seperti dibawah ini:

```bash
#!/bin/bash

x1=-7.920000
y1=112.450000


x4=-7.937960
y4=112.450000


pusatx=$(echo "scale=6;  ($x1 + $x4) / 2" | bc )
pusaty=$(echo "scale=6; ($y1 + $y4) / 2" | bc )

echo "Koordinat pusat: "
echo "($pusatx, $pusaty)"

```
Jadi di kode tersebut saya membuat variabel x dan y dari titik 1 dan 4 berdasarkan koordinat yang kita peroleh dari step sebelumnya, lalu menjumlahkan x1 + x4 / 2 dan y1 + y4 /2 sehingga hasilnya akan muncul seperti ini:

![Output nemupusaka](<Assets/Soal_2/Nemupusaka.png>)

Lalu masukkan output tersebut ke file baru bernama posisipusaka.txt dengan kode dibawah ini:

```console

seanarthur17@tamam~/SISOP-1-2026-IT-050/soal_2/ekspedsi/peta-gunung-kawi$ ./nemupusaka.sh > posisipusaka.txt

```

### Soal_3

Penjelasan  

Untuk soal_3 sendiri kita diminta untuk membuat suatu program yang dapat memanage kost yang dimiliki oleh paman amba, jadi hal pertama yang saya lakukan adalah membuat desain ascii yang menarik untuk tampilan dari program ini, disini saya menggunakan perintah figlet untuk membuat desain text ascii yang menarik digabung dengan lolcat untuk menciptakan animasi warna warni yang indah, untuk melakukan hal tersebut saya perlu untuk mendownload kedua perintah tersebut dengan kode dibawah ini:

```console

seanarthur17@tamam~/SISOP-1-2026-IT-050$ sudo apt update
seanarthur17@tamam~/SISOP-1-2026-IT-050$ sudo apt install figlet
seanarthur17@tamam~/SISOP-1-2026-IT-050$ sudo apt install lolcat

#Membuat text Ascii
seanarthur17@tamam~/SISOP-1-2026-IT-050$ figlet -w 55 -f slant Kost Slebew | lolcat -a

```

Outputnya akan menjadi seperti ini:

![Desain Text](<Assets/Soal_3/Kost_Slebew.png>)

**Fitur 1**

Lalu untuk fitur yang pertama kita diminta untuk membuat fitur yang dapat menambah penghuni dengan memasukkan inputan berupa nama, kamar, harga sewa, tanggal masuk dan status. Inputan tersebut memiliki syarat sebagai berikut format tanggal tidak boleh salah yaitu (YYYY-MM--DD), tanggal tidak boleh melebihi hari ini, harga sewa harus angka positif dan nomor kamar tidak boleh ada yang sama. Pertama saya membuat file scripth bernama kost_slebew.sh lalu saya menggunakan kode dibawah ini:

```bash
#!/bin/bash

if [[ "$1" == "--check-tagihan" ]]; then 

tgl_rekap=$(date "+%Y-%m-%d %H:%M")

awk -F "," -v tgl="$tgl_rekap" '$5 ~ /Menunggak/ {
	printf "[/%s] TAGIHAN: <%s>, (Kamar <%s>) - Menunggak Rp<%s>\n", tgl , $1 , $2 , $4}' 
./data/penghuni.csv >> ./log/tagihan.log

exit 0

fi

while true; do
clear
figlet -w 55 -f slant Kost Slebew | lolcat -a

echo "===================================="
echo "    Sistem Manajemen Kost Slebew    "
echo "===================================="
echo "ID | OPTION"
echo "------------------------------------"
echo "1 | Tambah Penghuni Baru"
echo "2 | Hapus Penghuni"
echo "3 | Tampilkan Daftar Penghuni"
echo "4 | Update Status Penghuni"
echo "5 | Cetak Laporan Keuangan"
echo "6 | Kelola Cron (Pengingat Tagihan)"
echo "7 | Exit Program"
echo "===================================="
echo "Enter option [1-7]: "
read pilihan

case $pilihan in
1)
    clear
	echo "===================================="
    echo "        TAMBAH PENGHUNI BARU        "
	echo "===================================="
        read -p "Masukkan Nama: " nama

	while true; do
        read -p "Masukkan Nomor Kamar: " kamar
	#Memvalidasi agar tidak ada no kamar yang sama 
	if grep -q "^.*,$kamar" ./data/penghuni.csv; then 
	echo -e "\e[31m[!] Error: Kamar $kamar sudah terisi!\e[0m"
	    else
	break #Kamar tersedia kelaur dari loop 
	    fi
	done

	while true; do
	read -p "Masukkan Harga Sewa: " sewa
	if [[ "$sewa" =~ ^[0-9]+$ ]] && [[ "$sewa" -gt 0 ]]; then
	break
	else
	   echo -e "\e[31m[!] Error: Harga sewa harus berupa angka positif!\e[0m"
	   fi
	done

	while true; do
	read -p "Masukkan Tanggal Masuk (YYYY-MM-DD): " tanggal

	detik_input=$(date -d "$tanggal" +%s)
        detik_sekarang=$(date +%s)

	#Memastikan tanggal sesuai format
	if date -d "$tanggal" "+%Y-%m-%d" >/dev/null 2>&1; then
	
	#Memastikan tanggal tidak melewati hari ini
        if [ "$detik_input" -gt "$detik_sekarang" ]; then
        echo -e "\e[31m[!] Error: Tanggal tidak boleh melebihi hari ini!\e[0m"

	else
		break
	fi

	else
	 #Jika dari awal formatnya salah
	 echo -e "\e[31m[!] Error: Format tanggal salah! Gunakan YYYY-MM-DD\e[0m"
	fi

	done


        read -p "Masukkan Status Awal (Aktif/Menunggak): " status

	echo "$nama,$kamar,$tanggal,$sewa,$status" >> ./data/penghuni.csv

	# Menampilkan hasil dengan warna hijau (kode \e[32m)
        echo -e "\e[32m[✓] Penghuni \"$nama\" berhasil ditambahkan ke Kamar \"$kamar\" dengan status \"$status\"\e[0m"

            echo "Tekan [ENTER] untuk kembali ke menu"
            read # Menunggu user menekan enter
            ;;

```
Jadi disitu saya membuat fitur looping dengan menggunakan while loop yang akan terus mengeloop sampai user menginput angka 7 yaitu exit, di tampilan awal tersebut saya juga menggunakan text ascii figlet dan lolcat seperti yang telah saya jelaskan diatas, untuk mendapatkan input dari user saya menggunakan perintah read -p karena selain saya bisa mendapat input dari user saya juga dapat mengeluarkan output secara bersamaan, untuk pengkondisian agar tidak ada nomor kamar yang sama saya menggunakan perintah grep -q lalu mengecek apakah ada nomor kamar yang sama seperti yang diinputkan oleh user di file penghuni.csv yang berfungsi sebagai database tempat menyimpan data-data dari penghuni kost. Lalu jika ternyata kamar telah terisi maka program akan secara otomatis memberi peringatan dengan warna teks merah karena saya menggunakan _\e[31m_. Untuk pengkondisian selanjutnya yaitu harga sewa harus positif saya menggunakan perintah if untuk mengecek apakah angka yang diinput oleh user melebihi 0 dan merupakan angka dari 1-9. Setelah itu untuk pengkondisian tanggal saya menggukan perintah bawaan dari linux yaitu date yang dapat mengecek format dari tanggal dan mengecek apakah tanggal melebihi hari ini. Setelah itu saya memasukkan data-data tadi kedalam file penghuni.csv dan menampilkan hasil dengan warna hijau.

Output tampilan awal:

![Tampilan awal](<Assets/Soal_3/Tampilan awal.png>)

Output dari fitur pertama create:

![Benar](<Assets/Soal_3/JikaInputBenar.png>)

Jika input salah:

![Salah](<Assets/Soal_3/JikaInputSalah.png>)

**Fitur 2**

Lanjut untuk fitur kedua kita diminta untuk membuat fitur hapus penghuni, saya menggunakan kode dibawah ini:

```bash
2)
	clear
	echo "===================================="
	echo "           HAPUS PENGHUNI           "
    echo "===================================="
	read -p "Masukkan nama penghuni yang akan dihapus: " hapusnama

	if ! grep -q "$hapusnama" ./data/penghuni.csv; then 
	echo "\e[31m[!] Error: Nama penghuni tidak ditemukan \e[0m"

	else 
	
	data_penghuni=$(grep "$hapusnama" ./data/penghuni.csv)
	
	echo "Nama penghuni ditemukan!"
	read -p "Yakin ingin menghapus? (y/n): " konfirmasi

	if [[ "$konfirmasi" == "Y" || "$konfirmasi" == "y" ]]; then 
	
	#menentukan tanggal keluar 
	tgl_keluar=$(date "+%Y-%m-%d")

	#simpan ke history_hapur
	echo "$data_penghuni, $tgl_keluar" > ./sampah/history_hapus.csv

	#hapus dari database utama
	sed -i "/$hapusnama/d" ./data/penghuni.csv

	echo -e "\n\e[32m[✓] $hapusnama telah keluar pada $tgl_keluar.\e[0m"
	echo "[i] Data telah dipindahkan ke history_hapus.csv"

	else
	echo -e  "\e[31mPembatalan penghapusan!\e[0m"
	    fi

	fi

	echo "Tekan [ENTER] untuk kembali ke menu"
        read # Menunggu user menekan enter
	;;


```
Jadi diawal kode saya mengecek apakah inputan nama dari user ada dalam file penghuni.csv jika tidak ada maka akan diberi peringatan, jika ada maka akan muncul _Nama penghuni ditemukan_ disitu saya juga menambahkan fitur two step verification dengan menanyakan user apakah yakin ingin menghapus data penghuni tersebut. Dikode tersebut saya menyimpan semua data dari penghuni yang akan dihapus kedalam variabel data_penghuni agar saya bisa menyimpannya di file history_hapus.csv, sebelum itu saya juga sudah mencatat tanggal penghuni tersebut keluar dengan perintah date. Selanjutnya saya menghapus data dari penghuni tersebut di file penghuni.csv menggunakan perintah sed jika berhasil akan keluar output berupa nama dari penghuni telah keluar tgl_keluar berwarna hijau. Outputnya kurang lebih seperti ini:

![Berhasil Hapus](<Assets/Soal_3/BerhasilHapus.png>)

Jika dibatalkan:

![Batal Hapus](<Assets/Soal_3/BatalHapus.png>)

**Fitur 3**

Setelah itu ke fitur yang ke 3 yaitu menampilkan daftar penghuni dalam bentuk tabel, yang kodenya seperti ini:

```bash
3)
	clear
	echo "============================================================="
	echo "                  DAFTAR PENGHUNI KOS SLEBEW                 "
	echo "============================================================="
	echo -e "No | Nama            | Kamar | Harga Sewa     | Status   |"
	echo "-------------------------------------------------------------"

	awk -F "," 'NR>0 {printf "%d | %s          |  %s  | %s       | %s |\n", NR, $1, $2, $4, $5}' ./data/penghuni.csv | column -t -s "|" -o " | "
	echo "--------------------------------------------------------------"
	penghuni=$(awk 'END {print NR}' ./data/penghuni.csv)
	Aktif=$(awk -F "," ' $5 ~ /Aktif/ {count++} END {print count+0}' ./data/penghuni.csv)
	Menunggak=$(awk -F "," '$5 ~ /Menunggak/ {count++} END {print count+0}' ./data/penghuni.csv)
	echo -e "Total: $penghuni penghuni | Aktif: \e[32m$Aktif\e[0m  | Menunggak: \e[31m$Menunggak\e[0m"
 	echo "============================================================="
	echo "Tekan [ENTER] untuk kembali ke menu"
        read # Menunggu user menekan enter
        ;;

```

Jadi di kode tersebut saya mengambil data-data yang ada di penghuni.csv menggunakan awk lalu menggabungkannya dengan pipe ke perintah column agar tabel akan secara otomatis mengikuti panjang data yang diambil dari file penghuni.csv. Setelah itu saya membuat variabel penghuni, Aktif dan Menunggak untuk menghitung total jumlah dari masing-masing kategori tersebut menggunakan awk, saya juga menggunakan warna hijau untuk output dari aktif dan warna merah untuk ouput dari menunggak. Output untuk kode tersebut adalah sebagai berikut:

![Output fitur 3](<Assets/Soal_3/OutputFitur3.png>)

**Fitur 4**

Untuk fitur ke 4 kita diminta untuk membuat sebuah fitur yang dapat merubah status dari penghuni, untuk menyelesaikan permasalahaan tersebut saya menggunakan kode seperti dibawah ini:

```bash
4)
	clear
	echo "===================================="
    echo "            UPDATE STATUS           "
    echo "===================================="
	read -p "Masukkan Nama Penghuni: " namabaru
	if grep -q "$namabaru" ./data/penghuni.csv; then
	awk -F "," -v nama=$namabaru '$1 ~ nama {printf "%s     | %s |%s   | %s \n", $1, $2, $4, $5}' ./data/penghuni.csv | column -t -s "|" -o " | "
	echo "------------------------------------"
	read -p "Masukkan Status Baru (Aktif/Menunggak): " statusbaru
	if [ "$statusbaru" == "Aktif" ]; then
	sed -i "/$namabaru/s/Menunggak/Aktif/" ./data/penghuni.csv
	elif [ "$statusbaru" == "Menunggak" ]; then
	sed -i "/$namabaru/s/Aktif/Menunggak/" ./data/penghuni.csv
	echo -e "\e[32m[✓] Status \"$namabaru\" berhasil diubah menjadi: \"$statusbaru\"\e[0m"
	else 
	echo -e "\e[31m[!] Error: Input Status Salah!\e[0m"
	
	fi

	else
	echo -e "\e[31m[!] Error: Nama Penghuni Tidak Ditemukan!\e[0m"
	
	fi
	
	echo "Tekan [ENTER] untuk kembali ke menu"
        read # Menunggu user menekan enter
        
;;	

```

Jadi diawal kode tersebut saya mengecek apakah inputan nama dari user ada di daftar penghuni.csv jika ada maka saya akan menampilkan data yang dimiliki oleh nama tersebut dalam bentuk tabel menggunakan perintah awk, setelah itu saya menggunakan perintah sed untuk mengubah yang awalnya Menunggak menjadi Aktif dan yang awalnya Aktif dapat menjadi Menunggak dengan pengkondisian if, jika inputan dari user tidak sesuai maka akan muncul peringatan __Input Status Salah__ dan jika nama yang user inputan tidak ada di file penghuni.csv maka akan muncul peringatan juga yang berbunyi __Nama Penghuni Tidak Ditemukan__. Output dari kode diatas adalah sebagai berikut:

![OutputFitur4](<Assets/Soal_3/Outputfitur4b.png>)

Jika salah:

![Output4jikasalah](<Assets/Soal_3/Outputfitur4l.png>)

**Fitur 5**
Di fitur 5 ini kita diminta untuk membuat rekap keuangan, jadi fitur ini akan secara otomatis menghitung ketika ada penghuni yang memiliki status aktif akan masuk ke kategori pemasukan, jika status penghuni menunggak akan secara otomatis masuk ke kategori tunggakan. 

```bash
5)
	clear
	echo "=============================================="
    echo "         LAPORAN KEUANGAN KOST SLEBEW         "
    echo "=============================================="
	if [ ! -s ./data/penghuni.csv ]; then
	echo -e "\e[31m[!] Data penghuni kosong!\e[0m"
	else
	pemasukan=$(awk -F "," '/Aktif/ {sum+=$4} END {print sum+0}' ./data/penghuni.csv)
	tunggakan=$(awk -F "," '/Menunggak/ {sum+=$4} END {print sum+0}' ./data/penghuni.csv)
	jumterisi=$(awk 'END {print NR}' ./data/penghuni.csv)
	echo "Total pemasukan (Aktif)   : Rp$pemasukan"
	echo "Total tunggakan           : Rp$tunggakan"
	echo "Jumlah kamar terisi       : $jumterisi Kamar"
	echo "-----------------------------------------------"
	echo "Daftar penghuni menunggak: "
	if [ $tunggakan -gt 0 ]; then
	awk -F "," '$5 ~ /Menunggak/ {printf "%s     | %s |%s   | %s \n", $1, $2, $4, $5}' ./data/penghuni.csv | column -t -s "|" -o " | "
	else
	echo "--- Tidak ada tunggakan (SLEBEW!) ---"
	fi
	echo "=============================================="
	tgl_rekap=$(date "+%Y-%m-%d %H:%M")
	echo "[$tgl_rekap] Pemasukan: $pemasukan,Tunggakan: $tunggakan,Terisi: $jumterisi" >> ./rekap/laporan_bulanan.txt
	echo -e "\n\e[32m[✓] Laporan berhasil disimpan ke rekap ./zrekap/laporan_bulanan.txt\e[0m"
	fi
	echo "Tekan [ENTER] untuk kembali ke menu"
        read # Menunggu user menekan enter
	
;;

```
Di kode tersebut saya memulai dengan mengecek apakah data penghuni kosong atau tidak menggunakan if _-s_ jika kososng akan memberikan peringatan berwarna merah, setelah itu saya membuat variabel bernama pemasukan, tunggakan dan jumterisi, untuk variabel pemasukan dia akan mencari kata Aktif dan akan menjumlahkan kolom ke 4 yaitu harga sewa di baris yang terdapat kata aktif lalu hasilnya akan berupa jumlah pemasukan yang dimiliki paman amba, setelah itu untuk variabel tunggakan kurang lebih sama dengan pemasukan yaitu mencari kata Menunggak di file penghuni.csv lalu menjumlahkan kolom ke 4 dari baris tersebut sehingga hasilnya berupa total jumlah tunggakan. Karena di fitur ke lima kita juga diminta untuk mencari tahu jumlah kamar teris,i di situ saya mengunakan awk untuk menghitung baris dari file penghuni.csv yang akan secara otomatis menghitung jumlah kamar yang terisi juga karena satu penghuni hanya memiliki satu kamar. Selanjutnya saya juga menginisialisasi tanggal rekap tersebut menggunakan perintah date lalu saya gabungkan semua variabel tersebut ke dalam output rekap dan memasukkannya ke ./rekap/laporan_bulanan.txt.
Hasilnya kurang lebih seperti ini:

![Output Fitur 5](<Assets/Soal_3/Outputfitur5.png>)

**Fitur 6**  
Di fitur ke 6 ini kita diminta untuk membuat fitur yang dapat mengelola cron seperti mendaftarkan cron job lalu melihat daftar cron job dan terkahir menghapus cron job. Fitur ini harus bisa looping sehingga user dapat memilih opsi yang lain setelah melakukan opsi saat ini lalu untuk memanggil scripth juga perlu menggunakan argumen ./kost_slebew.sh --check-tagihan. Untuk melakukan semua tugas tersebut saya menggunakan tugas dibawah ini:

```bash
#!/bin/bash

if [[ "$1" == "--check-tagihan" ]]; then 

tgl_rekap=$(date "+%Y-%m-%d %H:%M")

awk -F "," -v tgl="$tgl_rekap" '$5 ~ /Menunggak/ {
	printf "[/%s] TAGIHAN: <%s>, (Kamar <%s>) - Menunggak Rp<%s>\n", tgl , $1 , $2 , $4}' 
./data/penghuni.csv >> ./log/tagihan.log

exit 0

fi

6)
	while true; do
	clear

	echo "===================================="
	echo "          MENU KELOLA CRON          "
	echo "===================================="
	echo "1 | Lihat Cron Job Aktif"
	echo "2 | Daftarkan Cron Job Pengingat"
	echo "3 | Hapus Cron Job Pengingat"
	echo "4 | Kembali"
	echo "===================================="
	echo "Enter option [1-4]: "
	read pilihan

	case $pilihan in
1) 
clear
echo "--- Daftar Cron Jobs Pengingat Tagihan ---"
crontab -l || echo -e "\e[31m[!] Tidak ada jadwal efektif!\e[0m"
read -p "Tekan [ENTER] untuk kembali ke menu"
;;
2)
	clear
	#Mengambil alamat absolut
	SCRIPTH_PATH=$(readlink -f "$0")
	
	#Sistem overwrite
	read -p "Masukkan Jam (00-23): " jam_baru
	read -p "Masukkan Menit (0-59): " menit_baru
	(crontab -l 2>/dev/null | grep -v "$SCRIPTH_PATH"; echo "$menit_baru $jam_baru * * 1-7  $SCRIPTH_PATH --check-tagihan") | crontab -
	echo -e "\e[32mJadwal berhasil didaftarkan!\e[0m" 	
	read -p "Tekan [ENTER] untuk kembali ke menu"
;;
3) 
	clear 
	crontab -r
	echo -e "\e[32m[✓] Cron job pengingat tagihan berhasil dihapus.\e[0m"
	read -p "Tekan [ENTER] untuk kembali ke menu"
;;
4) break;;
*) echo -e "\e[31mPilihan salah!\e[0m";;
   esac	
done
;;

```
Jadi untuk bisa memanggil scripth dengan argumen --check-tagihan saya membuat pengkondisian dengan if jika $1 yang artinya string yang diinput user setelah ./kost_slebew.sh merupakan --check-tagihan maka akan secara otomatis menginisialisai tgl_rekap lalu memberikan output berupa rekapan data penghuni yang pada tanggal tersebut masih menunggak lalu hasil rekapan tersebut dimasukkan ke __./log/tagihan.log__ kode ini saya letakkan di paling atas setelah _#!/bin/bash_. Setelah itu saya membuat tampilah awal dari fitur ke 6 dengan menggunakan while loop agar selalu bisa terloop sampai user input 4. Lalu untuk pilihan satu program akan secara otomatis memanggil crontab -l dan menampilkan detail jadwal yang aktif atau peringatan tidak ada jadwal efektif jika tidak ada cron yang kita daftarkan. Selanjutnya jika user memilih opsi 2 maka program akan mencari alamat absolut dari scripth yang kita gunakan menggunakan _readlink_ lalu dimasukkan ke variabel SCRIPTH_PATH, lalu karena kita diminta untuk membuat agar jadwal cronnya hanya ada satu maka dari itu kita perlu mengoverwrite jadwal sebelumnya menggunakan _grep -v "SCRIPTH_PATH_" lalu baru memasukkan jadwal yang baru menggunakan echo. Jika user memilih opsi 3 progam akan menghapus semua daftar cron jobs yang kita miliki dengan kode _crontab -r_ dan memunculkan output bahwa kita berhasil menghapus jadwal cron jobs berwarna hijau jika user memilih selain opsi 1-4 akan ada peringatan _Pilihan salah_ berwarna merah.

Tampilan awal:

![Tampilan awal fitur 6](<Assets/Soal_3/TampilanFitur6.png>)

Opsi 1 (Lihat Cron Job Aktif):

![Output opsi 1](<Assets/Soal_3/Opsi1.png>)

Opsi 2 (Daftarkan Cron Job Pengingat):

![Output opsi 2](<Assets/Soal_3/Opsi2.png>)

Opsi 3 (Hapus Cron Job Pengingat):

![Output opsi 3](<Assets/Soal_3/Opsi3.png>)

## Refrensi
1. https://gemini.google.com/share/eaafa2c669f1
