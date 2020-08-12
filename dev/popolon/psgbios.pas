(**<psgbios.pas>
  * MSX-BIOS addresses related to PSG management.
  * Copyright (c) since 1995 by PopolonY2k.
  *)

(**
  *
  * $Id: psgbios.pas 98 2015-08-21 01:28:40Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2015-08-21 01:28:40 +0000 (Fri, 21 Aug 2015) $
  * $Revision: 98 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/psgbios.pas $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * -
 *)

(* MSX BIOS address functions *)

Const     ctGICINI  = $0090;      { Initialize PSG and static data for PLAY  }
          ctWRTPSG  = $0093;      { Write data to the PSG register           }
          ctRDPSG   = $0096;      { Read data from PSG register              }
          ctSTRTMS  = $0099;      { Check/start background tasks for PLAY    }
