

void main () {
// Create a pointer to a char , and point it to the first text cell of
// video memory ( i . e . the top - left of the screen )
char *video_memory = ( char *) 0xb8000 ;
// At the address pointed to by video_memory , store the character ’X ’
// ( i . e . display ’X ’ in the top - left of the screen ).
*video_memory = 'X' ;
}

/* This will force us to create a kernel entry function instead of jumping to kernel.c:0x00 */
void dummy_test_entrypoint() {
}

