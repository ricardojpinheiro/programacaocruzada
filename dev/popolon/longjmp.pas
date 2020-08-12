(*<longjmp.pas>
 * Long jump implementation for Turbo Pascal 3.
 * Unfortunately this feature doesn't exist in TP3 core language.
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
 * This source file depends on following include files (respect the order):
 * -
 *)


(**
  * Set the jump address for long jumps;
  * @param nJmpAddr The returned long jump address;
  *)
Procedure SetJmp( Var nJmpAddr : Integer );
Var
        nAddr : Integer;

Begin
  (*
   * The ASM routine below is located in the .\ASM\ project folder
   * and was generated by INLASS.
   * Source code: asm\system\setjmp.asm
   *)
   Inline(
           $E1         {  POP  HL           }
           /$D1        {  POP  DE           }
           /$22/nAddr  {  LD   (nAddr),HL   }
           /$D5        {  PUSH DE           }
           /$E5        {  PUSH HL           } );

  nJmpAddr := nAddr;
End;

(**
  * Perform a Long Jump address for a given address;
  * @param nJmpAddr The address to perform a long jump;
  *)
Procedure LongJmp( nJmpAddr : Integer);
Begin
  (*
   * The ASM routine below is located in the .\ASM\ project folder
   * and was generated by INLASS.
   * Source code: asm\system\longjmp.asm
   *)
  Inline(
          $2A/nJmpAddr  { LD HL,(nJmpAddr)     }
          /$E9          { JP (HL)              } );
End;
