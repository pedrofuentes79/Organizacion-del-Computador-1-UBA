SET 0xF1, 0x02
SET R6, 0x01
SET R7, 0x00
SET R3, rai
STR [0x00], R3
STI

curva: SET 0xF0, 0x0C ; seteo vel curva
       CMP R6, 0x01   ; check Curva
       JZ curva
       INC R7         ; +1 curva
       CMP R7, 0x20   ; chequeo r7=32
       JZ bocina
       JMP max

bocina: SET R5, [0xF1]
        SIG R5
        STR [0xF1], R5
        ; como sali de una curva, voy al max
       
max:   SET 0xF0, 0x0F ;seteo vel max
       CMP R6, 0x00   ; si no estoy en curva
       JZ max
       JMP curva


rai: CMP R6, 0x00 ;si no estoy en curva, pongo curva
     JZ pongoCurva
     JMP pongoMax
     
pongoCurva: SET R6, 0x01
            IRET
pongoMax:   SET R6, 0x00
            IRET
