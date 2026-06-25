ORG 00H
    JMP X

    ORG 03H      ;HARICI KESME
    JMP HARICI
    ORG 0BH     ;Timer 0 Kesme Vektörü
    JMP T
X:   
    MOV R0, #00H    ;Modlar için
    MOV R1, #01H   ;zamanlayici Kesme Sayaci
    MOV P2, #00H     
    MOV DPTR, #TABLE	;7Segment 0
    MOV A, R0
    MOVC A, @A+DPTR
    MOV P0, A
	;timer
    MOV TMOD, #00000001H ; T = 1/f   1/16HZ
    MOV TH0, #9AH   ;dptr kullanimda oldugu için direkt yükledim
    MOV TL0, #46H
    SETB IT0       ;düsen kenar
    SETB EX0       ;harici kesme
    SETB ET0       ;timer 0 kewsme
    SETB EA        ;kesmeleri açtik
    SETB TR0       ;timer baslattik
SONSUZ:
    SJMP SONSUZ
HARICI:
    INC R0         ; modu 1 artir
    CJNE R0, #05H, DISPLAY
    MOV R0, #00H   ; 0 moduna doner
	MOV P2, #00H
DISPLAY:
    MOV DPTR, #TABLE
    MOV A, R0
    MOVC A, @A+DPTR
    MOV P0, A
    RETI
T: 
    CJNE R0, #00H, KONTROL
    SJMP SON
KONTROL:
    DJNZ R1, SON        
    MOV A, P2
    XRL A, #00001111B
    MOV P2, A
    MOV A, R0
    CJNE A, #01H, M2
    MOV R1, #08H        ; 2Hz	250ms   8
    SJMP SON
M2:
    CJNE A, #02H, M3
    MOV R1, #04H        ; 4Hz 	125ms	4
    SJMP SON
M3:
    CJNE A, #03H, M4
    MOV R1, #02H        ; 8Hz	62.5ms	2
    SJMP SON
M4:
    MOV R1, #01H        ; 16Hz  31.25ms	1
SON:  
    RETI
TABLE: DB 0c0H, 0A4H, 099H, 080H, 08EH
    END