#   Compilation TCL Script Copyright (C) since whatever by Ricardo Jurczyk Pinheiro
#   Based on HardDisk loader from PopolonY2K
#   This program comes with ABSOLUTELY NO WARRANTY;
#   This is free software, and you are welcome to redistribute it
#   under certain conditions;

# Aqui ele define a variável scriptPath, que define onde está o script TCL.

variable scriptPath [file dirname [info script]] ; # O caminho do script

# Aqui ele define qual será a imagem de HD a ser usada. Usamos uma que tem
# várias ferramentas de desenvolvimento.

set hdFile ##DISCO## ; # The harddisk file that will be loaded

# Aqui ele desliga o MSX, define que vai usar uma interface IDE e seta qual
# é o HD.

set power off
ext ide
hda $hdFile

# Aqui, ele formata a 4a partição, e importa a sandbox para ser essa partição.

diskmanipulator format hda4
diskmanipulator import hda4 ##SANDBOX##

# Aqui, ele liga o MSX e faz um overclock de 10000% (MSX on firah). 

set power on
after boot "set speed 10000"

# Após 16 unidades de tempo, ele executa o Turbo Pascal e compila como um .com o arquivo solicitado.
# Após 34 unidades de tempo, ele sai do Turbo Pascal, vai pro drive D e executa o arquivo .com.
# Após 50 unidades de tempo, ele exporta o conteúdo do drive D pra pasta na máquina.
# Após 70 unidades de tempo, ele baixa a velocidade para a padrão.

after time 16 "type turbo\\rn\\ro\\rc\\rq\\rcd:##PAS##\\r"
after time ##TEMPO1## "type q\\rd:\\r##COM##\\r"
after time ##TEMPO2## "set speed 100"
after time ##TEMPO3## "diskmanipulator export hda4 ##SANDBOX##"



