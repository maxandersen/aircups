# maxandersen/aircups

This Alpine-based Docker image runs a CUPS instance that is meant as an AirPrint relay for printers that are already on the network but not AirPrint capable. The other images out there never seemed to work right. I forked the original to use Alpine instead of Ubuntu and work on more host OS's.

## Configuration

### Volumes:
* `/config`: where the persistent printer configs will be stored
* `/services`: where the Avahi service files will be generated
* `/var/spool/cups-pdf`: where cups-pdf will put pdf files

### Variables:
* `CUPSADMIN`: the CUPS admin user you want created
* `CUPSPASSWORD`: the password for the CUPS admin user

### Example run command:
```
docker run --name cups --restart unless-stopped  --net host\
  -v <your services dir>:/services \
  -v <your config dir>:/config \
  -v <your pdf spool dir>:/var/spool/cups-pdf \
  -e CUPSADMIN="<username>" \
  -e CUPSPASSWORD="<password>" \
  maxandersen/aircups:latest
```

## Add and set up printer:
* CUPS will be configurable at http://[host ip]:631 using the CUPSADMIN/CUPSPASSWORD.
* Make sure you select `Share This Printer` when configuring the printer in CUPS.
* ***After configuring your printer, you need to close the web browser for at least 60 seconds. CUPS will not write the config files until it detects the connection is closed for as long as a minute.***

## Acknowledgements

Based on work of [quadportnick/docker-cups-airprint](https://github.com/quadportnick/docker-cups-airprint), https://github.com/chuckcharlie/cups-avahi-airprint and 
especially https://github.com/aadl/docker-cups-alpine which had the only working out of box cups-pdf I could find.
