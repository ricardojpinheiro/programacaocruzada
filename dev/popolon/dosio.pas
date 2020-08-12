(*<dosio.pas>
 * MSXDOS and CP/M function to manage low level disk I/O operations.
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: dosio.pas 103 2020-06-17 00:40:53Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2020-06-17 00:40:53 +0000 (Wed, 17 Jun 2020) $
  * $Revision: 103 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/dosio.pas $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * - types.pas;
 * - msxdos.pas;
 *)

(**
  * Read disk sectors.
  * @param nDrv The drive number to acess the sector data;
  * @param nInitSec Start sector to read;
  * @param nNumSec Number of sector to read;
  * The sector read was stored on DMA address;
  * The function return the operation status return code;
  *)
Function AbsoluteRead( nDrv : Byte; nInitSec : Integer; nNumSec : Byte ) : Byte;
Var
     regs     : TRegs;

Begin
  regs.C  := ctAbsRead;
  regs.H  := nNumSec;
  regs.L  := nDrv;
  regs.DE := nInitSec;
  regs.A  := 0;

  MSXBDOS( regs );

  AbsoluteRead := regs.A;
End;

(**
  * Write sectors to disk.
  * @param nDrv The drive number to acess the sector data;
  * @param nInitSec Start sector to write;
  * @param nNumSec Number of sector to write;
  * The sector writen is stored on DMA address;
  * The function return the operation status return code;
  *)
Function AbsoluteWrite( nDrv : Byte; nInitSec : Integer; nNumSec : Byte ) : Byte;
Var
     regs     : TRegs;

Begin
  regs.C  := ctAbsWrit;
  regs.H  := nNumSec;
  regs.L  := nDrv;
  regs.DE := nInitSec;
  regs.A  := 0;

  MSXBDOS( regs );

  AbsoluteWrite := regs.A;
End;
