#!/bin/bash
clear 
echo installing Dnsutils.. 
apt install dnsutils
echo Done.. 
echo installing Apache2.. 
apt install apache2
echo Done.. 
echo installing Bind9.. 
apt install bind9
ip a
echo ------------------------------------- 
echo "Masukkan IP Address, contoh (192.168.1.1) : " & read ip 
ip1=$(echo $ip | tr "." " " | awk '{ print $1 }') 
ip2=$(echo $ip | tr "." " " | awk '{ print $2 }') 
ip3=$(echo $ip | tr "." " " | awk '{ print $3 }') 
ip4=$(echo $ip | tr "." " " | awk '{ print $4 }') 
reip=$(echo $ip3.$ip2.$ip1) 
echo "Masukkan Domain, contoh (tkj.com) : " & read domain 
name=$(echo $domain | tr "." " " | awk '{ print $1 }') 
echo "Masukkan Nama Lengkap, contoh (I Made Deva Putra) : " & read nama
echo "Masukkan No Absen, contoh (13) : " & read absen
echo "Masukkan Kelas, contoh (XI TKJ1) : " & read kelas
cp /var/www/html/index.html /var/www/html/index.html.bak
cp index.html /var/www/html
sed -i -e 's/domain1/'$domain"/g" /var/www/html/index.html
sed -i -e 's/ip1/'$ip'/g' /var/www/html/index.html
sed -i "s/nama1/${nama}/g" /var/www/html/index.html
sed -i -e 's/noabs/'$absen'/g' /var/www/html/index.html
sed -i "s/kls/${kelas}/g" /var/www/html/index.html

cp db.127 /etc/bind/db.192 
sed -i -e 's/domain1/'$domain'/g' /etc/bind/db.192 
sed -i -e 's/domain2/www.'$domain'/g' /etc/bind/db.192 
cp db.local /etc/bind/db.$name 
sed -i -e 's/ip/'$ip'/g' /etc/bind/db.$name 
sed -i -e 's/domain/'$domain'/g' /etc/bind/db.$name 
cp named.conf.options /etc/bind/ 
sed -i -e 's/ip/'$ip'/g' /etc/bind/named.conf.options 
cp named.conf.local /etc/bind/ 
sed -i -e 's/domain/'$domain'/g' /etc/bind/named.conf.local 
sed -i -e 's/name/'$name'/g' /etc/bind/named.conf.local 
sed -i -e 's/reip/'$reip'/g' /etc/bind/named.conf.local 
cp resolv.conf /etc/ 
sed -i -e 's/ip/'$ip'/g' /etc/resolv.conf 
sed -i -e 's/domain/'$domain'/g' /etc/resolv.conf 
systemctl restart bind9 
systemctl restart apache2 
echo DONE!
systemctl status bind9
^Z
