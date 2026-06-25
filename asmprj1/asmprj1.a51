org 00h
	sjmp x
x:
	mov 10h, #01h
	mov 11h, #07h
	mov 12h, #0ah
	mov 13h, #13h
	mov 14h, #09h
	mov 15h, #0ch
	mov 16h, #0ah
	mov 17h, #0bh
	mov 18h, #04h
	mov 19h, #08h
x1:
	mov r0, #10h
	mov r1, #10d
	mov a, #00h
dongu:
	add a, @r0
	inc r0
	djnz r1, dongu
	mov p0, a
son:
	sjmp son
	end