## Programação cruzada para MSX
Este repositório contém parte da solução meio quebrada que eu construí para poder manter um ambiente de desenvolvimento em Linux, para programar em Pascal para MSX. 
Como ainda não temos um compilador cruzado de Pascal para MSX (ainda não, mas [o fpc já tem um backend Z80 em testes](https://wiki.freepascal.org/Z80)), a solução que eu fiz foi automatizar o funcionamento do OpenMSX. Logo, eu uso a IDE geany para programar. Quando pressiono uma tecla, ele chama um script em shell, que altera um segundo script em TCL (linguagem usada para fazer scripts e automatizar o OpenMSX). Ele executa o emulador, carregando uma imagem de HD com 4 partições de 32 Gb cada (o arquivo *develop.dsk.xz*), chama o Turbo Pascal 3.0, compila o código (em alta velocidade, MSX on firah) e sai do compilador. Aí, no emulador, é possível testar o código.
## Característica
 - Temos duas versões do script aqui, uma para o Turbo Pascal e outra, para o TP33F, dos holandeses. O TP33F é um compilador de linha de comando, que tropeça feio ao manipular arquivos. Mas se você não usar arquivos ou tiver outras rotinas de acesso a arquivos, melhor ainda.
 - O script examina o código fonte a ser compilado e calcula um tempo para o OpenMSX ficar operando mais rapidamente. É um ganho de tempo bacana.
## Vantagens
 - Não tem desculpa, é um compilador no MSX compilando código para MSX. :-D
 - É possível melhorar e automatizar mais coisas no script.
## Problemas
 - É uma solução menos **tosca**, convenhamos. Já foi mais.
 - Quando a gente fecha o emulador, temos que sair e voltar do diretório, porque senão os arquivos não estão disponíveis.
## Melhorias
 - Mudar o develop.dsk. Essa imagem de HD foi feita com base na imagem que o [PopolonY2K disponibilizou](http://www.popolony2k.com.br/) em algum lugar no site dele. Está bom, mas eu quero dar uma arrumada...
 - Colocar o código todo de UNIX para DOS ao copiar e o caminho contrário, quando fechar o emulador (UNIX2DOS, DOS2UNIX, sacou?).
 - Trocar as tabulações por espaços em branco, usando o comando expand.
## Maiores informações
 Tem esse link [aqui](https://www.retropolis.com.br/2020/04/06/montando-um-ambiente-de-desenvolvimento-cruzado-para-msx-ou-tentando/), onde eu expliquei em mais detalhes. E a continuação, [aqui](https://www.retropolis.com.br/2020/04/13/update-montando-um-ambiente-de-desenvolvimento-cruzado-para-msx-ou-tentando/).
## Detalhes técnicos
 Olha, depois eu vou colocar aqui, pois é necessário que as pessoas entendam. Mas não vai ser agora...
