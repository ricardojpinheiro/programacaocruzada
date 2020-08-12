(*<ym2413-i.pas>
 * Library for the YM2413 soundchip handling.
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
 * - sltsrch.pas;
 *)

Const
       { YM2413 related constants }
       ctFMIdentification      : Integer = $401C; { OPLL string ident. addr. }


(**
  * Find the slot that YM2413 lives in.
  * Thanks to BIFI's website at http://bifi.msxnet.org/blog/index.php?m=08&y=11
  *)
Function FindYM2413 : TSlotNumber;
Var
        strSignature : String[4];

Begin
  strSignature := 'OPLL';
  {$v-}
  FindYM2413 := FindSignature( strSignature, ctFMIdentification );
  {$v+}
End;
