; _SCRROW.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include consx.inc
include crtl.inc

    .data
    _scrrow         dd 24   ; Screen rows - 1
    _scrcol         dd 80   ; Screen columns
    OldConsoleMode  dd 0
    hCurrentWindow  HANDLE 0

    .code

Install proc private

  local ci:CONSOLE_SCREEN_BUFFER_INFO

    GetConsoleMode(hStdInput, &OldConsoleMode)

    mov hCurrentWindow,GetForegroundWindow()
    mov eax,ENABLE_WINDOW_INPUT
    .if console & CON_MOUSE

        or eax,ENABLE_MOUSE_INPUT
    .endif
    SetConsoleMode(hStdInput, eax)
    FlushConsoleInputBuffer(hStdInput)

    .if GetConsoleScreenBufferInfo(hStdOutput, &ci)

        mov eax,ci.dwSize
        movzx ecx,ax
        mov _scrcol,ecx
        shr eax,16
        dec eax
        mov _scrrow,eax
    .endif
    ret

Install endp

UnInstall:
    SetConsoleMode(hStdInput, OldConsoleMode)
    ret

.pragma init(Install, 7)
.pragma exit(UnInstall, 3)

    END
