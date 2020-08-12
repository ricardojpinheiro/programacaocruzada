(*<mddtypes.pas>
 * MSXDD data types definition.
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: mddtypes.pas 98 2015-08-21 01:28:40Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2015-08-21 01:28:40 +0000 (Fri, 21 Aug 2015) $
  * $Revision: 98 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/mddtypes.pas $
  *)

(*
 * This source file depends on following include files (respect the order):
 * - types.pas;
 *)

Const     ctScreenPageSize = 128;     { Default screen page size }
          ctMaxSectorDec   = 11;      { Maximum sector decimal - 24Bit }

(**
  * The command-line startup parameters.
  *)
Type TCmdLineParms = Record
  bDrive               : Boolean;
  bFile                : Boolean;
  bHelp                : Boolean;
  bSector              : Boolean;
  bAbsoluteStartSector : Boolean;
  nDriveNumber         : Byte;
  strFileName          : TFileName;
  strDriveLetter       : String[2];
  strSectorNumber      : String[ctMaxSectorDec];
End;
