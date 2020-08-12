(*<iohandle.pas>
 * Common I/O handle for use in conjunction with the abstract I/O functions
 * created to handle with multiple devices in multiple versions of
 * MSXDOS.
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: iohandle.pas 98 2015-08-21 01:28:40Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2015-08-21 01:28:40 +0000 (Fri, 21 Aug 2015) $
  * $Revision: 98 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/iohandle.pas $
  *)

(*
 * This source file depends on following include files (respect the order):
 * - types.pas;
 * - suntypes.pas;
 *)

Const     ctDefIOBufferSize     = 128;     { Default I/O buffer size }

(**
  * Internal data buffer definition.
  *)
Type      PDataBuffer = ^Byte;

(**
  * I/O buffer pointer management structure.
  *)
Type TBufferCtrl = Record
  nDevicePtr        : TInt24;
  nMemoryPtr        : Integer;
  nDeviceBufferSize : Integer;
  pDevData          : PDataBuffer;
End;

(**
  * File control structure.
  *)
Type TFileCtrl = Record
  strFileName        : TFileName;
  fpFile             : File;
  nFileHandle        : Byte;       { File handle for MSXDOS2 }
End;

(**
  * IDE control structure.
  *)
Type TIDECtrl = Record
  info                 : TIDEInfo;
  ptrDriveField        : PDriveField;
  bAbsoluteStartSector : Boolean;
End;

(**
  * Operating system environment information structure.
  *)
Type TOSEnvironment = Record
  nOSVersion : Byte;
End;

(**
  * Error handling structure.
  *)
Type TErrorHandling = Record
  nErrorCode    : Integer;
  strMessage    : TShortString;
End;

(**
  * I/O Device control structure.
  *)
Type TDeviceCtrl = Record
  Buffer               : TBufferCtrl;
  FileCtrl             : TFileCtrl;
  IDECtrl              : TIDECtrl;
  OSEnv                : TOSEnvironment;
  Error                : TErrorHandling;
  bEndOfSector         : Boolean;
  nDeviceNumber        : Byte;
  nOpenDevFnAddr       : Integer;
  nCloseDevFnAddr      : Integer;
  nSeekDevFnAddr       : Integer;
  nReadDevFnAddr       : Integer;
  nWriteDevFnAddr      : Integer;
  nGetDevParmsFnAddr   : Integer;
  nErrorHandlingFnAddr : Integer;
End;
