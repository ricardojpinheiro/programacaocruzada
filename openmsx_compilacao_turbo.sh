#!/bin/sh
# Variaveis
ARQUIVO=$(basename $1)
EXECUTAVEL=$(echo $ARQUIVO | sed 's/pas/com/')
DIRETORIO="$HOME/MSX/programacao"
SCRIPT_TCL_ORIGINAL=$DIRETORIO"/original_compilacao_turbo.tcl"
SCRIPT_TCL=$DIRETORIO"/compilacao.tcl"
DISCO_ORIGINAL=$DIRETORIO"/develop.dsk"
DISCO=$(echo $DISCO_ORIGINAL | sed 's/\//\\\//g')
SANDBOX_ORIGINAL=$DIRETORIO"/dev/sandbox/"
SANDBOX=$(echo $SANDBOX_ORIGINAL | sed 's/\//\\\//g')
TEMP1=$(mktemp)
TEMP2=$(mktemp)
#
# Remove lixo da pasta que contém o programa a ser compilado.
find $PWD -name "*~" -or -name "*.err" -or -name "*.bak" -delete
#
# A cada vez que é executado, o script apaga todo o conteúdo da sandbox,
# recria o diretório e copia tudo para lá.
rm -rf $SANDBOX_ORIGINAL
mkdir $SANDBOX_ORIGINAL
cp -rf $PWD/* $SANDBOX_ORIGINAL
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
TEMPO1=$((($LINHAS / 12)))
TEMPO2=$((TEMPO1 + 2))
TEMPO3=$((TEMPO1 + 5))
#
# Aqui ele altera o script TCL, para ser executado no boot do OpenMSX.
# Detalhe para os comandos sed: No arquivo TCL original tem 6 tags, que precisam ser
# alteradas. Dividi em três linhas para facilitar o entendimento. 
# Nas variáveis DISCO e SANDBOX, tive que fazer uma mexida (lá em cima)
# pra garantir que as barras (/) apareçam.
cat $SCRIPT_TCL_ORIGINAL | sed "s/##PAS##/$ARQUIVO/" | sed "s/##COM##/$EXECUTAVEL/" > $TEMP1
cat $TEMP1 | sed "s/##TEMPO1##/$TEMPO1/"| sed "s/##TEMPO2##/$TEMPO2/" | sed "s/##TEMPO3##/$TEMPO3/" > $TEMP2
cat $TEMP2 | sed "s/##DISCO##/$DISCO/" | sed "s/##SANDBOX##/$SANDBOX/" > $SCRIPT_TCL
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
cp -rf $SANDBOX/* $PWD 
