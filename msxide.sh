#!/bin/sh
# Variaveis
ARQUIVO=$1
ERRO=$(echo $ARQUIVO | sed 's/pas/err/')
DIRETORIO="$HOME/MSX/programacao"
#
# Cria os pontos de montagem se eles nao existirem
for ((i=1;i<=4;i++)); do
	if [ ! -d "$i" ]; then mkdir $i ; fi
done
#
# Pede senha pra montar o HD
pkexec --user root ls > /dev/null 2>&1
sudo mount -o loop,rw,offset=$((1 	* 512)) -t msdos develop.hd 1/ 
sudo mount -o loop,rw,offset=$((65536  	* 512)) -t msdos develop.hd 2/
sudo mount -o loop,rw,offset=$((131071 	* 512)) -t msdos develop.hd 3/
sudo mount -o loop,rw,offset=$((196606 	* 512)) -t msdos develop.hd 4/
#
#

echo "turbo.com $ARQUIVO /c /r$ERRO" > /home/ricardo/MSX/programacao/desenvolvimento/autoexec.bat
find /home/ricardo/MSX/programacao/desenvolvimento/ -name "*~" -or -name "*.err" -delete
openmsx -machine Panasonic_FS-A1ST -diska /home/ricardo/MSX/programacao/desenvolvimento/. -setting /home/ricardo/.openMSX/share/compilacao.xml
