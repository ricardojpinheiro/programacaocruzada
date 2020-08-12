(*<ramhelp.pas>
 * RAM Helper functions to help the use of memory and API routines
 * for the UNAPI specification.
 * All function addresses and EXTBIO function call is respecting
 * the UNAPI specification reached at Konamiman site at
 * http://www.konamiman.com.
 *
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: ramhelp.pas 98 2015-08-21 01:28:40Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2015-08-21 01:28:40 +0000 (Fri, 21 Aug 2015) $
  * $Revision: 98 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/ramhelp.pas $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * - memory.pas;
 * - types.pas;
 * - msxbios.pas;
 * - extbio.pas;
 *)

(* REMOVE THIS AT THE END *)
{$i memory.pas}
{$i types.pas}
{$i msxbios.pas}
{$i extbio.pas}


(**
  * The RAM Helper structure containing the RAM helper routines.
  *)
Type TRAMHelper = Record
  nJumpTableEntries : Byte;
  { TODO: JumpTableAddresses here }
  nMappersTableAddr : Integer;
End;


(**
  * Get the RAM Helper installed routines.
  * @param helper The structure containing the RAM Helper pointers
  * to the data and routines used by the helper functions;
  *)
Function GetRAMHelper( Var helper : TRAMHelper ) : Boolean;
Var
     regs    : TRegs;
     bRet    : Boolean;

Begin
  regs.A  := $ff;
  regs.B  := 0;
  regs.D  := ctUNAPI;
  regs.E  := ctUNAPI;
  regs.HL := 0;

  ExtBIO( regs );

  bRet := ( regs.HL <> 0 );

  If( bRet )  Then
  Begin
    With helper Do
    Begin
      nJumpTableEntries := regs.A;
      nMappersTableAddr := regs.BC;
      { TODO: FINISH }
    End;
  End;

  GetRAMHelper := bRet;
End;


{ TEST }
Var
      helper : TRAMHelper;
Begin
  WriteLn( 'Is RAMHELPER installed ', GetRAMHelper( helper ) );

  WriteLn( 'ENTRIES -> ', helper.nJumpTableEntries );
  WriteLn( 'Mappers Address -> ', helper.nMappersTableAddr );
End.
