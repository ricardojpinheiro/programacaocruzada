(*<sockdefs.pas>
 * PopolonY2k socket abstract implementation to use on MSX platform.
 * CopyLeft (c) since 1995 by PopolonY2k.
 *)

(**
  *
  * $Id: sockdefs.pas 103 2020-06-17 00:40:53Z popolony2k $
  * $Author: popolony2k $
  * $Date: 2020-06-17 00:40:53 +0000 (Wed, 17 Jun 2020) $
  * $Revision: 103 $
  * $HeadURL: file:///svn/p/oldskooltech/code/msx/trunk/msxdos/pascal/sockdefs.pas $
  *)

(*
 * This module depends on folowing include files (respect the order):
 * -
 *)


(* Internet module definitions *)

Type TIPAddress     = String[15];                  { IP Addr. representation }
     TSocketTypes   = ( SOCK_DGRAM, SOCK_STREAM ); { Socket types }
     TSocketResult  = ( SocketSuccess,             { Network result codes }
                        SocketError,
                        SocketTimeoutReached,
                        SocketNotInitialized,
                        SocketNotConnected,
                        SocketInvalidIP,
                        SocketInvalidPacket,
                        SocketInvalidGateway,
                        SocketPortAlreadyInUse,
                        SocketNotImplemented );
     PSocketResult  = ^TSocketResult;

Const            INADDR_ANY       : TIPAddress = '0.0.0.0';
                 INADDR_LOOPBACK  : TIPAddress = '127.0.0.1';
                 INADDR_NONE      : TIPAddress = '255.255.255.255';

(* Driver layer definitions *)

(**
  * Driver functions to be registered by specific driver layer and that
  * will be used on each socket;
  *)
Type TNetworkDriverLayer = Record
  nConnectFn,
  nDisconnectFn,
  nSendPacketFn,
  nRecvPacketFn : Integer;
End;

(**
  * Strucuture to pass and receive parameters from driver functions.
  *)
Type TDriverParms = Record
  nInParm,
  nOutParm      : Integer;
End;

Type PDriverParms = ^TDriverParms;

(* Network layer definitions *)

(**
  * Socket handle specification.
  *)
Type TSocketHandle = Record
  nSocketHandle    : Integer;     { Future use to communicate with the board }
  SocketType       : TSocketTypes;
End;

(**
  * Structure with the socket connection specification.
  *)
Type TSocket = Record
  strIPAddress     : TIPAddress;
  nPort            : Integer;
  Connection       : TSocketHandle;
  DriverLayer      : TNetworkDriverLayer;
End;

Type PSocket = ^TSocket;

(**
  * Packet structure to send data packet to the network board.
  *)
Type TSocketPacket = Record
  nSize     : Integer;
  pData     : ^Byte;
  pSock     : PSocket;
End;

Type PSocketPacket = ^TSocketPacket;
