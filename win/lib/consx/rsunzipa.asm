; RSUNZIPA.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include consx.inc

externdef at_background:byte
externdef at_foreground:byte

    .code

rsunzipat proc uses ebx
    .repeat
        lodsb
        mov dl,al
        and dl,0F0h
        .if dl == 0F0h
            mov ah,al
            lodsb
            and eax,0FFFh
            mov edx,eax
            lodsb
            call @04
            .repeat
                stosb
                inc edi
                dec edx
                .break .if ZERO?
            .untilcxz
            .break .if !ecx
        .else
            call @04
            stosb
            inc edi
        .endif
    .untilcxz
    ret
@04:
    mov ah,al
    and eax,0FF0h
    shr al,4
    movzx ebx,al
    mov al,at_background[ebx]
    mov bl,ah
    or  al,at_foreground[ebx]
    retn

rsunzipat endp

    END
