(*<systypes.pas>
 * Type definition for system operations related.
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: systypes.pas 103 2020-06-17 00:40:53Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2020-06-17 00:40:53 +0000 (Wed, 17 Jun 2020) $
  * $Revision: 103 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/systypes.pas $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * -
 *)


(**
  * The host interrupt timing.
  *)
Type THostInterruptTiming = ( TimingUndefined, Timing50Hz, Timing60Hz );


(**
  * MSX system variables for timming control.
  *)
Var
         JIFFY     : Integer Absolute $FC9E; { MSX JIFFY variable  }
