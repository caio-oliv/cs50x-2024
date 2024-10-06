#include <stdio.h>
#include <stdlib.h>

#define NAME_SIZE 256

int main() {
	char *name = malloc(NAME_SIZE);
	printf("What's your name? ");
	scanf("%s", name);
	printf("hello, %s\n", name);

	return 0;
}
