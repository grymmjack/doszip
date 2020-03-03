; SCPUTW.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include consx.inc

    .code

scputw proc uses eax x, y, l, w

    mov eax,w
    .if ah
        mov al,ah
        scputa(x, y, l, eax)
    .endif
    scputc(x, y, l, w)
    ret

scputw endp

    END
