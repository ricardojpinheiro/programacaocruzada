#   HardDisk loader Copyright (C) since 1995  by PlanetaMessenger.org
#   This program comes with ABSOLUTELY NO WARRANTY;
#   This is free software, and you are welcome to redistribute it
#   under certain conditions;

variable scriptPath [file dirname [info script]] ; # The current script path

set hdFile $scriptPath/develop.dsk ; # The harddisk file that will be loaded

set power off
ext ide
hda $hdFile
set power on
