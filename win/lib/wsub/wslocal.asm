include direct.inc
include wsub.inc

    .code

wslocal proc wsub:ptr S_WSUB
    mov eax,wsub
    .if _getcwd([eax].S_WSUB.ws_path, WMAXPATH)
        wssetflag(wsub)
    .endif
    ret
wslocal endp

    END
