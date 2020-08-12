(*<AY8910.pas>
 * Library for the AY8910 soundchip handling.
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: ay8910.pas 103 2020-06-17 00:40:53Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2020-06-17 00:40:53 +0000 (Wed, 17 Jun 2020) $
  * $Revision: 103 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/ay8910.pas $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * - types.pas;
 * - sndparms.pas;
 *)

Const
         { AY8910 related constants }
         ctPortAY38910RegisterWrite : Byte = $A0; { AY-3-8910 reg. write port }
         ctPortAY38910DataWrite     : Byte = $A1; { AY-3-8910 val. write port }
         ctPortAY38910DataRead      : Byte = $A2; { AY-3-8910 val. read port  }
         ctAY8910RegCount           : Byte = $0F; { AY-3-8910 16 registers    }


(**
  * Write data to AY8910 sound chip using internal variable parameter;
  * @param __pSndChipArrayParms The AY8910 array address containing the
  * parameters like described below:
  * item[0] := AY8910 Address Register;
  * item[1] := AY8910 Data Register;
  *)
Procedure WriteAY8910Direct{( __pSndChipArrayParms : Pointer )};
Begin
  (*
   * The ASM routine below is located in the .\ASM\ project folder
   * and was generated by INLASS.
   *)
  Inline(
          $2A/__pSndChipArrayParms {  LD HL,(__pSndChipArrayParms) }
          /$0E/$A0                 {  LD C,AY8910REGWRITE          }
          /$ED/$A3                 {  OUTI                         }
          /$0C                     {  INC C                        }
          /$ED/$A3                 {  OUTI                         } );
End;

(**
  * Write data to the AY8910 sound chip. This is a wrapper method to the
  * @see WriteAY8910Direct procedure;
  * @param nRegister The register to write data;
  * @param nData The data to be written;
  *)
Procedure WriteAY8910( nRegister, nData : Byte );
Var
         aAY8910ArrayParms : Array[0..1] Of Byte;

Begin
  aAY8910ArrayParms[0] := nRegister;
  aAY8910ArrayParms[1] := nData;

  __pSndChipArrayParms := Ptr( Addr( aAY8910ArrayParms ) );
  WriteAY8910Direct{( __pSndChipArrayParms )};
End;

(**
  * Reset the AY8910 sound chip.
  *)
Procedure ResetAY8910;
Var
         aAY8910ArrayParms : Array[0..1] Of Byte;
         nRegister         : Byte;

Begin
  aAY8910ArrayParms[0] := nRegister;
  aAY8910ArrayParms[1] := 0;
  __pSndChipArrayParms := Ptr( Addr( aAY8910ArrayParms ) );

  For nRegister := 0 To ctAY8910RegCount Do
  Begin
    aAY8910ArrayParms[0] := nRegister;

    WriteAY8910Direct{( __pSndChipArrayParms )};
    Delay( ctSndChipResetDelay );
  End;
End;
