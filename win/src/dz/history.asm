; HISTORY.ASM--
; Copyright (C) 2016 Doszip Developers -- see LICENSE.TXT

include doszip.inc
include string.inc
include stdio.inc
include malloc.inc

    .code

historymove proc private uses esi edi ; AL direction

  local tmpPath:S_DIRECTORY

    mov ecx,eax
    mov eax,history

    .if eax

	lea edi,tmpPath
	mov esi,eax
	test cl,cl
	mov ecx,sizeof(S_DIRECTORY)
	mov edx,sizeof(S_DIRECTORY) * (MAXHISTORY-1)

	.ifz

	    add esi,edx
	    rep movsb
	    mov edi,eax
	    mov esi,eax
	    add esi,sizeof(S_DIRECTORY)
	    mov ecx,edx
	    xchg esi,edi
	    dec edx
	    add esi,edx
	    add edi,edx
	    inc edx
	    std
	    rep movsb
	    lea esi,tmpPath
	    mov edi,eax
	    mov ecx,sizeof(S_DIRECTORY)
	    cld
	.else
	    rep movsb
	    mov edi,eax
	    lea esi,[eax+sizeof(S_DIRECTORY)]
	    mov ecx,edx
	    rep movsb
	    lea esi,tmpPath
	    mov edi,eax
	    mov ecx,sizeof(S_DIRECTORY)
	    add edi,edx
	.endif
	rep movsb
    .endif
    ret

historymove endp

historysave proc uses esi ecx edx

    mov eax,cpanel
    mov eax,[eax].S_PANEL.pn_wsub
    mov edx,[eax].S_WSUB.ws_flag
    xor eax,eax

    .if !(edx & _W_ARCHIVE or _W_ROOTDIR)

	mov esi,offset _bufin

	.if _getcwd(esi, _MAX_PATH)

	    mov eax,history
	    .if eax

		mov eax,[eax]
		.if eax

		    .if !strcmp(esi, eax)

			jmp toend
		    .endif
		    xor eax,eax
		.endif

		historymove()
		mov esi,history
		mov eax,[esi]
		free(eax)


		mov [esi],_strdup(addr _bufin)
		mov edx,cpanel
		mov eax,[edx].S_PANEL.pn_fcb_index
		mov [esi].S_DIRECTORY.fcb_index,eax
		mov eax,[edx].S_PANEL.pn_cel_index
		mov [esi].S_DIRECTORY.cel_index,eax
		mov edx,[edx]
		mov eax,[edx]
		and eax,not _P_FLAGMASK
		mov [esi].S_DIRECTORY.flag,eax
		inc eax
	    .endif
	.endif
    .endif
toend:
    ret
historysave endp

DirectoryToCurrentPanel proc uses esi edi directory

    mov esi,directory
    xor eax,eax

    .if esi

	.if eax != [esi]

	    mov edi,cpanel
	    mov edi,[edi]
	    mov edx,[edi]

	    .if !(edx & _W_ARCHIVE or _W_ROOTDIR)

		mov eax,edx
		and eax,_P_FLAGMASK
		or  eax,[esi].S_DIRECTORY.flag
		mov [edi],eax
		mov eax,[esi].S_DIRECTORY.fcb_index
		mov edx,[esi].S_DIRECTORY.cel_index
		mov ecx,cpanel
		mov [ecx].S_PANEL.pn_fcb_index,eax
		mov [ecx].S_PANEL.pn_cel_index,edx

		cpanel_setpath([esi])
		panel_redraw(cpanel)
		mov eax,1
	    .endif
	.endif
    .endif
    test eax,eax
    ret

DirectoryToCurrentPanel endp

cmpathleft proc	    ; Alt-Left - Previous Directory

    historysave()
    mov eax,1
    historymove()
    DirectoryToCurrentPanel(history)
    .ifz

	historymove()
    .endif
    ret

cmpathleft endp

cmpathright proc    ; Alt-Right - Next Directory

    historysave()
    xor eax,eax
    historymove()
    DirectoryToCurrentPanel(history)
    .ifz

	inc eax
	historymove()
    .endif
    ret

cmpathright endp

    END
