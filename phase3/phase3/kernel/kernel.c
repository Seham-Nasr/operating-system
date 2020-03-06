#include "../drivers/screen.h"

void main() {
    clear_screen();
    char* msg1 =
        "Hello Dr. Abdulah\n"
        "We are test to printing messages and scrolling using our C screen driver \n" 
	"from our 32-bit simple C kernel \n"
        "\n\0";
    print(msg1);

    char* msg2 = "OUR Group Esraa, Seham and Raghad\n\0";
    int i;
    for (i = 0; i<20; i++) {
        print(msg2);
    }
}

