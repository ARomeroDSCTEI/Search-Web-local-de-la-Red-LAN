#!/bin/bash
# -*- ENCODING: UTF-8 -*-
# Autor: Adrian Romero
# Buscar Ip de Servidor Web

echo " [(+.+)] Iniciando Escaner"
echo 

if [ $( id -u ) != 0 ]; then
	# Not ROOT
	addr=$(ip addr | grep "dynamic" | awk '/inet /{print $4}' | tr "." "\n" );
else
	# Solo ROOT
	addr=$(ifconfig | awk '/inet addr/{print substr($2,6)}' | tr '\n' ' ' | tr "." "\n");
fi

ip="";
i=0;
	
for x in $addr; do
	ip=$ip$x.
	i=$(( $i + 1 ))
	if [ $i -eq 3 ]; then
		break;
	fi
done

i=1;

while [ 1 ]; do
    echo  [-] $ip$i;
	wget -q -nv -t 1 --timeout=1 -S $ip$i -O /dev/null > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo -e "\033[1;42m[+] Servidor Web: $ip$i \033[m";
	fi
	i=$(( $i + 1 ));
	if [ $i -eq "256" ]; then
		break;
	fi
done