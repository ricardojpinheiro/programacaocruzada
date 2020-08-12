(*<math.pas>
 * Implement extends math functions present in new Turbo Pascal releases
 * and other languages;
 * Copyleft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: math.pas 103 2020-06-17 00:40:53Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2020-06-17 00:40:53 +0000 (Wed, 17 Jun 2020) $
  * $Revision: 103 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/math.pas $
  *)

(*
 * This source file depends on following include files (respect the order):
 * -
 *)

(**
  * Calculate the power of a number by another number.
  * @param x The base number;
  * @param y The power number;
  *)
Function Pow( x, y : Real ) : Real;
Begin
  Pow := Exp( y * Ln( x ) );
End;
