include tinfo.inc

    .code

twindows proc
    .switch tdlgopen()
      .case 2
        tiflush(tinfo)
        .endc
      .case 1
        tclosefile()
      .case 0
        .endc
      .default
        mov tinfo,titogglefile(tinfo, eax)
    .endsw
    ret
twindows endp

    END
