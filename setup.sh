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
echo "Masukkan IP Address contoh (192.168.1.1) : " & read ip 
ip1=$(echo $ip | tr "." " " | awk '{ print $1 }') 
ip2=$(echo $ip | tr "." " " | awk '{ print $2 }') 
ip3=$(echo $ip | tr "." " " | awk '{ print $3 }') 
ip4=$(echo $ip | tr "." " " | awk '{ print $4 }') 
reip=$(echo $ip3.$ip2.$ip1) 
echo "Masukkan Domain, contoh (tkj.com) : " & read domain 
name=$(echo $domain | tr "." " " | awk '{ print $1 }') 
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
echo DONE!
systemctl status bind9
