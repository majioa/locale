;[]-----------------------------------------------------------------[]
;|   DEFS.INC -- locale definitions file			     |
;[]-----------------------------------------------------------------[]
;
; $Copyright: 2005$
; $Revision: 1.1.1.1 $
;
	bits 32


%define PUBLIC GLOBAL
%define EXTRN EXTERN
%define endm endmacro
%define proc :
%define near
%define ptr
%define endp
%define tbyte tword
%define offset



%macro	jfe	1
	fstsw	ax
	test	ah, 1000000b
	jnz	%1
%endm


%macro	jfne	1
	fstsw	ax
	test	ah, 1000000b
	jz	%1
%endm


%macro	jfge	1
	fstsw	ax
	test	ah, 1
	jz	%1
%endm


%macro	jfl	1
	fstsw	ax
	test	ah, 1
	jnz	%1
%endm


	section _TEXT use32 public class=code align=16
	section _DATA use32 public class=data align=16
	__SECT__

;strings structure constants

SIZEOF_LOCALE	equ	4

BITS8CP      equ       00b
WCHARCP      equ       01b
UTFCP	     equ       10b
RUTFCP	     equ       11b


struc Locale
.CP:	  resw	    1
.CPType:  resb	    1
.CPType1: resb      1
endstruc

CP866	equ	0
CP1251	equ	0
MAC	equ	0
KOI8R	equ	0
CP10007 equ	0
CP8859_5 equ	0
