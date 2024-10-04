#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdio.h>

#include "common.h"

void get_str_input(string out_str, size_t size)
{
	do
	{
		*out_str = '\0';
		char *result = fgets(out_str, size, stdin);

		if (result == NULL)
		{
			while (fgetc(stdin) != '\n')
				;
		}
	} while (empty_str(out_str) || *out_str == '\n');

	size_t len = strlen(out_str);
	if (out_str[len - 1] == '\n' || out_str[len - 1] == '\r')
	{
		out_str[len - 1] = '\0';
	}
}

int get_int_input(void)
{
	int value = 0;
	int result = scanf("%d", &value);

	if (result == EOF)
	{
		exit(EXIT_ERROR_FILE_STREAM);
	}
	else if (result == 0)
	{
		while (fgetc(stdin) != '\n')
			;
	}

	return value;
}

bool empty_str(const string str)
{
	return *str == '\0';
}

void *box(size_t size)
{
	void *ptr = malloc(size);
	if (!ptr)
	{
		exit(EXIT_ERROR_MEM);
	}
	return ptr;
}

void init_zero(void *ptr, size_t size)
{
	memset(ptr, 0, size);
}
