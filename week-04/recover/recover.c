#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <memory.h>
#include <stdio.h>

#include "typedef.h"

#define EXIT_ERR_INVALID_USAGE 1
#define EXIT_ERR_INPUT_FILE 2
#define EXIT_ERR_MEM -1
#define EXIT_ERR_FILE_STREAM -2

#define MEMCARD_BLK_SIZE 512

#define RECOVERED_FILENAME_SIZE 32

/// @brief Program arguments type
typedef struct args_s {
	string filepath;
} args_t;

const uint8_t JPEG_FILE_SIGNATURE[3] = {0xff, 0xd8, 0xff};

/// @brief Parse program arguments
/// @param argc argument count
/// @param argv argument values
/// @return parsed argument
args_t parse_args(const int argc, const string argv[]);

/// @brief Open memory card file
/// @param filepath
/// @return non-null readable file stream
FILE* open_memory_card(const string restrict filepath);

/// @brief Recover Jpeg files in the provided memory card
/// @param card memory card
void recover_jpeg_files(FILE* restrict card);

/// @brief Alloc a memory card block
/// @return non-null buffer with size of MEMCARD_BLK_SIZE
uint8_t* make_memcard_block(void);

/// @brief Check if the first bytes of the array is a valid jpeg file signature
/// @param buf array buffer (must have at least 4 bytes)
/// @return boolean
bool is_jpeg_signature(const uint8_t buf[]);

/// @brief Format jpeg filename
/// @param number file number
/// @param out_filename filename output buffer
void format_jpeg_filename(uint32_t number, string restrict out_filename);

/// @brief Open a file and only return a valid file stream
/// @param filename
/// @param modes
/// @return non-null file stream
FILE* safe_open(const char* restrict filename, const char* restrict modes);

/// @brief Alloc a buffer with the specified size and only return a valid
/// pointer
/// @param size size of the allocation
/// @return non-null pointer
void* safe_alloc(const size_t size);

/// @brief Print an open memory card file error
/// @param filepath
void print_open_err(const string filepath);

int main(int argc, string argv[]) {
	const args_t arg = parse_args(argc, argv);

	{
		FILE* card = open_memory_card(arg.filepath);
		recover_jpeg_files(card);
		fclose(card);
	}

	return 0;
}

args_t parse_args(const int argc, const string argv[]) {
	// Accept a single command-line argument
	if (argc != 2) {
		puts("Usage: ./recover FILE");
		exit(EXIT_ERR_INVALID_USAGE);
	}

	return (args_t){.filepath = argv[1]};
}

FILE* open_memory_card(const string restrict filepath) {
	FILE* card = fopen(filepath, "r");
	if (card == NULL) {
		print_open_err(filepath);
		exit(EXIT_ERR_INVALID_USAGE);
	}

	return card;
}

void recover_jpeg_files(FILE* restrict card) {
	uint32_t curr_jpeg = 0;
	char filename[RECOVERED_FILENAME_SIZE] = "";
	uint8_t* buffer = make_memcard_block();
	FILE* jpeg = NULL;

	while (fread(buffer, MEMCARD_BLK_SIZE, 1, card)) {
		if (is_jpeg_signature(buffer)) {
			if (jpeg != NULL) {
				fclose(jpeg);
				jpeg = NULL;
			}

			format_jpeg_filename(curr_jpeg, filename);
			jpeg = safe_open(filename, "w");

			fwrite(buffer, MEMCARD_BLK_SIZE, 1, jpeg);
			curr_jpeg += 1;
			continue;
		}

		if (jpeg != NULL) {
			fwrite(buffer, MEMCARD_BLK_SIZE, 1, jpeg);
		}
	}

	free(buffer);
	fclose(jpeg);
}

uint8_t* make_memcard_block(void) {
	return (uint8_t*)safe_alloc(MEMCARD_BLK_SIZE);
}

bool is_jpeg_signature(const uint8_t buf[]) {
	return memcmp(buf, JPEG_FILE_SIGNATURE, 3) == 0 &&
		((buf[3] >> 4) ^ 0b1110) == 0;
}

void format_jpeg_filename(uint32_t number, string restrict out_filename) {
	int32_t err = sprintf(out_filename, "%03u.jpg", number);
	if (err <= 0) {
		exit(EXIT_ERR_MEM);
	}
}

FILE* safe_open(const char* restrict filename, const char* restrict modes) {
	FILE* file = fopen(filename, modes);
	if (file == NULL) {
		exit(EXIT_ERR_FILE_STREAM);
	}

	return file;
}

void* safe_alloc(const size_t size) {
	void* buf = malloc(size);
	if (buf == NULL) {
		exit(EXIT_ERR_MEM);
	}

	return buf;
}

void print_open_err(const string filepath) {
	fputs("Could not open ", stdout);
	fputs(filepath, stdout);
	fputc('\n', stdout);
}
