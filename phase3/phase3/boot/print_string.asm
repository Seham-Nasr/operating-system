print_string:
; TODO : Print string with address stored in BX

pusha							; Push all register values to the stack

mov ah , 0x0e			; int =10/ ah =0x0e -> BIOS tele-type output

loop:						
	mov al , [bx]		; Store character in AL so our function will print it.
	cmp al , 0			; Check if end of string byte = 0.
	je stop_print 	; Stop Printing
	int 0x10				; Print the character in AL
	add bx , 0x01		; Increment BX to get the address of next character in the string.
	jmp loop	

stop_print:

popa							; Restore original register values
ret								; Return from the function call
