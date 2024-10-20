#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>

#include "helpers.h"

/// Define allowable filters
#define FILTER_OPT "begr"

#define EXIT_ERR_INVALID_FILTER_OPT 1
#define EXIT_ERR_ONE_FILTER_OPT 2
#define EXIT_ERR_INVALID_USAGE 3
#define EXIT_ERR_OPEN_INPUT_FILE 4
#define EXIT_ERR_CREATE_INPUT_FILE 5

/// String type
typedef char* string;

/// Program arguments
typedef struct args_s {
	/// Filter flag
	char filter;
	/// Input filepath
	string input_file;
	/// Output filepath
	string output_file;
} args_t;

/// Parse the argument options
args_t parse_args(const int32_t argc, const string argv[]);

int main(int argc, string argv[]) {
	const args_t arg = parse_args(argc, argv);

	// Open input file
	FILE* inptr = fopen(arg.input_file, "r");
	if (inptr == NULL) {
		printf("Could not open %s.\n", arg.input_file);
		return EXIT_ERR_OPEN_INPUT_FILE;
	}

	// Open output file
	FILE* outptr = fopen(arg.output_file, "w");
	if (outptr == NULL) {
		fclose(inptr);
		printf("Could not create %s.\n", arg.output_file);
		return EXIT_ERR_CREATE_INPUT_FILE;
	}

	// Read infile's BITMAPFILEHEADER
	BITMAPFILEHEADER bf;
	fread(&bf, sizeof(BITMAPFILEHEADER), 1, inptr);

	// Read infile's BITMAPINFOHEADER
	BITMAPINFOHEADER bi;
	fread(&bi, sizeof(BITMAPINFOHEADER), 1, inptr);

	// Ensure infile is (likely) a 24-bit uncompressed BMP 4.0
	if (bf.bfType != 0x4d42 || bf.bfOffBits != 54 || bi.biSize != 40 ||
			bi.biBitCount != 24 || bi.biCompression != 0) {
		fclose(outptr);
		fclose(inptr);
		printf("Unsupported file format.\n");
		return 6;
	}

	// Get image's dimensions
	uint32_t height = (uint32_t)abs(bi.biHeight);
	uint32_t width = (uint32_t)bi.biWidth;

	// Allocate memory for image
	RGBTRIPLE(*image)[width] = calloc(height, width * sizeof(RGBTRIPLE));
	if (image == NULL) {
		printf("Not enough memory to store image.\n");
		fclose(outptr);
		fclose(inptr);
		return 7;
	}

	// Determine padding for scanlines
	int32_t padding = (4 - (width * sizeof(RGBTRIPLE)) % 4) % 4;

	// Iterate over infile's scanlines
	for (uint32_t i = 0; i < height; i++) {
		// Read row into pixel array
		fread(image[i], sizeof(RGBTRIPLE), width, inptr);

		// Skip over padding
		fseek(inptr, padding, SEEK_CUR);
	}

	// Filter image
	switch (arg.filter) {
		// Blur
		case 'b':
			blur(height, width, image);
			break;

		// Edges
		case 'e':
			edges(height, width, image);
			break;

		// Grayscale
		case 'g':
			grayscale(height, width, image);
			break;

		// Reflect
		case 'r':
			reflect(height, width, image);
			break;
	}

	// Write outfile's BITMAPFILEHEADER
	fwrite(&bf, sizeof(BITMAPFILEHEADER), 1, outptr);

	// Write outfile's BITMAPINFOHEADER
	fwrite(&bi, sizeof(BITMAPINFOHEADER), 1, outptr);

	// Write new pixels to outfile
	for (uint32_t i = 0; i < height; i++) {
		// Write row to outfile
		fwrite(image[i], sizeof(RGBTRIPLE), width, outptr);

		// Write padding at end of row
		for (int32_t k = 0; k < padding; k++) {
			fputc(0x00, outptr);
		}
	}

	// Free memory for image
	free(image);

	// Close files
	fclose(inptr);
	fclose(outptr);
	return 0;
}

args_t parse_args(const int32_t argc, const string argv[]) {
	// Get filter flag and check validity
	char filter = getopt(argc, argv, FILTER_OPT);
	if (filter == '?') {
		printf("Invalid filter.\n");
		exit(EXIT_ERR_INVALID_FILTER_OPT);
	}

	// Ensure only one filter
	if (getopt(argc, argv, FILTER_OPT) != -1) {
		printf("Only one filter allowed.\n");
		exit(EXIT_ERR_ONE_FILTER_OPT);
	}

	// Ensure proper usage
	if (argc != optind + 2) {
		printf("Usage: ./filter [flag] infile outfile\n");
		exit(EXIT_ERR_INVALID_USAGE);
	}

	// Remember filenames
	char* infile = argv[optind];
	char* outfile = argv[optind + 1];

	return (args_t
	){.input_file = infile, .output_file = outfile, .filter = filter};
}
