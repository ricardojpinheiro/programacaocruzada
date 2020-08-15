#!/bin/sh
# Variaveis
ARQUIVO=$(basename $1)
ERRO=$(echo $ARQUIVO | sed 's/pas/err/')
DIRETORIO="$HOME/MSX/programacao"
SCRIPT_TCL_ORIGINAL=$DIRETORIO"/original_compilacao_tp33.tcl"
SCRIPT_TCL=$DIRETORIO"/compilacao.tcl"
DISCO=$DIRETORIO"/develop.dsk"
SANDBOX=$DIRETORIO"/dev/sandbox/"
BATCH_COMPILACAO=$SANDBOX"/compila.bat"
SED=$(which sed)
TEMP1=$(mktemp)
TEMP2=$(mktemp)
#
# Remove lixo da pasta que contém o programa a ser compilado.
find $PWD -name "*~" -or -name "*.err" -or -name "*.bak" -delete
#
# A cada vez que é executado, o script apaga todo o conteúdo da sandbox,
# recria o diretório e copia tudo para lá.
rm -rf $SANDBOX
mkdir $SANDBOX
cp -rf $PWD/* $SANDBOX
#
# Aqui o script vai contabilizar quantas linhas tem o projeto, e vai calcular
# quanto tempo será necessário que o OpenMSX fique acelerado, para poder 
# compilar o código mais rapidamente.
echo $ARQUIVO > $TEMP1
cat $ARQUIVO | grep '\$i' | cut -f2 -d":" | tr -d "}" >> $TEMP1
tr -d '\r '< $TEMP1 > $TEMP2
echo 0 >  $TEMP1
for partes in $(cat $TEMP2); do
	cat $partes | wc -l >> $TEMP1
done
LINHAS=$(paste -sd+ $TEMP1 | bc)
TEMPO1=$((($LINHAS / 100)))
TEMPO2=$((TEMPO1 + 2))
TEMPO3=$((TEMPO2 + 4))
#
# Feito isto, agora é hora de modificar o script TCL. 
cat $SCRIPT_TCL_ORIGINAL | sed "s|%%DISCO%%|$DISCO|g" | sed "s|%%SANDBOX%%|$SANDBOX|g" | sed "s|%%TEMPO2%%|$TEMPO2|g" | sed "s|%%TEMPO3%%|$TEMPO3|g" > $SCRIPT_TCL
#
# Aqui ele cria um COMPILA.BAT, para ser executado no boot do OpenMSX.
# Detalhe para os comandos sed: O primeiro remove os espaços em branco
# (necessários para não confundir código de controle com barra invertida.
# O segundo transforma o arquivo de "UNIX" para "DOS".
EXECUTAVEL=$(echo $ARQUIVO | sed "s/.pas/.com/g")
echo "d:" > $BATCH_COMPILACAO
printf "c:\\ tp3\\ tp33f.com %s /r%s \r\n" $ARQUIVO $ERRO >> $BATCH_COMPILACAO
printf "d:%s\n" $EXECUTAVEL >> $BATCH_COMPILACAO
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
rm $PWD/*
cp -rf $SANDBOX/* $PWD 

