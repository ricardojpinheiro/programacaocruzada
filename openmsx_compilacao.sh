#!/bin/sh
# Variaveis
ARQUIVO=$1
EXECUTAVEL=$(echo $ARQUIVO | sed 's/pas/com/')
DIRETORIO="$HOME/MSX/programacao"
SCRIPT_TCL_ORIGINAL=$DIRETORIO"/original_compilacao.tcl"
SCRIPT_TCL=$DIRETORIO"/compilacao.tcl"
DISCO_ORIGINAL=$DIRETORIO"/develop.dsk"
DISCO=$(echo $DISCO_ORIGINAL | sed 's/\//\\\//g')
SANDBOX_ORIGINAL=$DIRETORIO"/dev/sandbox/"
SANDBOX=$(echo $SANDBOX_ORIGINAL | sed 's/\//\\\//g')
#BATCH_COMPILACAO=$SANDBOX_ORIGINAL"/compila.bat"
TEMPORARIO=$(mktemp)
#
# A cada vez que é executado, o script apaga todo o conteúdo da sandbox,
# recria o diretório e copia tudo para lá.
rm -rf $SANDBOX_ORIGINAL
mkdir $SANDBOX_ORIGINAL
cp -rf $PWD/* $SANDBOX_ORIGINAL
#
# Aqui ele altera o script TCL, para ser executado no boot do OpenMSX.
# Detalhe para os comandos sed: No arquivo TCL original tem 4 tags, que precisam ser
# alteradas. Dividi em duas linhas para facilitar o entendimento. 
# Nas variáveis DISCO e SANDBOX, tive que fazer uma mexida (lá em cima)
# pra garantir que as barras (/) apareçam.
cat $SCRIPT_TCL_ORIGINAL | sed "s/##PAS##/$ARQUIVO/" | sed "s/##COM##/$EXECUTAVEL/" > $TEMPORARIO
cat $TEMPORARIO | sed "s/##DISCO##/$DISCO/" | sed "s/##SANDBOX##/$SANDBOX/" > $SCRIPT_TCL
#
# Executa o emulador pra compilar o programa. A configuração é um MSX 2
# caprichado, e o script que faz o milagre é um script em TCL, definido
# no alto desse arquivo de configuração.
openmsx -machine Boosted_MSX2_EN -script $SCRIPT_TCL
#
# Quando o OpenMSX é encerrado, o script retoma o controle, e faz o 
# caminho contrário: Ele apaga os arquivos da pasta original e copia
# todos os arquivos de volta pra lá.
rm $PWD/*
#mkdir $PWD
cp -rf $SANDBOX/* $PWD 
