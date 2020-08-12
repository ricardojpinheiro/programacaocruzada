(*<tpcodes.pas>
 * Turbo Pascal I/O return codes.
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: tpcodes.pas 98 2015-08-21 01:28:40Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2015-08-21 01:28:40 +0000 (Fri, 21 Aug 2015) $
  * $Revision: 98 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/tpcodes.pas $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * -
 *)

Const    ctTPSuccess          = $0;      { Success }
         ctTPFileNotFound     = $1;      { File not found }
         ctTPFileNotOpen      = $4;      { File not open }
         ctTPFileDesappeared  = $FF;     { Invalid drive }
         ctTPSeekBeyondEOF    = $91;     { Seek beyond End of file }
         ctTPUnexpectedEOF    = $99;     { Unexpected end of file   }
