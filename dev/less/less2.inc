(*
*  less2.inc - Pascal library which is used with the less text pager.
*  So, some routines were taken from the main program to be placed here.
*)

(* Shows a help when milli is executed with /h or /v. *)

procedure CommandLine (KindOf: byte);
(*
*  1 - Version
*  2 - Help
*)

begin
    clrscr;
    FastWriteln(' _                 ');
    FastWriteln('| |  ___  ___  ___ ');
    FastWriteln('| | / _ \/ __|/ __|');
    FastWriteln('| ||  __/\__ \\__ \');
    FastWriteln('|_| \___||___/|___/');

    case KindOf of
        1: begin (* Version *)
                FastWriteln('Version 0.1 - Copyright (c) 2022 Brazilian MSX Crew.');
                FastWriteln('Some rights reserved (not many!).');
                writeln;
                FastWriteln('This text pager resembles the GNU less text pager,');
                FastWriteln('(https://www.gnu.org/software/less/), and we hope ');
                FastWriteln('all useful options are used here.');
                writeln;
                FastWriteln('It''s licensed under the GPLv3+ license. Yep, free software. You are free');
                FastWriteln('to change and redistribute it. But don''t ask me about any warranties...');
                FastWriteln('Use it at your own risk. http://gnu.org/licenses/gpl.html');
                writeln;
            end;
        2: begin (* Help *)
                FastWriteln('Usage: less <file> <parameters>');
                FastWriteln('Text pager.');
                writeln;
                FastWriteln('File: Text file which you want to be read.');
                writeln;
                FastWriteln('Parameters: ');
				FastWriteln('/d<fg>,<bg>    - Define foreground and background colors.');
                FastWriteln('/m             - Set prompt style.');
                FastWriteln('/n             - Use line numbers.');
                FastWriteln('/h             - Show this help text and exit.');
                FastWriteln('/v             - Output version information and exit.');
                writeln;
            end;
        end;
    ClearAllBlinks;
    halt;
end;

procedure quick_display(x, y: integer; s: TString);
begin
    GotoWindowXY(EditWindowPtr, x, y);
    WriteWindow (EditWindowPtr, s);
    ClrEolWindow(EditWindowPtr);
end;

(* Clears the status line. *)

procedure ClearStatusLine;
begin
    ClearBlink(1, maxlength + 1, maxwidth + 2);
    FillChar(temp, maxwidth + 3, #23);
    temp[1]             := #26;
    temp[maxwidth + 2]  := #27;
    WriteVRAM(0, (maxwidth + 2) * maxlength, Addr(temp[1]), maxwidth + 3);
end;

procedure StatusLine (message: TString);
begin
    ClearStatusLine;

    message         := concat('[ ', message, ' ]');
    lengthmessage   := length(message);
    ranking        	:= (maxwidth - lengthmessage) div 2;

    GotoXY(ranking, maxlength + 1);
    FastWrite(message);
    Blink(ranking, maxlength + 1, lengthmessage);
end;

procedure DrawScreen (currentline, screenline: integer; j: byte);
begin
    if highestline <= (maxlength - j) then
		aux := highestline
    else
        aux := maxlength - j;

    ClrWindow(EditWindowPtr);

    for i := 1 to aux do
    begin
        FillChar(temp, sizeof(temp), chr(32));
        FromVRAMToRAM(temp, currentline - screenline + i);
        quick_display(1, i, temp);
    end;
end;

procedure BeginFile;
begin
    currentline := 1;
    screenline  := 1;
    column      := 1;
    
	ClearAllBlinks;
    Blink(2, screenline, maxwidth);
    DrawScreen(currentline, screenline, 1);
end;

procedure EndFile;
begin
    screenline  := 1;
    column      := 1;
    DrawScreen((highestline - (maxlength - 2)), screenline, 1);

    currentline := highestline;
    screenline  := maxlength - 1;
    GotoWindowXY(EditWindowPtr, column, screenline);

    ClearAllBlinks;
    Blink(2, screenline + 1, maxwidth);
end;

procedure CursorUp;
begin
    if currentline = 1 then
        exit;

    currentline := currentline - 1;

    if screenline = 1 then
    begin
        GotoWindowXY(EditWindowPtr, 1, 1);
        ScrollWindowDown(EditWindowPtr);
		
        FillChar(line, sizeof(line), chr(32));
        FromVRAMToRAM(line, currentline);
        quick_display(1, 1, line);
    end
    else
    begin
		screenline := screenline - 1;
		ClearAllBlinks;
        Blink(2, screenline, maxwidth);
    end;
end;

procedure CursorDown;
begin
    if currentline >= highestline then
        exit;

    currentline :=  currentline + 1;
    screenline  :=  screenline  + 1;
	ClearAllBlinks;
	Blink(2, screenline, maxwidth);

    if screenline > (maxlength - 1) then
    begin
        GotoWindowXY(EditWindowPtr, 1, 2);
        ScrollWindowUp(EditWindowPtr);
        screenline := maxlength - 1;
        FillChar(line, sizeof(line), chr(32));
        FromVRAMToRAM(line, currentline);
        quick_display(1, screenline, line);
    end;
end;

procedure PageUp;
begin
    currentline     := currentline - (maxlength - 1);
    if currentline <= screenline then
        BeginFile
    else
        DrawScreen(currentline, screenline, 1);
end;

procedure PageDown;
begin
    currentline     := currentline + (maxlength - 1);
    if currentline >= highestline then
        EndFile
    else
        if (highestline - currentline) < maxlength then
            DrawScreen(currentline, screenline, 2)
        else
            DrawScreen(currentline, screenline, 1);
end;

procedure WhereIs (direction: Directions; nextoccurrence: boolean);
begin
    if NOT nextoccurrence then
    begin
		FillChar(searchstring, SizeOf(searchstring), Chr(32));
        GotoXY(1, maxlength + 1);
        ClrEol;
        Blink(1, maxlength + 1, maxwidth + 2);
		temp := 'Search: ';
        
        FastWrite (temp);
        searchstring := readstring(40);
    end;
	
	ClearStatusLine;

    if length (searchstring) = 0 then
	begin
		BeginFile;
		exit;
	end;
    
    i := currentline;
    
    if nextoccurrence = true then
		if direction = forwardsearch then
			i := i + 1
		else
			i := i - 1;
        
    if direction = forwardsearch then
        stopsearch := highestline + 1
    else
        stopsearch := 0;
    
    while i <> stopsearch do
    begin
        FillChar(line, sizeof(line), chr(32));
        FromVRAMToRAM(line, i);        
    
(* look for matches on this line *)
        point := pos (searchstring, line);

(* if there was a match then get ready to print it *)
        if (point > 0) then
        begin
            currentline := i;
            if currentline >= maxlength then
                screenline := maxlength - 1
            else
                screenline := currentline;
            column := point;
            DrawScreen(currentline, screenline, 1);
            ClearAllBlinks;
            Blink (2, screenline + 1, maxwidth);
            exit;
        end;
        
        if direction = forwardsearch then
            i := i + 1
        else
            i := i - 1;
    end;

    ClearBlink(1, maxlength + 1, maxwidth + 2);
    temp := concat(searchstring, ' not found');
    StatusLine(temp);
end;

procedure Help;
begin
	ClearAllBlinks;
    ClrWindow(EditWindowPtr);
    WritelnWindow(EditWindowPtr, 'Commands:');
    WritelnWindow(EditWindowPtr, 'e, j, Ctrl-E, Ctrl-J, ENTER, Down   - Forward  one line (or N lines).');
    WritelnWindow(EditWindowPtr, 'd, y, Ctrl-D, Ctrl-Y, Ctrl-P, Up    - Backward one line (or N lines).');
    WritelnWindow(EditWindowPtr, 'f, Ctrl-F, Ctrl-V, SPACE, SELECT+Up - Forward  one window.');
    WritelnWindow(EditWindowPtr, 'b, Ctrl-B, SELECT+Down              - Backward one window.');
    WritelnWindow(EditWindowPtr, 'g, INSERT, SELECT+INSERT            - Begin of the file.');
    WritelnWindow(EditWindowPtr, 'i, DELETE, SELECT+DELETE            - End of the file.');
    WritelnWindow(EditWindowPtr, '/pattern                            - Search forward for matching line.');
    WritelnWindow(EditWindowPtr, '?pattern                            - Search backward for matching line.');
    WritelnWindow(EditWindowPtr, '-> &pattern                            - Display only matching lines.');
    WritelnWindow(EditWindowPtr, 'n                                   - Repeat previous search.');
    WritelnWindow(EditWindowPtr, 'm                                   - Repeat previous search (reverse).');
    WritelnWindow(EditWindowPtr, '-> SELECT-u                            - Clear search highlighting.');
    WritelnWindow(EditWindowPtr, 'h                                   - Show help.');
    WritelnWindow(EditWindowPtr, 'p                                   - Repaint screen.');
    WritelnWindow(EditWindowPtr, '-> r                                   - Read a new file.');
    WritelnWindow(EditWindowPtr, '-> s                                   - Edit the current file with EDITOR.');
    WritelnWindow(EditWindowPtr, '-> v                                   - Print version number of less.');
    WritelnWindow(EditWindowPtr, 'q                                   - Exit.');
    c := readkey;
    DrawScreen(currentline, screenline, 1);
	Blink(2, screenline, maxwidth);
end;

procedure Version;
begin
	ClearAllBlinks;
    ClrWindow(EditWindowPtr);
    WritelnWindow(EditWindowPtr, 'Version 0.1 - Copyright (c) 2022 Brazilian MSX Crew.:');
    WritelnWindow(EditWindowPtr, 'Some rights reserved (not many!).');
    WritelnWindow(EditWindowPtr, ' ');
    WritelnWindow(EditWindowPtr, 'This text pager resembles the GNU less text pager,');
    WritelnWindow(EditWindowPtr, '(https://www.gnu.org/software/less/), and we hope ');
    WritelnWindow(EditWindowPtr, 'all useful options are used here.');
    WritelnWindow(EditWindowPtr, ' ');
    WritelnWindow(EditWindowPtr, 'It''s licensed under the GPLv3+ license. Yep, free software. You are free');
    WritelnWindow(EditWindowPtr, 'to change and redistribute it. But don''t ask me about any warranties...');
    WritelnWindow(EditWindowPtr, 'Use it at your own risk. http://gnu.org/licenses/gpl.html');
    WritelnWindow(EditWindowPtr, ' ');
    WritelnWindow(EditWindowPtr, 'Usage: less <file> <parameters>');
    WritelnWindow(EditWindowPtr, 'File: Text file which you want to be read.');
    WritelnWindow(EditWindowPtr, ' ');
    WritelnWindow(EditWindowPtr, 'Parameters: ');
    WritelnWindow(EditWindowPtr, '/d<fg>,<bg>    - Define foreground and background colors.');
    WritelnWindow(EditWindowPtr, '/m             - Set prompt style.');
    WritelnWindow(EditWindowPtr, '/n             - Use line numbers.');
    WritelnWindow(EditWindowPtr, '/h             - Show this help text and exit.');
    WritelnWindow(EditWindowPtr, '/v             - Output version information and exit.');
    c := readkey;
    DrawScreen(currentline, screenline, 1);
	Blink(2, screenline, maxwidth);
end;
