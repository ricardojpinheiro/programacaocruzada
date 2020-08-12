(**<memory.pas>
  * Memory management helper functions.
  * CopyLeft (c) since 1995 by PopolonY2k.
  *)

 (**
  *
  * $Id: memory.pas 98 2015-08-21 01:28:40Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2015-08-21 01:28:40 +0000 (Fri, 21 Aug 2015) $
  * $Revision: 98 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/memory.pas $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * -
 *)

(**
  * Get the a integer value based on address passed by parameter.
  * @param nAddress The reference value pointing to the address position
  * to retrieve.
  * After execution of this function, the nAddress value points
  * to the next address position (Word step).
  *)
Function GetInteger( Var nAddress : Integer ) : Integer;
Var
        nCount  : Byte;
        nResult : Integer;

Begin
  nCount := SizeOf( Integer );
  Move( Mem[nAddress], Mem[Addr( nResult )], nCount );
  nAddress := nAddress + nCount;
  GetInteger := nResult;
End;

(**
  * Get the a byte memory position based on address passed
  * by parameter.
  * @param nAddress The reference value with address position
  * to retrieve.
  * After execution of this function, the nAddress value points
  * to the next address position (Byte step).
  *)
Function GetByte( Var nAddress : Integer ) : Byte;
Var
        nResult : Byte;

Begin
  nResult  := Mem[nAddress];
  nAddress := nAddress + 1;
  GetByte  := nResult;
End;

(**
  * When we're using a uni-dimensional vector and want to
  * manage it as a bi-dimensional vector, this function is
  * a helper to do this management.
  * The function retrieve a index of uni-dimensional array for
  * a given Column and Row.
  * @param nCol The column index;
  * @param nRow The row index;
  * @param nMaxCol the maximum number of columns of 'virtual'
  * bi-dimensional array;
  *)
Function IndexArray( nCol, nRow, nMaxCol : Byte) : Integer;
Begin
 IndexArray := ( ( nMaxCol * nCol ) + nRow );
End;
