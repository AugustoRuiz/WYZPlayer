; CODIGO ESPECIFICO PARA ZX.
; ESTE DEBERIA SER EL CÓDIGO A COMPILAR
.INCLUDE "../src/PLAYER_CONSTS.ASM"
.INCLUDE "../src/PLAYER.ASM"

; VUELCA BUFFER DE SONIDO AL AY.
ROUT:
    LD      A, [PSG_REG+13]
    AND     A                                   ;ES CERO?
    JR      Z, NO_BACKUP_ENVOLVENTE
    LD      [ENVOLVENTE_BACK], A                ;08.13 / GUARDA LA ENVOLVENTE EN EL BACKUP

NO_BACKUP_ENVOLVENTE:
;VUELCA BUFFER DE SONIDO AL PSG DEL SPECTRUM
   	XOR     A                                   ; A = 0 (PRIMER REGISTRO)
ROUT_A0:
    LD      DE, $FFBF                           ; DE = VALORES PARA CAMBIAR ENTRE SELECCION Y ESCRITURA DE REGISTRO
    LD      BC, $FFFD                           ; BC = PUERTO DE SELECCION DE REGISTRO
    LD      HL, PSG_REG_SEC                     ; HL = BUFFER DE VALORES DE REGISTROS AY
LOUT:
    OUT     [C], A                              ; SELECCIONAMOS EL REGISTRO (PUERTO $FFFD)
    LD      B, E                                ; B = $BF, BC = $BFFD 
    OUTI                                        ; ESCRIBE EL DATO EN EL REGISTRO (PUERTO $BFFD), INCREMENTA HL
    LD      B, D                                ; B = $FF, BC = $FFFD
    INC     A                                   ; APUNTAMOS AL SIGUIENTE REGISTRO
    CP      13
    JR      NZ, LOUT                            ; SI NO HEMOS LLEGADO AL 13, SEGUIMOS
    OUT     [C], A                              ; SELECCIONAMOS EL REGISTRO 13
    LD      A, [HL]                             ; LEEMOS EL DATO DEL REGISTRO 13 (ENVOLVENTE)
    AND     A
    RET     Z                                   ; SI ES 0, TERMINAMOS
    LD      B, E                                ; SI TIENE VALOR; APUNTAMOS AL REGISTRO DE ESCRITURA
    OUTI                                        ; ESCRIBIMOS
    XOR     A
    LD      [PSG_REG_SEC + 13], A               ; Y LIMPIAMOS EL VALOR DEL REGISTRO 13 EN LOS BUFFER
    LD      [PSG_REG + 13], A
    RET
