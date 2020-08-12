(*<ptest.pas>
 * Implement the PopolonY2's unit test framework for use with
 * any Pascal application tests;
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: ptest.pas 98 2015-08-21 01:28:40Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2015-08-21 01:28:40 +0000 (Fri, 21 Aug 2015) $
  * $Revision: 98 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/ptest.pas $
  *)

(*
 * This source file depends on following include files (respect the order):
 * - types.pas;
 * - math.pas;
 *)

(**
  * Trace procedure to print a string to test standard output.
  * @param strValue The string value to print;
  *)
Procedure TRACE( strValue : TShortString );
Begin
  WriteLn( strValue );
End;

(**
  * Trace procedure to print a string pointer to test standard output.
  * @param strValue The string value to print;
  *)
Procedure PTRACE( pstrValue : PShortString );
Begin
  WriteLn( pstrValue^ );
End;

(**
  * Skip a line in standard output;
  *)
Procedure TRACELN;
Begin
  WriteLn;
End;

(**
  * Unit test helper function to check expected value for reported
  * Boolean passed by parameter;
  * @param strTestName The name of test to be printed at screen report;
  * @param bRetValue The value reported by last math function operation;
  * @param bExpected The expected value for the last math function
  * operation;
  * The function return true if bRetValue is equal bExpected;
  *)
Function TEST_BOOL( strTestName : TTinyString;
                    bRetValue, bExpected : Boolean ) : Boolean;
Begin
  Write( '[', strTestName, '] ===> ' );

  If( bRetValue <> bExpected )  Then
    WriteLn( '[ERROR] - Value ', bRetValue, ' expected ', bExpected )
  Else
    WriteLn( '[SUCCESS]' );

  TEST_BOOL := ( bRetValue = bExpected );
End;

(**
  * Unit test helper function to check expected value for reported
  * @see TString passed by parameter;
  * @param strTestName The name of test to be printed at screen report;
  * @param strRetValue The value reported by last math function operation;
  * @param strExpected The expected value for the last math function
  * operation;
  * The function return true if bRetValue is equal bExpected;
  *)
Function TEST_STR( strTestName : TTinyString;
                   strRetValue, strExpected : TString ) : Boolean;
Begin
  Write( '[', strTestName, '] ===> ' );

  If( strRetValue <> strExpected )  Then
    Begin
      WriteLn( '[ERROR] - Value ',  strRetValue, ' expected ', strExpected );
    End
  Else
    WriteLn( '[SUCCESS]' );

  TEST_STR := ( strRetValue = strExpected );
End;

(**
  * Unit test helper function to check expected value for reported
  * Floating point (Real) value passed by parameter;
  * @param strTestName The name of test to be printed at screen report;
  * @param fRetValue The value reported by last math function operation;
  * @param fExpected The expected value for the last math function
  * operation;
  * The function return true if fRetValue is equal fExpected;
  *)
Function TEST_FLOAT( strTestName : TTinyString;
                     fRetValue, fExpected : Real ) : Boolean;
Begin
  Write( '[', strTestName, '] ===> ' );

  If( fRetValue <> fExpected )  Then
    WriteLn( '[ERROR] - Value ', fRetValue, ' expected ', fExpected )
  Else
    WriteLn( '[SUCCESS]' );

  TEST_FLOAT := ( fRetValue = fExpected );
End;

(**
  * Unit test helper function to check expected value for reported
  * integer value passed by parameter;
  * @param strTestName The name of test to be printed at screen report;
  * @param nRetValue The value reported by last math function operation;
  * @param nExpected The expected value for the last math function
  * operation;
  * The function return true if nRetValue is equal nExpected;
  *)
Function TEST_INT( strTestName : TTinyString;
                   nRetValue, nExpected : Integer ) : Boolean;
Begin
  Write( '[', strTestName, '] ===> ' );

  If( nRetValue <> nExpected )  Then
    WriteLn( '[ERROR] - Value ', nRetValue, ' expected ', nExpected )
  Else
    WriteLn( '[SUCCESS]' );

  TEST_INT := ( nRetValue = nExpected );
End;
