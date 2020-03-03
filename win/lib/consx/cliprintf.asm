; CLIPRINTF.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include consx.inc
include string.inc
include malloc.inc
include stdio.inc
include limits.inc

.code

cliprintf proc _CDecl uses esi edi ebx format: LPSTR, args:VARARG

    local o: _iobuf

    mov o._flag,_IOWRT or _IOSTRG
    mov o._cnt,INT_MAX
    lea eax,_bufin
    mov o._ptr,eax
    mov o._base,eax
    _output(&o, format, &args)
    mov ecx,o._ptr
    mov byte ptr [ecx],0
    .if eax
        mov edi,eax
        .if OpenClipboard(0)
            EmptyClipboard()
            inc edi
            .if GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE, edi)
                dec edi
                mov esi,eax
                mov ebx,GlobalLock(eax)
                strcpy(ebx, &_bufin)
                GlobalUnlock(esi)
                SetClipboardData(CF_TEXT, ebx)
                mov eax,edi
            .endif
            push eax
            CloseClipboard()
            pop eax
        .endif
    .endif
    ret

cliprintf endp

    END
