#include <string.h>

#include "array.h"

void array_push(void *arr, size_t *count, const void *item, const size_t item_size)
{
	memcpy(arr + *count, item, item_size);
	*count += 1;
}

void *array_pop(void *arr, size_t *count)
{
	void *last = array_last(arr, *count);
	*count -= 1;
	return last;
}

void *array_last(const void *arr, const size_t count)
{
	return (void *)(arr + count - 1);
}
