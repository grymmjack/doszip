; _TIME.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include time.inc
include winbase.inc

    .code

time proc timeptr:LPTIME

  local SystemTime:SYSTEMTIME

    GetLocalTime(&SystemTime)
    _loctotime_t(
        SystemTime.wYear,
        SystemTime.wMonth,
        SystemTime.wDay,
        SystemTime.wHour,
        SystemTime.wMinute,
        SystemTime.wSecond)

    mov ecx,timeptr
    .if ecx
        mov [ecx],eax
    .endif
    ret

time endp

    END
