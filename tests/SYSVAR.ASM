;VARIABLES DEL SISTEMA


VERSION         EQU     $002B           ;NACIONALIDAD DEL MSX

CLICKSW      	EQU	$F3DB		;KEYCLICK
HOOK_A          EQU     $FD9A		;CONTROL DE LAS INTERRUPCIONES
HOOK_F          EQU     $FD9F		;CONTROL DE LAS INTERRUPCIONES



/*

        .WORK AREA LISTING
;
F2E1 DRIVE   Current drive
F347 NMBDRV  total number of drivies
F355 DPBLST  List of DRIVE PARAMETERS BLOCK
F368 SETROM  Set DISK-BASIC ROM
F36B SETRAM  Set system RAM configuration
F36E SLTMOV  inter slot move
F37D ROMBDOS ROM BDOS vector

        .SUBROUTINES FOR READ/WRITE CALLS OF THE INTER-SLOT
;
F380 RDPRIM  Read from basic slot
F385 WRPRIM  Write to basic slot
F38C CLPRIM  Call basic slot
F39A USRTAB  USR function starting addresses
F3AE LINL40  Screen width per line in SCREEN 0
F3AF LINL32  Screen width per line in SCREEN 1
F3B0 LINLEN  Current screen width per line
F3B1 CRTCNT  Number of lines of current screen
F3B2 CLMLST  Horizontal location in the case that items
             are divided by commas in PRINT statement

        .WORK FOR INITIALIZATION

-SCREEN 0
F3B3 TXTNAM  Pattern name tabte
F3B5 TXTCOL  Color table
F3B7 TXTCGP  Pattern ganarator table
F3B9 TXTATR  Unused
F3BB TXTPAT  Unused
-SCREEN 1
F3BD T32NAM  Pattern name tabte
F3BF T32COL  Color table
F3C1 T32CGP  Pattern ganarator table
F3C3 T32ATR  Sprite attribute table
F3C5 T32PAT  Sprite generator table
-SCREEN 2
F3C7 GRPNAM  Pattern name tabte
F3C9 GRPCOL  Color table
F3CB GRPCGP  Pattern ganarator table
F3CD GRPATR  Sprite attribute table
F3CF GRPPAT  Sprite generator table
-SCREEN 3
F3D1 MLTNAM  Pattern name tabte
F3D3 MLTCOL  Color table
F3D5 MLTCGP  Pattern ganarator table
F3D7 MLTATR  Sprite attribute table
F3D9 MLTPAT  Sprite generator table
;
F3DB CLIKSW  Key click switch
F3DC CSRY    Y-coordinate of cursor
F3DD CSRX    X-coordinate of cursor
F3DE CNSDFG  Functon key display switch

        .AREA TO SAVE VDP REGISTERS

F3DF RG0SAV
F3E0 RG1SAV
F3E1 RG2SAV
F3E2 RG3SAV
F3E3 RG4SAV
F3E4 RG5SAV
F3E5 RG6SAV
F3E6 RG7SAV
F3E7 STATFL  Stores VDP status (MSX2- VDP status register 0)
F3E8 TRGFLG  Stories trigger button status of joystick
F3E9 FORCLR  Foreground colour
F3EA BAKCLR  Background colour
F3EB BDRCLR  Border colour
F3EC MAXUPD  JMP 0000 (used by CIRCLE statement)
F3EF MINUPD  JMP 0000 (used by CIRCLE statement)
F3F2 ATRBYT  Color code in csing graphic

        .WORK AREA FOR PLAY STATEMENT

F3F3 QUEUES  Points to queue table at the execution of PLAY st.
F3F5 FRCNEW  DB 255

        .WORK AREA FOR KEY INPUT

F3F6 SCNCNT  Interval for the key scan
F3F7 REPCNT  Delay until the auto-repeat of the key begins
F3F8 PUTPNT  DW KEYBUF points to adress to write in the key buffer
F3FA GETPNT  DW KEYBUF points to adress to read from the key buffer
        .PARAMETERS FOR CASSETTE
F3FC CS120   Reading parameters
     DB LOW01,HIGH01,LOW11,HIGH11,HEDLEN*2/256 ; FOR 1200 BAUD
     DB LOW02,HIGH02,LOW12,HIGH22,HEDLEN*2/256 ; FOR 2400 BAUD
F406 LOW
     DB LOW01,HIGH01    Width of LOW & HIGH wich represents bit 0
F408 HIGH
     DB LOW11,HIGH11    Width of LOW & HIGH wich represents bit 1
F40A HEADER
     DB HEDLEN*2/256    Header bit for the short header
F40B ASPCT1  256/aspect ratio
F40D ASPCT2  256*aspect ratio
F40F ENDPGM  DB ":" Dummy program end for RESUME NEXT st.

        .WORK USED BY BASIC INTERNALLY

F414 ERRFLG  Error number
F415 LPTPOS  Position of printer head
F416 PRTFLG  Flag whether to send to printer
F417 NTMSXP  =0 If MSX printer
F418 RAWPRT  <>0 If printing is in 'RAW MODE'
F419 VLZADR  ADDRESS OF CHARACTER REPLACED BY VAL
F41B VLZDAT  CHARACTER REPLACED WITH 0 BY VAL
F41C CURLIN  Current execution line number of BASIC
F41F KBUF    Crunch buffer;translated into intermediate
             language from BUF
F55D BUFMIN  used in INPUT st.
F55E BUF     Buffer to store characters typed( in ASCII code)
F660 ENDBUF  Preventoverflow of BUF
F661 TTYPOS  Virtual cursor location internally retained by BASIC
F662 DIMFLG  ARRAY FLAG
F663 VALTYP  Type indicator
F664 OPRTYP  Store operator number in the extended momentarily before
             operator application
F664 DORES   Indicates whether stored word can be crunched
F665 DONUM   flag for crunch
F666 CONTXT  Text address used by CNRGET
F668 CONSAV  Store token of constant after calling CHRGET
F669 CONTYP  Type of stored constant
F66A CONLO   Valu of stored constant
F672 MEMSIZ  HIGHEST LOCATION IN MEMORY USED BY BASIC
F674 STKTOP  TOP LOCATION TO BE USED FOR THE STACK
F676 TXTTAB  Starting address of BASIC text area
F678 TEMPPT  Starting address of unused area of
             temporary descriptor
F67A TEMPST  Temporary descriptors
F698 DSCTMP  String descriptor wich is the result of string fun.
F69B FRETOP  Starting address of unused area of string area
F69D TEMP3   Used for garbage collection or by USR function
F69F TEMP8   Used for garbage collection
F6A1 ENDFOR  Next address of FOR st.
F6A3 DATLIN  Line number of DATA st.read by READ st.
F6A5 SUBFLG  Flag for array for USR fun.
F6A6 USFLG
F6A6 FLGINP  Flag for INPUT or READ
F6A7 TEMP    Location for temporary reservation for st.code
F6A9 PTRFLG  =0 IF NO LINE NUMBER CONVERTED TO POINTERS
F6AA AUTFLG  AUTO MODE FLAG
F6AB AUTLIN  Current line number for auto
F6AD AUTINC  Increment for auto
F6�F SAVTXT  Text pointer for resume
F6B1 SAVSTK  Save stack when error occurs
F6B3 ERRLIN  Line where last error
F6B5 DOT     CURRENT LINE for edit & list
F6B7 ERRTXT  Text pointer for use by RESUME
F6B9 ONELIN  LINE to go when error
F6BB ONEFLG  =1 if executing an error trap routine
F6BC TEMP2
F6BE OLDLIN  OLD LINE NUMBER set up ^C ...
F6C0 OLDTXT  Points st. to be executed next
F6C2 VARTAB  Pointer to start of variable space
F6C4 ARYTAB  Pointer to begging of array table
F6C6 STREND  End of storage in use
F6C8 DATPTR  DATA pointer
F6CA DEFTBL  Default valtype for each letter

        .WARK FOR USER FUNCTION PARAMETER

F6E4 PRMSTK  Previous definition block on stack
F6E6 PRMLEN  Number of bytes of objective table
F6E8 PARM1   Objective prameter definition table
F74C PRMPRV  Pointer to previous parameter block
F74E PRMLN2  Size of parameter block
F750 PARM2   For parameter storage
F7B4 PRMFLG  Flag to indicate whether PARM1 was searching
F7B5 ARYTA2  End point of search
F7B7 NOFUNS  0 if no function active
F7B8 TEMP9   Location of temporary storage for garbage collection
F7BA FUNACT  Count of active functions
F7BC SWPTMP  Value of first  variable in SWAP st.
F7C4 TRCFLG  0 MEANS NO TRACE

        .WORK FOR MATH-PACK

F7C5 FBUFFR  Buffer for fout
F7F0 DECTMP  Used to transform decimal integer to floating point number
F7F2 DECTM2  Used at division routine execution
F7F4 DECCNT  Used at division routine execution
F7F6 DAC      DECIMAL ACCUMULATOR
F806 HOLD8   Registers for decimal multiplication
F836 HOLD2
F83E HOLD
F847 ARG     Area to set the value to be calculate with DAC
F857 RNDX    Last random number

        .DATA AREA USED BY BASIC INTERPRETER

F85F MAXFIL  High legal file number
F860 FILTAB  Starting address of of file data area
F862 NULBUF  Points to file 0 buffer ( used in SAVE & LOAD st.)
F864 PTRFIL  Points to file data of currently accessing file
F866 RUNFLG  Non-zero for run after load
F866 FILNAM  Name for FILES, NAME & others
F871 FILNM2  Second name for NAME
F87C NLONLY  <>0 when loading program
F87D SAVEND  End address for BSAVE
F87F FNKSTR  FUNCTION KEY AREA
F91F CGPNT   Address to store charecter font in ROM
F922 NAMBAS  Base address of current pattern name table
F924 CGPBAS  Base address of current pattern generator table
F926 PATBAS  Base address of current sprite generator table
F928 ATRBAS  Base address of current sprite attribute table

F92A CLOC
F92C CMASK
F92D MINDEL
F92F MAXDEL
         .DATA AREA FOR CIRCLE STATEMENT
F931 ASPECT  Aspect ratio of the circle; set by <ratio> of CIRCLE
F933 CENCNT  End count
F935 CLINEF  Flag to draw line to centre
F936 CNPNTS  Point to be plottted
F938 CPLOTF  Plot polarity flag
F939 CPCNT   1/8 of number of points in circle
F93B CPCNT8
F93D CRCSUM
F93F CSTCNT
F941 CSCLXY  Scale of X & Y
F942 CSAVEA  reservation area of ADVGRP
F944 CSAVEM  reservation area of ADVGRP
F945 CXOFF   X offset from center
F947 CYOFF   Y offset from center
         .DATA AREA FOR PAINT STATEMENT
F949 LOHMSK
F94A LOHDIR
F94B LOHADR
F94D LOHCNT
F94F SKPCNT  Skip count
F951 MOVCNT  Movement count
F953 PDIREC  Direction of the paint
F954 LFPROG
F955 RTPROG
                 for maclng
F956 MCLTAB
F958 MCLFLG  play / draw
                 for play
F959 QUETAB
F971 QUEBAK
F975 VOICAQ
F9F5 VOICBQ
FA75 VOICCQ
                   FOR MSX 2 ONLY
FAF5 DPPAGE  Display page number
FAF6 ACPAGE  active page number
FAF7 AVCSAV  Reserves AV control port
FAF8 EXBRSA  SUB_ROM slot address
FAF9 CHRCNT  Character counter in the buffer;
             used in Roman-Kana translation
FAFA ROMA    Area to store character (Japan version only)
FAFC MODE    mode svitch for VRAM size
FAFD NORUSE  unused
FAFE XSAVE   [10000000 XXXXXXXX]
FB00 YSAVE   [*0000000 YYYYYYYY] *-light pen interrupt request
FB02 LOGOPR  Logical operation code
                Data area used by RS-232C or disk drive
FB03 RSTMP
FB03 TOCNT
FB04 RSFCB
FB06 RSIQLN
FB07 MEXBIH  Hook
FB0C OLDSTT  Hook
FB12 OLDINT  Hook
FB17 DEVNUM
FB18 DATCNT  Hook
FB1B ERRORS
FB1C FLAGS
FB1D ESTBLS
FB1E COMMSK
FB1F LSTCOM
FB20 LSTMOD
                Data area used by MSX-DOS
FB21-FB34
                  music
FB35 PRSCNT
FB36 SAVSP
FB38 VOICEN
FB39 SAVVOL
FB3B MCLLEN
FB3C MCLPTR
FB3E QUEUEN
FB3F MUSICF
FB40 PLYCNT
FB41 VCBA
FB66 VCBB
FB8B VCBC
FBB0 ENSTOP   <>0 if warm start enabled
FBB1 BASROM   <>0 if basic is in rom
FBB2 LINTTB   line terminator table
FBCA FSTPOS   first position for inlin
FBCC CODSAV   code save area for cursor
FBCD FNKSWI   indicate which func key is
     displayed
FBCE FNKFLG   fkey which have subroutine
FBD8 ONGSBF   global event flag
FBD9 CLIKFL
FBDA OLDKEY
FBE5 NEWKEY
FBF0 KEYBUF   key code buffer
FC18 BUFEND   end of key buffer
FC18 LINWRK
FC40 PATWRK
FC48 BOTTOM
FC4A HIMEM
FC4C TRPTBL
FC9A RTYCNT
FC9B INTFLG
FC9C PADY
FC9D PADX
FC9E JIFFY
FCA0 INTVAL
FCA2 INTCNT
FCA4 LOWLIM
FCA5 WINWID
FCA6 GRPHED  flag for graph. char
FCA7 ESCCNT  escape sequence counter
FCA8 INSFLG  insert mode flag
FCA9 CSRSW   cursor display switch
FCAA CSTYLE  cursor style
FCAB CAPST   capital status
FCAC KANAST  russian key status
FCAD KANAMD
FCAE FLBMEM  0 if loading basic programm
FCAF SCRMOD  screen mode
FCB0 OLDSCR  old screen mode
FCB1 CASPRV
FCB2 BRDATR  border color for paint
FCB3 GXPOS
FCB5 GYPOS
FCB7 GRPACX
FCB9 GRPACY
FCBB DRWFLG
FCBC DRWSCL
FCBD DRWANG
FCBE RUNBNF  doing bload bsave or not
FCBF SAVENT  start address for bsave
FCC1 EXPTBL  flag for expanded slot
FCC5 SLTTBL  current expanded slot reg
FCC9 SLTATR
FD09 SLTWRK
FD89 PROCNM  name of expanded statement
FD99 DEVICE  device ID for cartrige 0-3

*/