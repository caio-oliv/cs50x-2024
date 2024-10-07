#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <float.h>
#include <math.h>
#include <string.h>

#include "../../lib/common.h"

/// ### Macros:

/// Number of bytes in .wav header
#define WAV_HEADER_SIZE 44
#define WAV_SAMPLE_BLOCK 1024

/// Maximum number of retries of an IO operation
#define MAX_IO_RETRY 3

/// Open file exit error
#define EXIT_ERR_OPEN_FILE 3
/// Write/read file error
#define EXIT_ERR_RW_FILE 4

/// ### Type definitions:

typedef struct args_s {
	/// Input filepath
	string input;
	/// Output filepath
	string output;
	/// Factor float string
	string factor_str;
} args_t;

/// ### Function declaration:

/// Validate command-line arguments
args_t validate_args(const int32_t argc, const string argv[]);
/// Parse the factor argument as a string
float parse_factor(const string restrict factor_str);
FILE* safe_fopen(const string restrict filename, const string restrict modes);

void terminate_wav_read();
void terminate_wav_write();

bool read_wav_header(uint8_t* restrict wav_header, FILE* restrict stream);
bool write_wav_header(uint8_t* restrict wav_header, FILE* restrict stream);
/// Copy header from input file to output file
bool copy_wav_header(FILE* restrict input, FILE* restrict output);
size_t read_wav_samples(
	int16_t* restrict wav_samples,
	/// Number of samples in the wav_samples array
	const size_t size,
	FILE* restrict stream
);
size_t write_wav_samples(
	int16_t* restrict wav_samples,
	/// Number of samples in the wav_samples array
	const size_t size,
	FILE* restrict stream
);

int32_t main(const int32_t argc, const string argv[]) {
	const args_t arg = validate_args(argc, argv);

	// Open files and determine scaling factor
	FILE* input = safe_fopen(arg.input, "r");
	FILE* output = safe_fopen(arg.output, "w");
	const float factor = parse_factor(arg.factor_str);

	if (!copy_wav_header(input, output)) {
		terminate_wav_write();
	}

	// Read samples from input file and write updated data to output file
	int16_t* samples = box(sizeof(int16_t) * WAV_SAMPLE_BLOCK);

	size_t read = 0;
	size_t copied = 0;
	do {
		read = read_wav_samples(samples, WAV_SAMPLE_BLOCK, input);
		for (size_t idx = 0; idx < read; idx += 1) {
			samples[idx] *= factor;
		}

		copied = write_wav_samples(samples, read, output);
		uint8_t retry = 0;
		while (copied != read && retry < MAX_IO_RETRY) {
			copied += write_wav_samples(
				samples + (copied * sizeof(int16_t)), read - copied, output
			);
			retry += 1;
		}
	} while (copied == WAV_SAMPLE_BLOCK);

	if (copied != read) {
		terminate_wav_write();
	}

	// Close files
	fclose(input);
	fclose(output);
}

args_t validate_args(const int32_t argc, const string argv[]) {
	if (argc != 4) {
		printf("Usage: ./volume input.wav output.wav factor\n");
		exit(EXIT_ERROR_INVALID_USAGE);
	}

	return (args_t){.input = argv[1], .output = argv[2], .factor_str = argv[3]};
}

float parse_factor(const string factor_str) {
	const float factor = atof(factor_str);

	if (fpclassify(factor) != FP_NORMAL || factor <= 0.0f) {
		puts("Invalid factor argument\n");
		exit(EXIT_ERROR_INVALID_USAGE);
	}

	return factor;
}

FILE* safe_fopen(const string restrict filename, const string restrict modes) {
	FILE* file = fopen(filename, modes);

	if (file == NULL) {
		printf("Could not open file.\n");
		exit(EXIT_ERR_OPEN_FILE);
	}

	return file;
}

void terminate_wav_read() {
	puts("Could not read WAV file\n");
	exit(EXIT_ERR_RW_FILE);
}

void terminate_wav_write() {
	puts("Could not write WAV file\n");
	exit(EXIT_ERR_RW_FILE);
}

bool read_wav_header(uint8_t* restrict wav_header, FILE* restrict stream) {
	return fread(wav_header, WAV_HEADER_SIZE, 1, stream) ? true : false;
}

bool write_wav_header(uint8_t* restrict wav_header, FILE* restrict stream) {
	return fwrite(wav_header, WAV_HEADER_SIZE, 1, stream) ? true : false;
}

bool copy_wav_header(FILE* restrict input, FILE* restrict output) {
	uint8_t* wav_header = box(sizeof(uint8_t) * WAV_HEADER_SIZE);

	if (!read_wav_header(wav_header, input)) {
		return false;
	}
	if (!write_wav_header(wav_header, output)) {
		return false;
	}

	free(wav_header);
	return true;
}

size_t read_wav_samples(
	int16_t* restrict wav_samples,
	/// Number of samples in the wav_samples array
	const size_t size,
	FILE* restrict stream
) {
	return fread(wav_samples, sizeof(int16_t), size, stream);
}

size_t write_wav_samples(
	int16_t* restrict wav_samples,
	/// Number of samples in the wav_samples array
	const size_t size,
	FILE* restrict stream
) {
	return fwrite(wav_samples, sizeof(int16_t), size, stream);
}
