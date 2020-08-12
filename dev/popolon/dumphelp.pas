(*<dumphelp.pas>
 * Helper functions for the MSXDUMP startup programs.
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: dumphelp.pas 103 2020-06-17 00:40:53Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2020-06-17 00:40:53 +0000 (Wed, 17 Jun 2020) $
  * $Revision: 103 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/dumphelp.pas $
  *)

(*
 * This source file depends on following include files (respect the order):
 * - types.pas;
 * - memory.pas;
 * - msxdos.pas;
 * - msxdos2.pas;
 * - msxbios.pas;
 * - mddtypes.pas;
 * - conio.pas;
 * - dvram.pas;
 * - txthndlr.pas;
 *)

Const        { Default application screen parameters }
             ctDefaultWidth  : Byte = 40;    { Default screen width }
             ctForegroundClr : Byte = 15;    { Foreground color }
             ctBackgroundClr : Byte = 0;     { Background color }
             ctBorderClr     : Byte = 0;     { Border color }

(**
  * Parse the startup program parameters, returning the
  * result in @see TCmdLineParms structure;
  * @param parms The reference to parsed parameters command-line;
  *)
Procedure ParseCmdLine( Var parms : TCmdLineParms );
Var
      nCount,
      nParmCount   : Byte;
      strParm      : TFileName;

Begin
  nCount := 1;
  nParmCount := ParamCount;

  With parms Do
  Begin
    If( nParmCount = 0 ) Then    { Clear parms }
      bHelp := True
    Else
      bHelp := False;

    bAbsoluteStartSector := False;
    bDrive  := False;
    bFile   := False;
    bSector := False;
    strFileName     := '';
    strSectorNumber := '';
    strDriveLetter  := '';

    While( nCount <= nParmCount ) Do
    Begin
      strParm := ParamStr( nCount );

      { Process possible parameters values }
      If( bDrive And ( strDriveLetter = '' ) ) Then
      Begin
        strDriveLetter := strParm;

        If( Upcase( strDriveLetter[1] ) In ['A'..'H'] )  Then
          nDriveNumber := Abs( Byte( 'A' ) -
                               Byte( UpCase( strDriveLetter[1] ) ) )
        Else
          bHelp := True;   { Invalid drive activate the help }

        strParm := '';
      End
      Else
        If( bFile And ( strFileName = '' ) ) Then
        Begin
          strFileName := strParm;
          strParm := '';
        End
        Else
          If( bSector And ( strSectorNumber = '' ) ) Then
          Begin
            strSectorNumber := strParm;
            strParm := '';
          End;

      If( ( Length( strParm ) >= 2 ) And ( strParm[1] = '-' ) ) Then
      Begin
        Case ( strParm[2] ) Of
          'h' : Begin                    { Help }
                  bHelp := True;
                  nCount := nParmCount;
                End;
          'd' : Begin                    { Selected Drive }
                  bDrive := True;
                  strDriveLetter := '';
                End;
          'f' : Begin                    { File name }
                  bFile := True;
                  strFileName := '';
                End;
          's' : Begin                    { Sector number }
                  bSector := True;
                  strSectorNumber := '';
                End;
          'a' : Begin                    { Absolute start sector }
                  bAbsoluteStartSector := True;
                End;
          Else Begin                     { Invalid parms }
                 bHelp := True;
                 nCount := nParmCount;
               End;
        End;
      End;

      nCount := nCount + 1;
    End;
  End;
End;

(**
  * Check if parameters structure is invalid.
  * @param The @see TCmdLineParms parameters to check;
  *)
Function HasInvalidParms( Var parms : TCmdLineParms ) : Boolean;
Var
     bResult : Boolean;
Begin
  With parms Do
    bResult := Not bFile And Not bDrive And Not bSector And Not bHelp;

  HasInvalidParms := bResult;
End;

(**
  * Save and initialize the text mode used by the application.
  * @param scrHandle Handle for the output device that will be
  * opened.
  * @param scrStat Reference to the screen status that will be changed;
  * @param oldScrStat Reference to the old screen status to be saved;
  *)
Procedure SaveAppTextMode( Var scrHandle  : TTextHandle;
                           Var scrStat,
                               oldScrStat : TScreenStatus );
Begin
  (*
   * Turn on the cursor and select the style of cursor
   *)
  SetCursorStatus( CursorDisabled );
  SetCursorStatus( CursorUnderscore );

  { Screen initialization }
  SetTextHandler( scrHandle, Addr( DirectWrite ) );

  With scrStat  Do
  Begin
    nWidth    := ctDefaultWidth;
    nFgColor  := ctForegroundClr;
    nBkColor  := ctBackgroundClr;
    nBdrColor := ctBorderClr;
    TextMode  := TextMode4080;
    bFnKeyOn  := False;
  End;

  SetScreenStatus( scrStat, oldScrStat );
End;

(**
  * Restore the previous text mode used by the application.
  * @param scrHandle Handle for the output device that will be
  * restored/closed.
  * @param scrStat Reference to the screen status that will be changed;
  * @param oldScrStat Reference to the old screen status to be restored;
  *)
Procedure RestoreAppTextMode( Var scrHandle  : TTextHandle;
                              Var scrStat,
                                  oldScrStat : TScreenStatus );
Begin
  SetScreenStatus( oldScrStat, scrStat );
  RestoreTextHandler( scrHandle );
End;

(**
  * Call a MSXDOS/CPM/80 executable.
  * @param strFileName The executable file name to call.
  *)
Procedure CallExec( strFileName : TFileName );
Var
        fExecModule  : File;
        regs         : TRegs;
        szParm       : Array[0..5] Of Char; { MSXDD environment value }
        szPath       : Array[0..ctMaxPath] Of Char;
        version      : TMSXDOSVersion;
        nDriveNumber : Byte;

Begin
  GetMSXDOSVersion( version );

  If( version.nKernelMajor >= 2 )  Then
  Begin
    szParm[0] := 'M';
    szParm[1] := 'S';
    szParm[2] := 'X';
    szParm[3] := 'D';
    szParm[4] := 'D';
    szParm[5] := #0;
    szPath[0] := #0;

    With regs Do
    Begin
      B  := SizeOf( szPath );
      C  := ctGetEnvironmentItem;
      HL := Addr( szParm );
      DE := Addr( szPath );
    End;

    MSXBDOS( regs );

    If( szPath[0] <> #0 )  Then
    Begin
      If( szPath[1] = ':' )  Then   { Path contains the drive specification }
      Begin
        If( Upcase( szPath[0] ) In ['A'..'H'] )  Then
          nDriveNumber := Abs( Byte( 'A' ) - Byte( UpCase( szPath[0] ) ) );
          With regs Do
          Begin
            C := ctSetDrive;
            E := nDriveNumber;
          End;

          MSXBDOS( regs );
      End;

      With regs Do
      Begin
        C  := ctChangeCurrentDir;
        DE := Addr( szPath );
      End;

      MSXBDOS( regs );
    End;
  End;

  Assign( fExecModule, strFileName );
  {$i-}
  Execute( fExecModule );
  {$i+}

  If( IOResult <> 0 )  Then
    WriteLn( strFileName + ' not found' );
End;
