; SCPUTC.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include consx.inc

    .code

scputc proc uses eax ecx edx x, y, l, char

  local NumberOfCharsWritten

    movzx ecx,byte ptr char
if 0
    .if AsciiSymbols[ecx]
        movzx eax,AsciiSymbols[ecx]
        mov cx,UnicodeSymbols[eax*2]
    .endif
endif
    movzx eax,byte ptr x
    movzx edx,byte ptr y
    shl   edx,16
    or    edx,eax

    FillConsoleOutputCharacter(
        hStdOutput,
        ecx,
        l,
        edx,
        &NumberOfCharsWritten)
    ret

scputc endp

    END
