(*<sunatapi.pas>
 * MSX-IDE functions library implementation (Sunrise-like) to
 * handle IDE ATAPI functions.
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: sunatapi.pas 98 2015-08-21 01:28:40Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2015-08-21 01:28:40 +0000 (Fri, 21 Aug 2015) $
  * $Revision: 98 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/sunatapi.pas $
  *)

(*
 * This source file depends on following include files (respect the order):
 * - memory.pas;
 * - types.pas;
 * - msxbios.pas;
 *)

(* Sunrise-like IDE BIOS calls *)

Const     ctBIOSSelectATAPIDevice = $7FB9; { Select master or slave device }
          ctBIOSSendATAPIPacket   = $7FBC; { Send ATAPI to selected device }

(* Library internal constants *)

Const     ctATAPIPacketSize       = 11;    { ATAPI packet size }


(**
  * ATAPI device type required by @see SelectATAPIDevice function.
  *)
Type TATAPIDeviceType = ( ATAPIMaster, ATAPISlave );

(**
  * Return codes for ATAPI BIOS call operations.
  *)
Type TATAPIOperationCode = ( ATAPIControllerTimeout,
                             ATAPIError,
                             ATAPISuccess );

(**
  * ATAPI command data transmission buffer.
  *)
Type TATAPIPacket = Array[0..ctATAPIPacketSize] Of Byte;
     PATAPIPacket = ^TATAPIPacket;


(* BIOS calls implementation *)

(**
  * Select a device for ATAPI command transmission operations through the
  * @see SendATAPIPacket function.
  * @param nSlotNumber The slot number which IDE is connected;
  * @param devType The @see TATAPIDeviceType parameter to select;
  *)
Function SelectATAPIDevice( nSlotNumber : TSlotNumber;
                            devType : TATAPIDeviceType ) : TATAPIOperationCode;
Var
      regs  : TRegs;

Begin
  Case devType Of
    ATAPIMaster : regs.A := 0;
    ATAPISlave  : regs.A := 1;
  End;

  regs.IX := ctBIOSSelectATAPIDevice;
  regs.IY := nSlotNumber;

  CALSLT( regs );

  { Check carry for controller timeout }
  If( ( regs.F And $1 ) = 0 )  Then
    SelectATAPIDevice := ATAPISuccess
  Else
    SelectATAPIDevice := ATAPIControllerTimeout;
End;

(**
  * Send a packet for the selected device throught @see SelectATAPIDevice;
  * @param nSlotNumber The slot number which IDE is connected;
  * @param packet The ATAPI data to send to device;
  * @param nRetBufferAddr The address of the return buffer allocated to
  * receive the ATAPI requested data, if any;
  * @param nErrorRegister If the function return ATAPIError, the variable
  * referenced by this parameter will be filled with the content of error
  * register from controller;
  *)
Function SendATAPIPacket( nSlotNumber : TSlotNumber;
                          Var packet : TATAPIPacket;
                          nRetBufferAddr : Integer;
                          Var nErrorRegister : Byte ) : TATAPIOperationCode;
Var
      regs     : TRegs;
      bCarryOn : Boolean;

Begin
  regs.HL := Addr( packet );
  regs.DE := nRetBufferAddr;
  regs.IX := ctBIOSSendATAPIPacket;
  regs.IY := nSlotNumber;

  CALSLT( regs );

  { Check for all ATAPI controller errors }
  bCarryOn := ( ( regs.F And $1 ) = 1 );

  If( Not bCarryOn )  Then
    SendATAPIPacket := ATAPISuccess
  Else
    If( bCarryOn And ( ( regs.F And $40 ) = 1 ) )  Then
    Begin
      nErrorRegister  := regs.A;
      SendATAPIPacket := ATAPIError;
    End
    Else
      SendATAPIPacket := ATAPIControllerTimeout;
End;
