; _LSEEK.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include io.inc
include errno.inc

    .code

_lseek proc handle:SINT, offs:SIZE_T, pos:SIZE_T

    mov eax,offs
    mov ecx,pos
    cdq
    .if ecx == SEEK_SET
        xor edx,edx
    .endif
    _lseeki64(handle, edx::eax, ecx)
    ret

_lseek endp

    end
