ASSUME CS:CODE,DS:DATA
DATA SEGMENT
G1 DB 0DH,0AH,"ENTER THE COUNT:$"
G2 DB 0DH,0AH,"ENTER THE ARRAY:$"
G3 DB 0DH,0AH,"THE ARRAY IS GIVEN BELOW:$"
G4 DB 0DH,0AH,"ENTER THE KEY ELEMENT:$"
MSG1 DB 0DH,0AH," FOUND:$"
MSG2 DB 0DH,0AH," NOT FOUND:$"
NL DB 0DH,0AH,"$"
AR DB 10 DUP(0)
DATA ENDS

DISPS MACRO MSG
LEA DX,MSG
MOV AH,09H
INT 21H
ENDM

READC MACRO
MOV AH,01H
INT 21H
ENDM

CODE SEGMENT
START:
	MOV CX,DATA
	MOV DS,CX

DISPS G1
	READC
	SUB AL,30H
	MOV CL,AL
	MOV CH,AL
	MOV BH,AL
	LEA SI,AR
	DISPS G2

LOOP1:
	DISPS NL
	READC
	SUB AL,30H
	MOV [SI],AL
	INC SI
	DEC CL
	JNZ LOOP1

	DISPS G4
	READC
	SUB AL,30H

	LEA SI,AR
	MOV DL,CH

UP:
	MOV BL,[SI]
	CMP AL,BL
	JZ FO
	INC SI
	DEC DL
	JNZ UP
	DISPS MSG2
	JMP END1

FO:
	DISPS MSG1

END1:
	MOV AH,4CH
	INT 21H
	CODE ENDS
	END START
