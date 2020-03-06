; A boot sector that boots a kernel in 32-bit protected mode
[org 0x7c00]

jmp 0:start

KERNEL_OFFSET equ 0x1000; Memory offset to which we will load our kernel
KERNEL_SIZE equ 15	; Number of sectors

start:
mov [BOOT_DRIVE] , dl 	; BIOS stores our boot drive in DL , so it 's
			; best to remember this for later.

xor ax , ax		; Set DS and ES to 0.
mov ds , ax
mov es , ax

mov bp , 0x9000 	; Set the stack.
mov sp , bp

mov bx , MSG_REAL_MODE
call print_string 

; By Default, BIOS will load only the first 512-byte sector from the boot disk.

call load_kernel        ; Load our kernel

call switch_to_pm 	; Note that we never return from here.

jmp $

%include "print_string.asm"
%include "disk_load.asm"
%include "gdt.asm"
%include "switch_to_pm.asm"
%include "print_string_pm.asm"



[bits 16]

load_kernel:
  
  mov bx , MSG_LOAD_KERNEL
  call print_string
 

  mov dl , [BOOT_DRIVE] ; Read from the boot disk (excluding boot sector)
  mov dh, KERNEL_SIZE
  mov bx , KERNEL_OFFSET; Load to 0x0000 (ES) : KERNEL_OFFSET (BX).

  call disk_load

  mov bx , MSG_KERNEL_LOADED
  call print_string
 
  ; Check that kernel loaded correctly to the intended address of memory
  ; DEBUG

  ret


[bits 32]
; This is where we arrive after switching to and initialising protected mode.

BEGIN_PM:

  mov ebx , MSG_PROT_MODE
  mov ah, WHITE_ON_GREEN
  mov al, 12
  call print_string_pm	; Use our 32-bit print routine.

  call KERNEL_OFFSET	; Now jump to the address of our loaded
			; kernel code, Here we go!

  jmp $ 		; Hang.

; Global variables
BOOT_DRIVE:		db 0	; will be updated at the beggining of the bootloader.
MSG_REAL_MODE: 		db "Started in 16-bit Real Mode:", 13, 10, 0
MSG_LOAD_KERNEL:	db "Loading kernel into memory...", 13, 10, 0
MSG_KERNEL_LOADED:	db "Kernel Loaded.", 13, 10, 0
MSG_PROT_MODE: 		db "Successfully landed in 32-bit Protected Mode:", 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55
