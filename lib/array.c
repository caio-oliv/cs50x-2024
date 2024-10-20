#include <string.h>

#include "array.h"

void array_push(
	void* arr,
	size_t* count,
	const void* item,
	const size_t item_size
) {
	memcpy((char*)arr + (*count * item_size), item, item_size);
	*count += 1;
}

void* array_pop(void* arr, size_t* count, const size_t item_size) {
	void* last = array_last(arr, *count, item_size);
	if (last == NULL) {
		return last;
	}

	*count -= 1;
	return last;
}

void* array_last(const void* arr, const size_t count, const size_t item_size) {
	if (count == 0) {
		return NULL;
	}

	return (void*)((char*)arr + ((count - 1) * item_size));
}
