; TDIDLE.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include consx.inc

    .data
    tdidle PVOID tdummy

    .code

tdummy:
    xor eax,eax
    ret

    END
