; Routine: output string in bx to screen
 
print_msg: 

pusha			;Push all register value to stack

mov ah, 0x0E		; int 10h 'print char' function

repeat:
mov al, [bx]		; Store character in al 
cmp al, 0		; check if end of string byte= 0
je done 		; If char bx zero, end of string
int 0x10 		; Otherwise, print it
add bx, 0x01
jmp repeat
 
done:

popa
ret
 
