ORG #4000
RUN MAIN

mc_wait_flyback equ 	#bd19

WYZPLAYER_INIT:
 CALL PLAYER_OFF

 LD DE, #0020 		; No. BYTES RESERVADOS POR CANAL
 
 LD HL, BUFFER_DEC 	;* RESERVAR MEMORIA PARA BUFFER DE SONIDO!!!!!
 LD (CANAL_A), HL
 ADD HL, DE
 LD (CANAL_B), HL
 ADD HL, DE
 LD (CANAL_C), HL
 ADD HL, DE
 LD (CANAL_P), HL
RET

MAIN:
    DI
    CALL    WYZPLAYER_INIT

    LD      A,0             	;REPRODUCIR LA CANCION Num 0
    CALL    CARGA_CANCION
    EI

LOOP:
    CALL    mc_wait_flyback
    CALL    INICIO
    JR      LOOP

BUFFER_DEC:
DEFS #20 * 4

TABLA_SONG:
DEFW      SONG_0 ;SONG_1

;codigo del player
READ "..\src\WYZProPlay47c_CPC.ASM"

;archivo de instrumentos
READ "test.mus.asm"
SONG_0:
INCBIN  "test.mus" ;
