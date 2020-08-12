(**<quebios.pas>
  * MSX-BIOS addresses related to queue management.
  * Copyright (c) since 1995 by PopolonY2k.
  *)

(**
  *
  * $Id: quebios.pas 98 2015-08-21 01:28:40Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2015-08-21 01:28:40 +0000 (Fri, 21 Aug 2015) $
  * $Revision: 98 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/quebios.pas $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * -
 *)

(* MSX BIOS address functions *)

Const     ctLFTQ    = $00F6;      { Return the number of bytes in queue      }
          ctPUTQ    = $00F9;      { Put byte in queue                        }
