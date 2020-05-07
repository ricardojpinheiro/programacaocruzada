# Programação cruzada para MSX
Este repositório contém parte da solução meio quebrada que eu construí para poder manter um ambiente de desenvolvimento em Linux, para programar em Pascal para MSX. 
Como ainda não temos um compilador cruzado de Pascal para MSX (ainda não, mas [o fpc já tem um backend Z80 em testes](https://wiki.freepascal.org/Z80)), a solução que eu fiz foi automatizar o funcionamento do OpenMSX. Logo, eu uso a IDE geany para programar. Quando pressiono uma tecla, ele chama um script em shell, que altera um segundo script em TCL (linguagem usada para fazer scripts e automatizar o OpenMSX). Ele executa o emulador, carregando uma imagem de HD com 4 partições de 32 Gb cada (o arquivo *develop.dsk.xz*), chama o Turbo Pascal 3.0, compila o código (em alta velocidade, MSX on firah) e sai do compilador. Aí, no emulador, é possível testar o código.

## Vantagens
 - Não tem desculpa, é um compilador no MSX compilando código para MSX. :-D
 - É possível melhorar e automatizar mais coisas no script.
 - Tem uma outra versão que usa o TP33F, dos holandeses (compilador de linha de comando) para compilar o código. Mas ele tropeça feio ao manipular arquivos. Mesmo assim, pode ser também.
## Problemas
 - É uma solução **tosca**, convenhamos. Um baita dum remendo. Não é elegante.
 - Quando a gente fecha o emulador, temos que sair e voltar do diretório, porque senão os arquivos não estão disponíveis.
## Melhorias
 - Seria bom melhorar o script para analisar o tamanho do código e variar o tempo no qual o MSX emulado opera mais rapidamente (quanto maior, mais tempo fica). Só que aí o script teria que analisar as bibliotecas também.
 ## Maiores informações
 Tem esse link [aqui](https://www.retrocomputaria.com.br/2020/04/06/montando-um-ambiente-de-desenvolvimento-cruzado-para-msx-ou-tentando/), onde eu expliquei em mais detalhes. E a continuação, [aqui](https://www.retrocomputaria.com.br/2020/04/13/update-montando-um-ambiente-de-desenvolvimento-cruzado-para-msx-ou-tentando/).
 ## Detalhes técnicos
 Olha, depois eu vou colocar aqui, pois é necessário que as pessoas entendam. Mas não vai ser agora...



