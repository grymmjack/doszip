; FILESEARCH.INC--
;
; Copyright (c) The Asmc Contributors. All rights reserved.
; Consult your license regarding permissions and restrictions.
;

FFMAXHIT equ 9999

.class FileSearch

    dialog      ptr_t ?
    basedir     string_t ?
    cursor      S_CURSOR <>
    ll          S_LOBJ <>
    oldff       ptr_t ?
    oldhelp     ptr_t ?

    FileSearch  proc :string_t
    Release     proc
    WndProc     proc :uint_t
    Find        proc
    Modal       proc
    PutCellId   proc
    UpdateCell  proc
    CurItem     proc
    CurFile     proc
    List        proc
    ClearList   proc
    Searchpath  proc :string_t
   .ends
