#!/bin/sh
# Variaveis
ARQUIVO=$1
ERRO=$(echo $ARQUIVO | sed 's/pas/err/')
DIRETORIO="$HOME/MSX/programacao"
SCRIPT_TCL=$DIRETORIO"/compilacao.tcl"
#DISCO=$DIRETORIO"/develop.dsk"
SANDBOX=$DIRETORIO"/dev/sandbox/"
BATCH_COMPILACAO=$SANDBOX"/compila.bat"
UNIX2DOS=$(which unix2dos)
#
# Remove lixo
find $DIRETORIO -name "*~" -or -name "*.err" -delete
#
# Altera o COMPILA.BAT
echo "d:" > $BATCH_COMPILACAO
echo "c:\tp3\turbo.com $ARQUIVO /r$ERRO" >> $BATCH_COMPILACAO
$UNIX2DOS $BATCH_COMPILACAO
#
# Executa o emulador pra compilar o treco
openmsx -machine Boosted_MSX2_EN -script $SCRIPT_TCL
