(*<popplay.pas>
 * The Pop!Art VGM player engine for MSX computers.
 *
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

Program PopArtVGMPlayer;

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
 * - hooks.pas;
 * - systypes.pas;
 * - types.pas;
 * - sndchips.pas;
 * - ay8910.pas;
 * - scc.pas;
 * - opl4.pas;
 * - y8950.pas;
 * - ym2413.pas;
 * - ym2151.pas;
 * - wait.pas;
 * - sndtypes.pas;
 * - sndreset.pas;
 * - vgmtypes.pas;
 * - mapperd.pas;
 * - math.pas;
 * - math32.pas;
 * - longjmp.pas;
 * - vgmplay.pas;
 * - vgmmem.pas;
 *)

(**
  * Variables to be shared with other external executable modules
  * like the POPVGM.COM;
  *)
Var
        nVgmDataAddr : Integer;
        nChipsAddr   : Integer;

{$c-,u-,a+,x+}

{$i hooks.pas}
{$i systypes.pas}
{$i types.pas}
{$i sndchips.pas}
{$i ay8910.pas}
{$i scc.pas}
{$i opl4.pas}
{$i y8950.pas}
{$i ym2413.pas}
{$i ym2151.pas}
{$i wait.pas}
{$i sndtypes.pas}
{$i sndreset.pas}
{$i vgmtypes.pas}
{$i mapperd.pas}
{$i math.pas}
{$i math32.pas}
{$i longjmp.pas}
{$i vgmplay.pas}
{$i vgmmem.pas}


(**
  * Initialize mapper direct access based on allocated segments
  * by standard mapper functions.
  *)
Function InitMapperData( pVgmData : PVGMData ) : Boolean;
Var
       bRet    : Boolean;
       nCount  : Byte;

Begin
  bRet := ( pVgmData <> Nil );

  If( bRet )  Then
  Begin
    nCount := 0;
    InitMapperEx( Nil );

    While( ( nCount <= pVgmData^.mapper.nSegCounter ) And bRet ) Do
    Begin
      (* Reserves page2 for using mapper in direct mode *)
      bRet := AllocMapperSegmentEx( pVgmData^.mapper.aUsedSegs[nCount],
                                    ctMapperPortPage2 );

      nCount := Succ( nCount );
    End;
  End;

  InitMapperData := bRet;
End;



(* Main block variables *)

Var
        ptrVgmData   : PVGMData;
        ptrChips     : PSoundChips;


Begin
  WriteLn( 'Press ESC key to exit.' );
  WriteLn( 'Playing' );

  ptrVgmData := Ptr( nVGMDataAddr );
  ptrChips   := Ptr( nChipsAddr );

  If( InitMapperData( ptrVgmData ) )  Then
    PlayVGM( ptrVgmData^, ptrChips^ )
  Else
    WriteLn( 'Error to initialize the mapper engine' );

  ReleaseVGM( ptrVgmData^ );
  ResetChips( ptrChips^ );

  {Dispose( ptrVgmData );
  Dispose( ptrChips );}
End.
