; TISTRIPEND.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include string.inc
include ltype.inc

    .code

tistripend proc uses esi string:LPSTR
    mov esi,string
    mov ecx,strlen(esi)
    .if eax
        add esi,eax
        xor eax,eax
        .repeat
            dec esi
            mov al,[esi]
            mov al,byte ptr _ltype[eax+1]
            .break .if !(al & _SPACE)
            mov [esi],ah
        .untilcxz
        mov eax,ecx
        test eax,eax
    .endif
    ret
tistripend endp

    END
