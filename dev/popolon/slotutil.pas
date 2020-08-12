(**<slotutil.pas>
  * Slot utilities management function library.
  * Copyright (c) since 1995 by PopolonY2k.
  *)

(**
  *
  * $Id: slotutil.pas 98 2015-08-21 01:28:40Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2015-08-21 01:28:40 +0000 (Fri, 21 Aug 2015) $
  * $Revision: 98 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/slotutil.pas $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * -
 *)


(**
  * Get the slot number of a given memory address passed by
  * parameter.
  * This function works only when the machine has a disk drive or hard
  * disk interface connected;
  * @param nAddress The address to check the slot number;
  *)
Function GetSlotNumberByAddress( nAddress : Integer ) : Byte;
Var
       nRAMAD0 : Byte Absolute $f341; { Slot address of RAM in page 0 }
       nRAMAD1 : Byte Absolute $f342; { Slot address of RAM in page 1 }
       nRAMAD2 : Byte Absolute $f343; { Slot address of RAM in page 2 }
       nRAMAD3 : Byte Absolute $f344; { Slot address of RAM in page 3 }
       nRet    : Byte;
Begin
  nRet := -1; { Something is wrong }

  If( ( nAddress >= $0000 ) And ( nAddress <= $4000 ) ) Then
    nRet := nRAMAD0
  Else
  If( ( nAddress > $4000 ) And ( nAddress <= $8000 ) ) Then
    nRet := nRAMAD1
  Else
  If( ( nAddress > $8000 ) And ( nAddress <= $C000 ) ) Then
    nRet := nRAMAD2
  Else
  If( ( nAddress > $C000 ) And ( nAddress <= $FFFF ) ) Then
    nRet := nRAMAD3;

  GetSlotNumberByAddress := nRet;
End;
