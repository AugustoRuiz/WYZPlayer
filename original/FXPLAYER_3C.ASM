
;FUNCIONES DEL PLAYER DE FX

;INICIA FX
;IN:[BC]=Nº DE FX/CANAL

;REPRODUCE_EFECTO
;LLAMAR EN CADA INTERRUPCION

; VARIABLES__________________________


;INTERR:         DB     00              ;INTERRUPTORES 1=ON 0=OFF       
                                        ;BIT 0=CARGA CANCION ON/OFF
                                        ;BIT 1=PLAYER ON/OFF
                                        ;BIT 2=SONIDOS ON/OFF
                                        
					;BIT 3=EFECTOS ON/OF CANAL A
					;BIT 4=EFECTOS ON/OF CANAL B
					;BIT 5=EFECTOS ON/OF CANAL C
;EFECTOS

N_EFECTO	       	EQU	$E440   ;DB : NUMERO DE SONIDO
PUNTERO_EFECTO_A 	EQU	$E441	;DW : PUNTERO DEL SONIDO QUE SE REPRODUCE
PUNTERO_EFECTO_B 	EQU	$E443	;DW : PUNTERO DEL SONIDO QUE SE REPRODUCE
PUNTERO_EFECTO_C 	EQU	$E445	;DW : PUNTERO DEL SONIDO QUE SE REPRODUCE
VOLUMEN_RELATIVO_FX	EQU	$E447	;DB : VOLUMEN RELATIVO DE LOS FX





;PLAYER ______________________________________________________



	


;INICIA EL SONIDO Nº [B] EN EL CANAL [C]

INICIA_EFECTO:	LD	A,C
		CP	0
		JP	Z,INICIA_EFECTO_A
		CP	1
		JP	Z,INICIA_EFECTO_B
		CP	2
		JP	Z,INICIA_EFECTO_C
		RET


;________________________________________________________


REPRODUCE_EFECTO:

		CALL	REPRODUCE_EFECTO_A
		CALL	REPRODUCE_EFECTO_B
		CALL	REPRODUCE_EFECTO_C
		;CALL	ROUT
		RET

;________________________________________________________

INICIA_EFECTO_A:LD	A,B
		LD      HL,TABLA_EFECTOS
                CALL    EXT_WORD
                LD      [PUNTERO_EFECTO_A],HL
                LD      HL,INTERR
                SET     3,[HL]
		LD	A,10111000B
		LD	[PSG_REG+7],A
                RET       
			

;REPRODUCE EFECTOS CANAL A

REPRODUCE_EFECTO_A:

		
                LD      HL,INTERR   
                BIT     3,[HL]          ;ESTA ACTIVADO EL EFECTO?
                RET     Z
                LD      HL,[PUNTERO_EFECTO_A]
                LD      A,[HL]
                CP      $FF
                JR      Z,FIN_EFECTO_A
                LD      [PSG_REG+0],A
                INC     HL
                LD      A,[HL]
                RRCA
                RRCA
                RRCA
                RRCA
                AND     00001111B
                LD      [PSG_REG+1],A
                LD      B,[HL]
                LD	A,[VOLUMEN_RELATIVO_FX]
                ADD	B
                AND     00001111B
                LD      [PSG_REG+8],A
       
                INC     HL
                LD      [PUNTERO_EFECTO_A],HL
                RET
FIN_EFECTO_A:   LD      HL,INTERR
                RES     3,[HL]
                XOR     A       
                LD      [PSG_REG+0],A
                LD      [PSG_REG+1],A
                LD	[PSG_REG+8],A
                RET        
 
;________________________________________________________

INICIA_EFECTO_B:LD	A,B
		LD      HL,TABLA_EFECTOS
                CALL    EXT_WORD
                LD      [PUNTERO_EFECTO_B],HL
                LD      HL,INTERR
                SET     4,[HL]
		LD	A,10111000B
		LD	[PSG_REG+7],A
                RET       
               
;REPRODUCE EFECTOS CANAL B

REPRODUCE_EFECTO_B:

                LD      HL,INTERR   
                BIT     4,[HL]          ;ESTA ACTIVADO EL EFECTO?
                RET     Z
                LD      HL,[PUNTERO_EFECTO_B]
                LD      A,[HL]
                CP      $FF
                JR      Z,FIN_EFECTO_B
                LD      [PSG_REG+2],A
                INC     HL
                LD      A,[HL]
                RRCA
                RRCA
                RRCA
                RRCA
                AND     00001111B
                LD      [PSG_REG+3],A
                LD      B,[HL]
                LD	A,[VOLUMEN_RELATIVO_FX]
                ADD	B
                AND     00001111B
                LD      [PSG_REG+9],A
       
                INC     HL
                LD      [PUNTERO_EFECTO_B],HL
                RET
FIN_EFECTO_B:   LD      HL,INTERR
                RES     4,[HL]
                XOR     A       
                LD      [PSG_REG+2],A
                LD      [PSG_REG+3],A
                LD	[PSG_REG+9],A
                RET

;________________________________________________________

INICIA_EFECTO_C:LD	A,B
		LD      HL,TABLA_EFECTOS
                CALL    EXT_WORD
                LD      [PUNTERO_EFECTO_C],HL
                LD      HL,INTERR
                SET     5,[HL]
		LD	A,10111000B
		LD	[PSG_REG+7],A
                RET       
               
;REPRODUCE EFECTOS CANAL C

REPRODUCE_EFECTO_C:

                LD      HL,INTERR   
                BIT     5,[HL]          ;ESTA ACTIVADO EL EFECTO?
                RET     Z
                LD      HL,[PUNTERO_EFECTO_C]
                LD      A,[HL]
                CP      $FF
                JR      Z,FIN_EFECTO_C
                LD      [PSG_REG+4],A
                INC     HL
                LD      A,[HL]
                RRCA
                RRCA
                RRCA
                RRCA
                AND     00001111B
                LD      [PSG_REG+5],A
                LD      B,[HL]
                LD	A,[VOLUMEN_RELATIVO_FX]
                ADD	B
                AND     00001111B
                LD      [PSG_REG+10],A
       
                INC     HL
                LD      [PUNTERO_EFECTO_C],HL
                RET
FIN_EFECTO_C:   LD      HL,INTERR
                RES     5,[HL]
                XOR     A       
                LD      [PSG_REG+4],A
                LD      [PSG_REG+5],A
                LD	[PSG_REG+10],A
                RET        

