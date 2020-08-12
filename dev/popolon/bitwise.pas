(*<bitwise.pas>
 * Bitwise functions implementation.
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: bitwise.pas 98 2015-08-21 01:28:40Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2015-08-21 01:28:40 +0000 (Fri, 21 Aug 2015) $
  * $Revision: 98 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/bitwise.pas $
  *)

(**
  * Perform a bitwise check returning the comparision
  * result.
  * @param nCompareBits The bits to compare;
  * @param nValue The Value to check;
  *)
Function BitCmp( nCompareBits, nValue : Integer ) : Boolean;
Begin
  BitCmp := ( ( nValue And nCompareBits ) = nCompareBits );
End;
