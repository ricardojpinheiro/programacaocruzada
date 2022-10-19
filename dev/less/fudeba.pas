{
   fudeba.pas
   
   Copyright 2022 Ricardo Jurczyk Pinheiro <ricardojpinheiro@gmail.com>
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
   
}

program fudeba;

{$i d:defs.inc}
{$i d:conio.inc}
{$i d:dos.inc}
{$i d:readvram.inc}
{$i d:fillvram.inc}
{$i d:fastwrit.inc}
{$i d:txtwin.inc}
{$i d:blink.inc}

BEGIN
	EditWindowPtr := MakeWindow(0, 1, 80, 24, 'Teste');
	GotoWindowXY(EditWindowPtr, 1, 1);
	WriteLnWindow(EditWindowPtr, 'Isto é um teste');
	Line1 := 	'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ' 
		+ 		'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, '
		+		'when an unknown printer took a galley of type and scrambled it to make a type specimen book.';
	WriteLnWindow(EditWindowPtr, Line1);
	read(kbd, c);
	ScrollWindowUp(EditWindowPtr); 
	read(kbd, c);
	ScrollWindowDown(EditWindowPtr);
	read(kbd, c);
	EraseWindow(EditWindowPtr);
END.

