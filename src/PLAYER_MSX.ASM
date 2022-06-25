; CODIGO ESPECIFICO PARA MSX.
; ESTE DEBERIA SER EL CÓDIGO A COMPILAR
.INCLUDE "../src/PLAYER_CONSTS.ASM"
.INCLUDE "../src/PLAYER.ASM"

; VUELCA BUFFER DE SONIDO AL AY.
ROUT:
    ;; COMPRUEBA SI ESTÁ LA ENVOLVENTE ACTIVA, Y SI HAY QUE ALMACENARLA
    LD      A, [PSG_REG + 13]
    AND     A                                   ; ES CERO?
    JR      Z, NO_BACKUP_ENVOLVENTE
    LD      [ENVOLVENTE_BACK], A	              ; 08.13 / GUARDA LA ENVOLVENTE EN EL BACKUP

NO_BACKUP_ENVOLVENTE:
    XOR     A                                   ; INDICE DEL REGISTRO DEL PSG A ESCRIBIR
    LD      C, $A0                              ; PUERTO DE SELECCION DE REGISTRO
    LD      HL, PSG_REG_SEC                     ; DIRECCION DE LOS DATOS A ENVIAR AL PSG
LOUT:
    OUT     [C], A                              ; SELECCIONA EL REGISTRO DEL PSG
    INC     C                                   ; APUNTA AL PUERTO DE ESCRITURA
    OUTI                                        ; ESCRIBE EL DATO UBICADO EN (HL) EN EL REGISTRO SELECCIONADO, INCREMENTA HL
    DEC     C                                   ; APUNTA AL PUERTO DE SELECCION DE REGISTRO
    INC     A                                   ; SIGUIENTE REGISTRO
    CP      13                                  ; COMPRUEBA SI YA HEMOS ENVIADO TODOS LOS DATOS
    JR      NZ, LOUT                            ; SI NO ES ASÍ, ESCRIBIMOS EL SIGUIENTE

    OUT     [C], A                              ; SELECCIONAMOS EL REGISTRO 13
    LD      A, [HL]                             ; LEEMOS EL DATO DEL REGISTRO 13 (FRECUENCIA DE ENVOLVENTE)
    AND     A
    RET     Z                                   ; PERO SOLO SE ESCRIBE SI NO ES 0.
    INC     C                                   ; SELECCIONAMOS EL PUERTO DE ESCRITURA
    OUT     [C], A                              ; ENVIAMOS EL DATO
    XOR     A
    LD      [PSG_REG_SEC+13], A                 ; RESETEAMOS EL DATO DEL REGISTRO 13 EN LOS BUFFER
    LD      [PSG_REG+13], A
    RET
