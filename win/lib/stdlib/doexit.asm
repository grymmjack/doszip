; DOEXIT.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include internal.inc

_initterm proto __cdecl :ptr _PVFV, :ptr _PIFV

;;
;; pointers to initialization sections
;;
externdef __xi_a:_PIFV
externdef __xi_z:_PIFV
externdef __xt_a:_PVFV
externdef __xt_z:_PVFV

    .data
;;
;; flag indicating if C runtime termination has been done. set if exit,
;; _exit, _cexit or _c_exit has been called. checked when _CRTDLL_INIT
;; is called with DLL_PROCESS_DETACH.
;;
_C_Termination_Done int_t FALSE
_C_Exit_Done        int_t FALSE

    .code

doexit proc code:int_t, quick:int_t, retcaller:int_t

    .repeat

if not defined(_CRT_APP) and defined(CRTDLL)
        .if (!retcaller && check_managed_app())

            ;;
            ;; Only if the EXE is managed then we call CorExitProcess.
            ;; Native cleanup is done in .cctor of the EXE
            ;; If the Exe is Native then native clean up should be done
            ;; before calling (Cor)ExitProcess.
            ;;
            __crtCorExitProcess(code)
        .endif
endif

        .if (_C_Exit_Done != TRUE)
            mov _C_Termination_Done,TRUE

            ;; save callable exit flag (for use by terminators)
            mov eax,retcaller
            mov _exitflag,al ;; 0 = term, !0 = callable exit
ifndef CRTDLL
            ;;
            ;; do terminators
            ;;
            _initterm(&__xt_a, &__xt_z)
endif
if not defined(CRTDLL) and defined(_DEBUG)
            ;; Dump all memory leaks
            .if (!retcaller && _CrtSetDbgFlag(_CRTDBG_REPORT_FLAG) & _CRTDBG_LEAK_CHECK_DF)

                __freeCrtMemory()
                _CrtDumpMemoryLeaks()
            .endif
endif
        .endif
        ;; return to OS or to caller

        .break .if (retcaller)

        mov _C_Exit_Done,TRUE
        __crtExitProcess(code)

    .until 1
    ret

doexit endp

    end
