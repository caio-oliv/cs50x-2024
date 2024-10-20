#include <stddef.h>

// Function prototypes
void array_push(
	void* arr,
	size_t* count,
	const void* item,
	const size_t item_size
);
void* array_pop(void* arr, size_t* count, const size_t item_size);

void* array_last(const void* arr, const size_t count, const size_t item_size);
