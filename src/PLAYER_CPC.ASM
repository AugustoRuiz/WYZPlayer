; CODIGO ESPECIFICO PARA CPC.
; ESTE DEBERIA SER EL CÓDIGO A COMPILAR
.INCLUDE "../src/PLAYER_CONSTS.ASM"
.INCLUDE "../src/PLAYER.ASM"

; VUELCA BUFFER DE SONIDO AL AY.
ROUT:
;; COMPRUEBA SI ESTÁ LA ENVOLVENTE ACTIVA, Y SI HAY QUE ALMACENARLA
    LD	    A, [PSG_REG + 13]
    AND	    A                                   ;ES CERO?
    JR	    Z, NO_BACKUP_ENVOLVENTE
    LD	    [ENVOLVENTE_BACK], A                ;08.13 / GUARDA LA ENVOLVENTE EN EL BACKUP

NO_BACKUP_ENVOLVENTE:
;VUELCA BUFFER DE SONIDO AL PSG
    XOR     A
    LD      HL, PSG_REG_SEC                     ; APUNTAMOS AL PRIMER VALOR DEL BUFFER DE REGISTROS

LOUT:
    LD      D, [HL]                             ; CARGAMOS EL VALOR DEL REGISTRO EN D
    CALL    WRITEPSGHL                          ; ESCRIBIMOS
    INC     HL                                  ; APUNTAMOS AL SIGUIENTE VALOR DEL BUFFER DE REGISTROS
    INC     A                                   ; INCREMENTAMOS EL NUMERO DE REGISTRO DEL PSG
    CP      13
    JR      NZ, LOUT                            ; SEGUIMOS ESCRIBIENDO HASTA EL REGISTRO 13 (ES EL 14)
    LD      A, [HL]                             ; LEEMOS EL DATO DE LA ENVOLVENTE
    AND     A
    RET     Z                                   ; SI ES CERO, TERMINAMOS
    LD      A, 13                               ; SI NO ES CERO, MARCAMOS EL REGISTRO 13
    LD      D, [HL]                             ; CARGAMOS EL VALOR DEL REGISTRO EN D
    CALL    WRITEPSGHL                          ; Y ESCRIBIMOS EL VALOR QUE HAY EN EL BUFFER
    XOR     A                                   ; RESETEAMOS EL DATO DEL REGISTRO 13 EN LOS BUFFER
    LD      [PSG_REG + 13], A
    LD      [PSG_REG_SEC + 13], A
    RET

;; ESCRIBE EL VALOR D EN EL REGISTRO A DEL AY.
;; A = REGISTER
;; D = VALUE
WRITEPSGHL:
    LD      B, $F4                              ; ESCRIBIMOS EL NUMERO DE REGISTRO EN EL PUERTO A DEL PPI
    OUT     [C], A
    LD      BC, $F6C0                           ; SELECCIONAMOS EL REGISTRO DE DATOS DEL PUERTO A
    OUT     [C], C
    LD      C, $00                              ; PONEMOS EL PSG EN ESTADO INACTIVO
    OUT     [C], C
    LD      B, $F4                              ; ESCRIBIMOS EL DATO DEL REGISTRO EN EL PUERTO A DEL PPI
    OUT     [C], D
    LD      BC, $F680                           ; ESCRIBIMOS EL DATO EN EL REGISTRO SELECCIONADO DEL PSG
    OUT     [C], C
    LD      C, $00                              ; PONEMOS EL PSG EN ESTADO INACTIVO
    OUT     [C], C
    RET