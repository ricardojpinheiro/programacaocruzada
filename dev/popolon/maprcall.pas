(*<maprcall.pas>
 * Memory mapper management implementation using MSXDOS2 EXTBIO calls.
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
 * - msxbios.pas;
 * - extbio.pas;
 * - maprbase.pas;
 *)


(**
  * Call a routine in the specified segment address.
  * @param handle The allocated handle by the @see InitMapper routine;
  * @param nSegmentId The segment id which the routine will be called;
  * @param nAddress The address to be called inside the segment;
  *)
Procedure CallMapperSegment( Var handle : TMapperHandle;
                             nSegmentId : Integer;   { Must be Integer }
                             nAddress   : Integer );
Var
        nJmpTblAddr : Integer;

Begin
  nJmpTblAddr := handle.nStartAddrJumpTbl + ctCAL_SEG;
  nSegmentId  := Swap( nSegmentId );

  (*
   * The ASM routine below is located in the .\ASM\ project folder
   * and was generated by INLASS.
   *)
  Inline(
          $21/*+$000F          {       LD HL,retj                    }
          /$E5                 {       PUSH HL                       }
          /$FD/$2A/nSegmentId  {       LD IY,(nSegmentId)            }
          /$DD/$2A/nAddress    {       LD IX,(nAddress)              }
          /$2A/nJmpTblAddr     {       LD HL,(nJmpTblAddr)           }
          /$E9                 {       JP (HL)                       }
                               { retj: END                           } );
End;
