
.filename "phantis"	;NOMBRE DEL ARCHIVO ROM / ENSAMBLADO CON ASMSX
.page   1
.ROM

; VARIABLES DEL SISTEMA
CLIKSW	        EQU     $F3DB
HOOK            EQU     $FD9A

;RETARDO DE LAS INTERRUPCIONES
DLAY60H         EQU     $E001
DLAYFX          EQU     $E002

.INCLUDE        "SYSVAR.ASM"

WYZ_PLAYER_BUFFER EQU   $C000

; AJUSTES INICIALES
SPOINT:
;***

AJUSTES:	
        CALL    WYZ_PLAYER_INIT
        DI
        LD      A,0                     ;REPRODUCIR LA CANCION N� 0
        CALL    CARGA_CANCION

;INICIA INTERRUPCIONES*****
        ;CALL   SET_INTERR
        LD      HL, WYZ_PLAYER_TICK
        LD      [HOOK + 1], HL
        LD      A, $C3
        LD      [HOOK], A
        EI

LOOP:
        JP      LOOP

SET_INTERR:
        LD      A, $C9           ;INT OFF
        LD      [HOOK_F], A
        LD      A, [VERSION]     ;NACIONALIDAD DEL MSX
        AND     A                ;=0 JAPONES =1 KOREANO =2 INTERNACIONAL
        LD      HL, INICIO       ;GANCHO PARA 50 Hz
        JP      M, NO_JAPO
        LD      HL, F60HZ        ;GANCHO PARA 60 Hz
        LD      A, $06           ;RETARDO PARA 60 HZ
        LD      [DLAY60H], A
        LD      [DLAYFX], A
NO_JAPO:
        LD      [HOOK_F+1], HL
        LD      A, $C3
        LD      [HOOK_F], A      ;INT ON 
        IM      1
        EI
        RET
F60HZ:
        LD      HL, DLAY60H
        DEC     [HL]
        JP      NZ, INICIO
        LD      A, [DLAYFX]
        LD      [HL], A
        RET

;archivo de instrumentos
.INCLUDE        "test.mus.asm"

SONG_0:
.INCBIN         "test.mus" ;MÓDULO GENERADO POR WYZTRACKER****

TABLA_SONG:
        DW      SONG_0;SONG_1

;Código del player1
.INCLUDE        "../src/PLAYER_MSX.asm"		
