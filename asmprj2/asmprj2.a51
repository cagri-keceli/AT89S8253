org 00h
	sjmp x
x:
	MOV TMOD, #00000001B
	clr p0.0
buton: JB P1.0, buton
sayac:
	mov r1, #13d
timer:
	MOV DPTR, #1434d
	MOV TH0, DPH
    MOV TL0, DPL
	SETB TR0
bekle: jnb tf0, bekle
	clr tf0
	clr tr0
	djnz r1, timer
	cpl p0.0
	sjmp sayac
	end