ifndef __DZLIB_INC
__DZLIB_INC equ <>
include strlib.inc
.xlist

mkbstring	proto __cdecl :LPSTR, :QWORD
searchp		proto __cdecl :LPSTR
getenvp		proto __cdecl :LPSTR
expenviron	proto __cdecl :LPSTR
SaveEnvironment proto __cdecl :LPSTR
ReadEnvironment proto __cdecl :LPSTR
CreateBatch	proto __cdecl cmd:string_t, call_cmd:int_t, update_environ:int_t

GetEnvironmentTEMP proto __cdecl
GetEnvironmentPATH proto __cdecl
GetEnvironmentSize proto __cdecl :LPSTR
_print		proto _CDecl :LPSTR, :VARARG

;;;;;;;;;;;;;;; drvinfo

MAXDRIVES	equ 26
WMAXPATH	equ 2048

_DI_ROOTDIR	equ 0x00020000	; _FB_ROOTDIR
_DI_CDROOM	equ 0x00080000	; _FB_CDROOM
_DI_VOLID	equ 0x00000008	; _A_VOLID

S_DISK		STRUC
di_flag		dd ?
di_time		dd ?
di_size		dq ?
di_name		db 32 dup(?)
S_DISK		ENDS

externdef	drvinfo:S_DISK	; [MAXDRIVES]

_disk_read	PROTO
_disk_exist	PROTO :UINT

;;;;;;;;;;;;;;;

WMAXPATH	equ 2048

_DISK_LOCAL	equ 0x0001
_DISK_FLOPPY	equ 0x0100
_DISK_NETWORK	equ 0x0200
_DISK_SUBST	equ 0x0400
_DISK_CDROOM	equ 0x0800

DRIVE_REMOVABLE equ 2	; _disk_type()
DRIVE_FIXED	equ 3
DRIVE_REMOTE	equ 4
DRIVE_CDROM	equ 5
DRIVE_RAMDISK	equ 6

externdef	cp_stdpath:	SBYTE
externdef	cp_stdmask:	SBYTE
externdef	fp_maskp:	LPSTR
externdef	fp_directory:	PVOID	; int (*fp_directory)(char *);
externdef	fp_fileblock:	PVOID	; int (*fp_fileblock)(char *, wfblk *);
externdef	OldErrorMode:	DWORD

validdrive	PROTO :SINT

scansub		PROTO :LPSTR, :LPSTR, :UINT
scan_files	PROTO :LPSTR
scan_directory	PROTO :UINT, :LPSTR
recursive	PROTO :LPSTR, :LPSTR, :LPSTR

_disk_init	PROTO :UINT
_disk_type	PROTO :UINT
_disk_test	PROTO :UINT
_disk_ready	PROTO :UINT
_disk_retry	PROTO :UINT
_disk_select	PROTO :LPSTR

GetVolumeID	PROTO :LPSTR, :LPSTR
GetFileSystemName PROTO :LPSTR, :LPSTR

setfattr	proto __cdecl :LPTSTR, :UINT
filexist	proto __cdecl :LPSTR
readword	proto __cdecl :LPSTR
getftime	proto __cdecl :SINT
getftime_access proto __cdecl :SINT
getftime_create proto __cdecl :SINT
setftime	proto __cdecl :SINT, :DWORD
setftime_access proto __cdecl :SINT, :DWORD
setftime_create proto __cdecl :SINT, :DWORD
osopen		proto __cdecl :LPSTR, :UINT, :UINT, :UINT

externdef	console:DWORD
externdef	_diskflag:DWORD

.list
endif ;; __DZLIB_INC
