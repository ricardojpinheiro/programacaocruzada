#!/bin/sh
# Variaveis
ARQUIVO=$1
ERRO=$(echo $ARQUIVO | sed 's/pas/err/')
DIRETORIO="$HOME/MSX/programacao"
SCRIPT_TCL=$DIRETORIO"/compilacao.tcl"
#DISCO=$DIRETORIO"/develop.dsk"
SANDBOX=$DIRETORIO"/dev/sandbox/"
BATCH_COMPILACAO=$SANDBOX"/compila.bat"
#
# Remove lixo da pasta que contém o programa a ser compilado.
find $PWD -name "*~" -or -name "*.err" -delete
#
# A cada vez que é executado, o script apaga todo o conteúdo da sandbox,
# recria o diretório e copia tudo para lá.
rm -rf $SANDBOX
mkdir $SANDBOX
cp $PWD/* $SANDBOX
#
# Aqui ele cria um COMPILA.BAT, para ser executado no boot do OpenMSX.
# Detalhe para os comandos sed: O primeiro remove os espaços em branco
# (necessários para não confundir código de controle com barra invertida.
# O segundo transforma o arquivo de "UNIX" para "DOS".
echo "d:" > $BATCH_COMPILACAO
printf "c:\\ tp3\\ tp33f.com %s /r%s \r\n" $ARQUIVO $ERRO >> $BATCH_COMPILACAO
sed -i 's/ tp3/tp3/g' $BATCH_COMPILACAO
sed -i 's/$/\r/' $BATCH_COMPILACAO
#
# Executa o emulador pra compilar o programa. A configuração é um MSX 2
# caprichado, e o script que faz o milagre é um script em TCL, definido
# no alto desse arquivo de configuração.
openmsx -machine Boosted_MSX2_EN -script $SCRIPT_TCL
#
# Quando o OpenMSX é encerrado, o script retoma o controle, e faz o 
# caminho contrário: Ele apaga a pasta original, recria-a e copia
# todos os arquivos de volta pra lá.
rm -rf $PWD
mkdir $PWD
cp $SANDBOX/* $PWD 
