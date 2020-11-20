; ASCIISYM.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include consx.inc

	.data
if 0
AsciiSymbols label byte
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 00-0F
    db 1, 2, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 4, 5 ; 10-1F
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 20-2F
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 30-3F
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 40-4F
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 50-5F
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 60-6F
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 70-7F
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 7 ; 80-8F ����������������
    db 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0 ; 90-9F ��������������׃
    db 0, 0, 0, 0, 0, 0, 0,10,11, 0, 0, 0,12, 0, 0,13 ; A0-AF �����Ѫ���������
    db 0, 0, 0, 0, 0,14,15,16, 0, 0, 0, 0, 0, 0, 0, 0 ; B0-BF �����������++��+
    db 0, 0, 0, 0, 0, 0, 0,17, 0, 0, 0, 0, 0, 0, 0, 0 ; C0-CF +--+-+��++--�-+�
    db 0, 0,18,19,20, 0,21,22, 0, 0, 0, 0, 0, 0,23, 0 ; D0-DF �����i���++�_�̯
    db 0,24, 0, 0, 0, 0, 0,25, 0,26,27,28, 0, 0, 0,29 ; E0-EF �����յ������ݯ�
    db 0,30, 0, 0, 0, 0, 0, 0,31, 0, 0,33,34, 0, 0, 0 ; F0-FF ��=�������������


UnicodeSymbols label word
    dw 0x0000
    dw 0x27E9 ; > 10 01 MATHEMATICAL RIGHT ANGLE BRACKET
    dw 0x27E8 ; < 11 02 MATHEMATICAL LEFT ANGLE BRACKET
    dw 0x2193 ;	  19 03 DOWNWARDS ARROW
    dw 0x2227 ;	  1E 04
    dw 0x2228 ;	  1F 05
    dw 0x2500 ; � 8E 06
    dw 0x253C ; � 8F 07
    dw 0x2554 ; � 90 08
    dw 0x0090 ; � 9A 09

    dw 0x2551 ; � A7 10
    dw 0x2510 ; � A8 11
    dw 0x2550 ; � AC 12
    dw 0x2557 ; � AF 13

    dw 0x2534 ; � B5 14
    dw 0x252C ; � B6 15
    dw 0x2514 ; � B7 16

    dw 0x251C ; � C7 17

    dw 0x2569 ; � D2 18
    dw 0x2566 ; � D3 19
    dw 0x255A ; � D4 20
    dw 0x2550 ; � D6 21
    dw 0x256C ; � D7 22
    dw 0x2560 ; � DE 23

    dw 0x0000 ; � E1 24
    dw 0x0000 ; � E7 25
    dw 0x250C ; � E9 26
    dw 0x0000 ; � EA 27
    dw 0x2518 ; � EB 28
    dw 0x2524 ; � EF 29

    dw 0x0000 ; � F1 30
    dw 0x0000 ; � F8 31
    dw 0x2563 ; � FB 32
    dw 0x2502 ; � FC 33
    dw 0x0000 ; � FD 34
endif
asciisymbol	label qword
ASCII_DOT	db 7
ASCII_RIGHT	db 16
ASCII_LEFT	db 17
ASCII_UP	db 0x1E
ASCII_DOWN	db 0x1F
ASCII_ARROWD	db 25
ASCII_RADIO	db 7
		db 0
ascii		db 7,16,17,1Eh,1Fh,25,7,0
ttf		db 0CFh,'<','>',0CFh,9Eh,0CFh,'*',0

	.code

setasymbol PROC

	lea ecx,ttf
	.if console & CON_ASCII
	    lea ecx,ascii
	.endif
	mov eax,[ecx]
	mov DWORD PTR asciisymbol,eax
	mov eax,[ecx+4]
	mov DWORD PTR asciisymbol[4],eax
	ret

setasymbol ENDP

	END
