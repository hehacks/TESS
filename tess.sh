#!/bin/bash

echo -e "\e[1m \e[91m **********  TESS  ***********\n"
echo -e " A simple subdomain enumeration bash script by KU5H4GR4 5RIV45T4V \n"
echo -e "Twitter- https://twitter.com/kush_sri_3541 \n"
echo -e "Github- https://github.com/kushagrasrivastav727 \n"



if [[ $# -eq 0 ]] ;
then
	echo "Usage: bash subdomain.sh yahhoo.com"
	exit 1
else
	
    curl -s "https://certspotter.com/api/v0/certs?domain="$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1 >>$1.txt
		echo -e "\e[92m \e[1m >>> Certspotter Done"
		echo "Warning.....Patience Please!!!!"
		echo "Work in Progress....."


	curl -s "http://web.archive.org/cdx/search/cdx?url=*."$1"/*&output=text&fl=original&collapse=urlkey" |sort| sed -e 's_https*://__' -e "s/\/.*//" -e 's/:.*//' -e 's/^www\.//' | uniq >>$1.txt

		echo ">>> Webarchieve Done"
        echo "Work in Progress....."
	

    curl -s "https://crt.sh/?q=%25."$1"&output=json"| jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u|grep -o "\w.*$1" > $1.txt

		echo ">>> Crt.sh Done "
		echo "Work in Progress....."


	curl -s "https://www.threatcrowd.org/searchApi/v2/domain/report/?domain=$1"|jq .subdomains|grep -o "\w.*$1" >>$1.txt
		
		echo ">>> Threatcrowd Done"
        echo "Work in Progress....."

	curl -s "https://api.hackertarget.com/hostsearch/?q=$1"|grep -o "\w.*$1" >>$1.txt
        echo ">>> Hackertarget Done"
        echo "Work in Progress...."

	
	curl -s "https://dns.bufferover.run/dns?q=."$1 | jq -r .FDNS_A[]|cut -d',' -f2|sort -u >>$1.txt
        echo ">>> Dns bufferover Done"
        echo "Work in Progress...."


echo -e "\e[34m *****List of Domains***** \n"


	cat $1.txt|sort -u|egrep -v "//|:|,| |_|\|@" |grep -o "\w.*$1"|tee $1.txt
	
echo -e "***[Wait]*** \n"
	
	echo "Subdomain $(wc -l $1.txt|awk '{ print $1 }' )" "$~ ${1}"
	echo "File Location : "$(pwd)/"$1.txt"	

fi
