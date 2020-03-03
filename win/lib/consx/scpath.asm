; SCPATH.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include consx.inc
include string.inc

    .code

scpath proc uses esi edi ecx edx x, y, l, string:LPSTR

  local b[16]:byte

    lea edi,b
    mov esi,string
    xor edx,edx
    .if strlen(esi) > l
        mov ecx,[esi]
        add esi,eax
        sub esi,l
        mov edx,4
        mov eax,'\..\'
        .if ch == ':'
            mov [edi+2],eax
            mov [edi],cx
            add edx,2
        .else
            mov [edi],eax
        .endif
        sub eax,eax
        mov [edi+edx],al
        scputs(x, y, eax, eax, edi)
        add esi,edx
        add x,edx
    .endif
    scputs(x, y, 0, 0, esi)
    add eax,edx
    ret
scpath endp

    END
