#include <stdio.h>
#include <unistd.h>

int main(void)
{
	while (1){
		printf("Hello World!\n");
		usleep(1);
	}
	return 0;
}
