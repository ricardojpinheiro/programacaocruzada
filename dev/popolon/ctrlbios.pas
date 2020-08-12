(**<ctrlbios.pas>
  * MSX-BIOS addresses related to controllers management.
  * Copyright (c) since 1995 by PopolonY2k.
  *)

(**
  *
  * $Id: ctrlbios.pas 98 2015-08-21 01:28:40Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2015-08-21 01:28:40 +0000 (Fri, 21 Aug 2015) $
  * $Revision: 98 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/ctrlbios.pas $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * -
 *)

(* MSX BIOS address functions *)

Const     ctGTSTCK  = $00D5;      { Return the joystick status               }
          ctGTTRIG  = $00D8;      { Return current trigger status            }
          ctGTPAD   = $00DB;      { Return current touch pad status          }
          ctGTPDL   = $00DE;      { Return current value of paddle           }
