(*<vgmmem.pas>
 * Library for VGM music handling.
 * Check for newer VGM format definition at following URL address below
 * http://www.smspower.org/Music/VGMFileFormat?from=Development.VGMFormat
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: $
  * $Author: $
  * $Date: $
  * $Revision: $
  * $HeadURL: $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * - types.pas;
 * - vgmtypes.pas;
 *)


(**
  * Releases the VGM loaded by @see OpenVGM function. Call this method
  * is mandatory when the user won't use the VGM data content anymore.
  * This releases all allocated memory for the VGM data.
  * @param data Reference to the @see TVGMData with the data
  * to be released;
  *)
Procedure ReleaseVGM( Var data : TVGMData );
Begin
  data.pVGMSongBuffer := Nil;
End;
