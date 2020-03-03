include malloc.inc
include wsub.inc

    .code

    assume esi:ptr S_WSUB

wsclose proc uses esi wsub:ptr S_WSUB

    mov esi,wsub
    wsfree(esi)
    push eax
    free([esi].ws_fcb)
    .if [esi].ws_flag & _W_MALLOC

	free([esi].ws_path)
    .endif
    xor eax,eax
    mov [esi].ws_flag,eax
    mov [esi].ws_fcb,eax
    pop eax
    ret

wsclose endp

    END
