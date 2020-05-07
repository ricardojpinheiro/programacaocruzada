#!/bin/sh
ARQUIVO=$(echo $1 | sed 's/pas/com/')
echo $ARQUIVO
cat /home/ricardo/MSX/programacao/desenvolvimento/lst_exec.txt | sed "s/%ARQUIVO%/$ARQUIVO/" > /home/ricardo/MSX/programacao/desenvolvimento/autoexec.bat
find /home/ricardo/MSX/programacao/desenvolvimento/ -name "*~" -or -name "*.err" -delete
openmsx -machine Panasonic_FS-A1ST -diska /home/ricardo/MSX/programacao/desenvolvimento/. -setting /home/ricardo/.openMSX/share/settings.xml
