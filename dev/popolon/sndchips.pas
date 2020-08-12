(*<sndchips.pas>
 * Common parameters and structures to be used by all sound chip
 * implementation.
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: sndchips.pas 103 2020-06-17 00:40:53Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2020-06-17 00:40:53 +0000 (Wed, 17 Jun 2020) $
  * $Revision: 103 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/sndchips.pas $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * - types.pas;
 *)

(**
  * Sound chips common constants.
  *)
Const
       ctSndChipResetDelay     : Integer = $05; { Chip reset delay time       }

(**
  * Sound chips common parameter data.
  *)
Var
       __pSndChipArrayParms : Pointer;          { Sound chip buffer pointer   }

