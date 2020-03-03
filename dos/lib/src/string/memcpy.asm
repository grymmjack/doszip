; MEMCPY.ASM--
; Copyright (C) 2015 Doszip Developers

include string.inc

	.code

memcpy PROC _CType PUBLIC USES si di s1:PTR BYTE, s2:PTR BYTE, count:size_t
	push	ds
	les	di,s1
	lds	si,s2
	mov	cx,count
	mov	ax,di
	mov	dx,WORD PTR s1+2
	rep	movsb
	pop	ds
	ret
memcpy ENDP

	END
