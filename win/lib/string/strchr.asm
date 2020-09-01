; STRCHR.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include string.inc

	.code

	option stackbase:esp

strchr	proc uses esi edi ebx string:LPSTR, char:int_t

	movzx	eax,BYTE PTR char
	imul	ebx,eax,01010101h
	mov	edi,string

	mov	eax,edi
	neg	eax
	and	eax,3
	jz	loop_4

	cmp	bl,[edi]
	je	exit_0
	cmp	ah,[edi]
	je	exit_NULL

	cmp	bl,[edi+1]
	je	exit_1
	cmp	ah,[edi+1]
	je	exit_NULL

	cmp	bl,[edi+2]
	je	exit_2
	cmp	ah,[edi+2]
	je	exit_NULL

	lea	edi,[edi+eax]

	ALIGN	4
loop_4:
	mov	esi,[edi]
	add	edi,4
	lea	ecx,[esi-01010101h]
	not	esi
	and	ecx,esi
	and	ecx,80808080h
	not	esi
	xor	esi,ebx
	lea	eax,[esi-01010101h]
	not	esi
	and	eax,esi
	and	eax,80808080h
	or	ecx,eax
	jz	loop_4
	bsf	ecx,ecx
	shr	ecx,3
	lea	eax,[ecx+edi-4]
	cmp	[eax],bl
	je	toend
exit_NULL:
	xor	eax,eax
	ALIGN	4
toend:
	test	eax,eax
	ret
exit_0:
	mov	eax,edi
	jmp	toend
exit_1:
	lea	eax,[edi+1]
	jmp	toend
exit_2:
	lea	eax,[edi+2]
	jmp	toend
strchr	endp

	END
