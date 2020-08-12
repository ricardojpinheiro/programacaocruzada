(*<helpcnv.pas>
 * Helper functions to perform conversion between
 * builtin and new defined types.
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: helpcnv.pas 103 2020-06-17 00:40:53Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2020-06-17 00:40:53 +0000 (Wed, 17 Jun 2020) $
  * $Revision: 103 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/helpcnv.pas $
  *)

(*
 * This source file depends on following include files (respect the order):
 * - types.pas;
 *)

(*
 * Internal module definitions.
 *)
Const
        ctHexaVals : Array[$0..$F] Of Char = '0123456789ABCDEF';


(**
  * Convert a byte number to hexadecimal
  * representation of the decimal number.
  * @param nValue The value to convert;
  *)
Function ByteToHexa( nValue : Integer ) : THexadecimal;
Begin
  ByteToHexa := ctHexaVals[nValue ShR 4] + ctHexaVals[nValue And $F];
End;
