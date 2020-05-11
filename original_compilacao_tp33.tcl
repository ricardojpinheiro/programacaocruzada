#   Compilation TCL Script Copyright (C) since whatever by Ricardo Jurczyk Pinheiro
#   Based on HardDisk loader from PopolonY2K
#   This program comes with ABSOLUTELY NO WARRANTY;
#   This is free software, and you are welcome to redistribute it
#   under certain conditions;

# Aqui ele define a variável scriptPath, que define onde está o script TCL.

variable scriptPath [file dirname [info script]] ; # O caminho do script

# Aqui ele define qual será a imagem de HD a ser usada. Usamos uma que tem
# várias ferramentas de desenvolvimento.

set hdFile %%DISCO%% ; # The harddisk file that will be loaded

# Aqui ele desliga o MSX, define que vai usar uma interface IDE e seta qual
# é o HD.

set power off
ext ide
hda $hdFile

# Aqui, ele formata a 4a partição, e importa a sandbox para ser essa partição.

diskmanipulator format hda4
diskmanipulator import hda4 %%SANDBOX%%

# Aqui, ele liga o MSX e faz um overclock de 10000% (MSX on firah). 

set power on
after boot "set speed 10000"

# Após 16 unidades de tempo, ele executa o script COMPILA.BAT.
# Após x unidades de tempo, ele exporta o conteúdo da 4a partição para a pasta.
# Após y unidades de tempo, ele baixa a velocidade para a padrão.

after time 16 "type d:compila.bat ; type \\r"
after time %%TEMPO2%% "diskmanipulator export hda4 /home/ricardo/MSX/programacao/dev/sandbox"
after time %%TEMPO3%% "set speed 100"
