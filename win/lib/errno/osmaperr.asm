; OSMAPERR.ASM--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

include errno.inc
include winbase.inc

    .data

errnotable label byte
        db EINVAL
        db ENOENT
        db ENOENT
        db EMFILE
        db EACCES
        db EBADF
        db ENOMEM
        db ENOMEM
        db ENOMEM
        db E2BIG
        db ENOEXEC
        db EINVAL
        db EINVAL
        db ENOENT
        db EACCES
        db EXDEV
        db ENOENT
        db EACCES
        db ENOENT
        db EACCES
        db ENOENT
        db EEXIST
        db EACCES
        db EACCES
        db EINVAL
        db EAGAIN
        db EACCES
        db EPIPE
        db ENOSPC
        db EBADF
        db EINVAL
        db ECHILD
        db ECHILD
        db EBADF
        db EINVAL
        db EACCES
        db ENOTEMPTY
        db EACCES
        db ENOENT
        db EAGAIN
        db EACCES
        db EEXIST
        db ENOENT
        db EAGAIN
        db ENOMEM

syserrtable label word
        dw ERROR_INVALID_FUNCTION
        dw ERROR_FILE_NOT_FOUND
        dw ERROR_PATH_NOT_FOUND
        dw ERROR_TOO_MANY_OPEN_FILES
        dw ERROR_ACCESS_DENIED
        dw ERROR_INVALID_HANDLE
        dw ERROR_ARENA_TRASHED
        dw ERROR_NOT_ENOUGH_MEMORY
        dw ERROR_INVALID_BLOCK
        dw ERROR_BAD_ENVIRONMENT
        dw ERROR_BAD_FORMAT
        dw ERROR_INVALID_ACCESS
        dw ERROR_INVALID_DATA
        dw ERROR_INVALID_DRIVE
        dw ERROR_CURRENT_DIRECTORY
        dw ERROR_NOT_SAME_DEVICE
        dw ERROR_NO_MORE_FILES
        dw ERROR_LOCK_VIOLATION
        dw ERROR_BAD_NETPATH
        dw ERROR_NETWORK_ACCESS_DENIED
        dw ERROR_BAD_NET_NAME
        dw ERROR_FILE_EXISTS
        dw ERROR_CANNOT_MAKE
        dw ERROR_FAIL_I24
        dw ERROR_INVALID_PARAMETER
        dw ERROR_NO_PROC_SLOTS
        dw ERROR_DRIVE_LOCKED
        dw ERROR_BROKEN_PIPE
        dw ERROR_DISK_FULL
        dw ERROR_INVALID_TARGET_HANDLE
        dw ERROR_INVALID_HANDLE
        dw ERROR_WAIT_NO_CHILDREN
        dw ERROR_CHILD_NOT_COMPLETE
        dw ERROR_DIRECT_ACCESS_HANDLE
        dw ERROR_NEGATIVE_SEEK
        dw ERROR_SEEK_ON_DEVICE
        dw ERROR_DIR_NOT_EMPTY
        dw ERROR_NOT_LOCKED
        dw ERROR_BAD_PATHNAME
        dw ERROR_MAX_THRDS_REACHED
        dw ERROR_LOCK_FAILED
        dw ERROR_ALREADY_EXISTS
        dw ERROR_FILENAME_EXCED_RANGE
        dw ERROR_NESTING_NOT_ALLOWED
        dw ERROR_NOT_ENOUGH_QUOTA

    .code

osmaperr proc

    mov edx,GetLastError()
    mov _doserrno,eax
    xor ecx,ecx
    mov eax,-1

    .repeat

        .whiles ecx < 45
            .if dx == syserrtable[ecx*2]
                movzx ecx,errnotable[ecx]
                mov errno,ecx
                .break(1)
            .endif
            inc ecx
        .endw

        .if edx >= ERROR_WRITE_PROTECT && edx <= ERROR_SHARING_BUFFER_EXCEEDED

            mov errno,EACCES
        .elseif edx >= ERROR_INVALID_STARTING_CODESEG && edx <= ERROR_INFLOOP_IN_RELOC_CHAIN

            mov errno,ENOEXEC
        .else
            mov errno,EINVAL
        .endif
    .until 1
    ret

osmaperr endp

    END
