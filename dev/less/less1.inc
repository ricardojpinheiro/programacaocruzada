(*
*  less1.inc - Pascal library which is used with the less text pager.
*  Here we have some routines which are accessory to the program.
*)

(* Read only one key, no echoes to the screen.*)

(* Finds the last occurence of a char which is different into a string. *)

function RDifferentPos(c: char; Phrase: TString): integer;
var
    Found: boolean;
    
begin
    i := length(Phrase);
    Found := false;
    repeat
        if Phrase[i] <> c then
        begin
            RDifferentPos := i;
            Found := true;
        end;
        i := i - 1;
    until Found or (i <= 1);
    if Not Found then RDifferentPos := 0;
end;

Function Readkey: char;
begin
    Readkey := chr(0);
    CSRSW := 1;
    Inline($f3/$fd/$2a/$c0/$fc/$DD/$21/$9F/00/$CD/$1c/00/$32/Byt/$fb);
    Readkey := chr(Byt);
    CSRSW := 0;
end;

(* Read a string, echoes to the screen. Should tell how many chars would be read. *)

Function ReadString (MaxLen: Byte): TString;
Begin
	FillChar(temp, Sizeof(temp), Chr(32));
	i := 0;
	Repeat
		c := readkey;
		Case c Of
			#30..#126,#128..#255:	Begin
										If i < Maxlen Then
										Begin
											i := i + 1;
											Write(c);
											temp[i] := c;
										End
										Else
											Write(#7);
									End;
			#8: 					Begin
										If i > 0 Then
										Begin
											i := i - 1;
											Write(c);
											Write(' ');
											Write(c);
											temp[0] := Chr(i);
										End
										Else
											Write(#7);
									End;
		End; {Case}

	Until c = #13;

	i := RDifferentPos(chr(32), temp); 
	delete(temp, i + 1, (MaxLen - (i + 1)));
    ReadString := temp;
End; {ReadString}

(* Finds the last occurence of a char into a string. *)

Function RPos(Character: char; Phrase: TString): integer;
begin
    i := length(Phrase);
    Found := false;
    repeat
        if Phrase[i] = Character then
        begin
            RPos := i + 1;
            Found := true;
        end;
        i := i - 1;
    until Found;
    if Not Found then RPos := 0;
end;

(* Updates the APPEND environment variable, in order to use subdirectories in
*  MSX-DOS 2. *)

procedure CheatAPPEND (FileName: TString);
var
    FirstTwoDotsFound, LastBackSlashFound: byte;
    APPEND: string[7];
        
begin

(* Initializing some variables... *)
    fillchar(Path, sizeof(Path), ' ' );
    fillchar(temp, sizeof(temp), ' ' );
    APPEND[0] := 'A';   APPEND[1] := 'P';   APPEND[2] := 'P';
    APPEND[3] := 'E';   APPEND[4] := 'N';   APPEND[5] := 'D';
    APPEND[6] := #0;
    
(*  Sees if in the path there is a ':', used with drive letter. *)    
    FirstTwoDotsFound := Pos (chr(58), FileName);

(*  If there are two dots...  *)
    if FirstTwoDotsFound <> 0 then
    begin
    
(*  Let me see where is the last backslash character...  *)
        LastBackSlashFound := RPos (chr(92), FileName);
        Path := copy (FileName, 1, LastBackSlashFound);

(*  Copy the path to the variable. *)
        for i := 1 to LastBackSlashFound - 1 do
            temp[i - 1] := Path[i];
        temp[LastBackSlashFound] := #0;
        Path := temp;

(*  Sets the APPEND environment variable. *)
        with regs do
        begin
            B := sizeof (Path);
            C := ctSetEnvironmentItem;
            HL := addr (APPEND);
            DE := addr (Path);
        end;
        MSXBDOS (regs);
    end;
end;

(* Sets Z80 mode in MSX Turbo-R. *)

procedure TRZ80mode;
begin
    inline($3e/$00/$fd/$2a/$c0/$fc/$dd/$21/$80/$01/$cd/$1c/$00/$fb);
end;

(* Sets R800 mode in MSX Turbo-R. *)

procedure TRR800mode;
begin
    inline($3e/$00/$fd/$2a/$c0/$fc/$dd/$21/$80/$01/$cd/$1c/$00/$fb);
end;

(* Moves text from RAM to VRAM. *)

procedure FromRAMToVRAM(var tempstr: TString; linenumber: integer);
begin
    with textlines[linenumber] do
        WriteVRAM(VRAMBank, VRAMposition, addr(tempstr), maxcols);
end;

(* Moves text from VRAM to RAM. *)

procedure FromVRAMToRAM(var tempstr: TString; linenumber: integer);
begin
    with textlines[linenumber] do
        ReadVRAM(VRAMBank, VRAMposition, addr(tempstr), maxcols);
end;

(* Initializes the VRAM buffer and all structed variables which are related. *)

procedure InitVRAM(linenumber: integer; var counter: real);
begin
    with textlines[linenumber] do
    begin
        if linenumber = 1 then
        begin
            VRAMposition    := startvram;
            VRAMBank        := 0;
        end
        else
        begin
            VRAMposition    :=  textlines[linenumber - 1].VRAMposition
                                                            + maxcols;
            VRAMBank        :=  textlines[linenumber - 1].VRAMBank;
        end;

        if counter >= limitvram then
        begin
            VRAMBank        := VRAMBank + 1;
            VRAMposition    := $0000;
            counter         := 0;
        end;
    end;
    emptylines[linenumber] := true;
end;


