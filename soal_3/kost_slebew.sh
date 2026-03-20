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
	echo "Pembatalan penghapusan!"
	    fi

	fi

	echo "Tekan [ENTER] untuk kembali ke menu"
        read # Menunggu user menekan enter
	;;
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
	else 
	echo -e "\e[31m[!] Error: Input Status Salah!\e[0m"
	
	fi

	else
	echo -e "\e[31m[!] Error: Nama Penghuni Tidak Ditemukan!\e[0m"
	
	fi

	echo -e "\e[32m[✓] Status \"$namabaru\" berhasil diubah menjadi: \"$statusbaru\"\e[0m"
	
	echo "Tekan [ENTER] untuk kembali ke menu"
        read # Menunggu user menekan enter
        
;;	
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

7)
	exit 0
	;;

esac

done


