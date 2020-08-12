(**<miscbios.pas>
  * MSX-BIOS addresses related to miscelaneous functions.
  * Copyright (c) since 1995 by PopolonY2k.
  *)

(**
  *
  * $Id: miscbios.pas 98 2015-08-21 01:28:40Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2015-08-21 01:28:40 +0000 (Fri, 21 Aug 2015) $
  * $Revision: 98 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/miscbios.pas $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * -
 *)

(* MSX BIOS address functions *)

Const     ctCHGCAP  = $0132;      { Alternates the cap lamp status           }
          ctCHGSND  = $0135;      { Alternates the 1-nit soud port status    }
          ctRSLREG  = $0138;      { Read the primary slot register           }
          ctWSLREG  = $013B;      { Write value to the primary slot register }
          ctRDVDP   = $013E;      { Read VDP status register                 }
          ctSNSMAT  = $0141;      { Return the value of keyboard line matrix }
          ctPHYDIO  = $0144;      { Execute I/O for mass storage media       }
          ctFORMAT  = $0147;      { Initialize mass storage media            }
          ctISFLIO  = $014A;      { Test if I/O to device is taking place    }
          ctOUTDLP  = $014D;      { Printer output                           }
          ctGETVCP  = $0150;      { Return pointer to play queue             }
          ctGETVC2  = $0153;      { Return pointer to var. in queue number   }
          ctKILBUF  = $0156;      { Clear keyboard buffer                    }
          ctCALBAS  = $0159;      { Execute inter slot routine of BASIC      }
