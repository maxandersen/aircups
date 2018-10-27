#!/bin/sh
/usr/bin/inotifywait -m -e close_write,moved_to,create /etc/cups | 
while read -r directory events filename; do
	if [ "$filename" = "printers.conf" ]; then
		echo "printers.conf changed. Deleteting (if any) old airprint services."
		rm -rf /services/AirPrint-*.service
		echo "Generating airprint services for all shared printers"
		./airprint-generate.py -d /services
		cp /etc/cups/printers.conf /config/printers.conf
		#rsync -avh /services/ /etc/avahi/services/
		echo "Completed update."
	else
		echo "printers.conf not changed"
	fi
done
