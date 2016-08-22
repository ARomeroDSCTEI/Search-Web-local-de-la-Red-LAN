#!/bin/bash
# -*- ENCODING: UTF-8 -*-
# Autor: Adrian Romero
# Buscar Ip de Servidor Web

echo " [(+.+)] Iniciando Escaner"
echo 

is_root=false

if [ $( id -u ) != 0 ]; then
	# Not ROTT
	addr=$(ip addr | awk '/inet /{print substr($2,1)}' | tr " " "\n");
else
	# Solo ROOT
	is_root=true
	addr=$(ifconfig | awk '/inet addr/{print substr($2,6)}' | tr " " "\n");
fi

for ip in $addr; do
	if [ $is_root = false ]; then
		e=0;
		for t in $addr ; do
			if [ $e = 2 ]; then
				ip=$t;
				break;
			fi
			e=$(( $e + 1 ));
		done
	fi

	puntos_ip=$(echo $ip | tr "." "\n");

	ip="";
	i=0;
	
	for x in $puntos_ip; do
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

	break;
done