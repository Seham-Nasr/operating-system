;
;Boot sector to print a message
;

[org 0x7c00]			;Where this code will be load

mov bx, mymsg			;Use bx as a parmetar to our print function 
call print_msg			;call function print msg to print our string

jmp $				;Jump forever 

%include "print_msg.asm"	;Include the funcation that print string


;The message will be written 
mymsg:
db 'Hello,It is our first OS from scratsh',0
				; The zero tell our routine to stop print

times 510-($-$$) db 0		; Fill the 510 byte to 0
dw 0xaa55			; Magic number at last two bayts




