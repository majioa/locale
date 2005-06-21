;[]-----------------------------------------------------------------[]
;|LOCALE.ASM -- locale class functions	                             |
;[]-----------------------------------------------------------------[]
;
;$Copyright:2005$
;$Revision:1.0$
;
	%include'defs.inc'

	section	_TEXT

	GLOBAL	@Locale@$bctr$qqrv
	GLOBAL	@Locale@$bdtr$qqrv
	GLOBAL	@Locale@GetSystemCodepage$qqrv
	GLOBAL	@Locale@GetDecimalConstant$qqrv
	EXTERN	GetACP

%ifdef  WIN32
_mainCRTStartup:
	mov	eax,[decimal_constant]
	mov	eax,1
DllEntryPoint_exit1:
	ret	0ch
%endif

@Locale@$bctr$qqrv:
%ifdef	WIN32
	push	ebx
	mov	ebx,eax
	call	GetACP
;	movzx	ecx,byte[CPCount]
	mov	dwordptr[ebx],0
	mov	edx,CP_COUNT*8
	mov	ecx,CPs
@Locale@GetSystemCodepage$qqrv_loop:
	sub	edx,8
	jz	@Locale@GetSystemCodepage$qqrv_not_found
	cmp	eax,[edx+ecx]
	jnz	@Locale@GetSystemCodepage$qqrv_loop
@Locale@GetSystemCodepage$qqrv_not_found:
	mov	eax,[edx+ecx+4]
	mov	[ebx],eax
	mov	eax,ebx
	pop	ebx
%endif
	ret



@Locale@$bdtr$qqrv:
	test	dl,2
	jz	@Locale@$bdtr$qqrv_exit
;	freer
@Locale@$bdtr$qqrv_exit:
	ret


@Locale@GetSystemCodepage$qqrv:
	moveax,[eax]
	ret



@Locale@GetDecimalConstant$qqrv:
	moveax,[decimal_constant]
	ret

	section	_DATA

decimal_constant    dd	10
CP_COUNTequ	15
CPs:
;Thai
	dd	874,0
;Japan
	dd	932,0
;Chinese(PRC,Singapore)
	dd	936,0
;Korean
	dd	949,0
;Chinese(Taiwan,HongKong)
	dd	950,0
;Unicode(BMPofISO10646)
	dd	1200,0
;Windows3.1EasternEuropean
	dd	1250,0
;Windows3.1Cyrillic
	dd	1251,BITS8CP<<24+CP1251
;Windows3.1Latin1(US,WesternEurope)
	dd	1252,0
;Windows3.1Greek
	dd	1253,0
;Windows3.1Turkish
	dd	1254,0
;Hebrew
	dd	1255,0
;Arabic
	dd	1256,0
;Baltic
	dd	1257,0

