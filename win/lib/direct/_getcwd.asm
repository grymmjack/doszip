; _GETCWD.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include direct.inc

    .code

_getcwd proc buffer:LPSTR, maxlen:SINT

    _getdcwd(0, buffer, maxlen)
    ret

_getcwd endp

    END
