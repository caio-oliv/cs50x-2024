#include <stdio.h>

#define PYRAMID_HEIGHT_MIN 1
#define PYRAMID_HEIGHT_MAX 8
#define PYRAMID_GAP 2
#define PYRAMID_BLOCK '#'
#define AIR_BLOCK ' '

#include "../../lib/common.h"

void write_pyramid(int height);
void write_pyramid_gap();
int get_pyramid_height(int min, int max);

int main() {
	int height = get_pyramid_height(PYRAMID_HEIGHT_MIN, PYRAMID_HEIGHT_MAX);
	write_pyramid(height);
}

int get_pyramid_height(int min, int max) {
	int height = 0;

	do {
		printf("Height: ");
		height = get_int_input();
	} while (height < min || height > max);

	return height;
}

void write_pyramid_gap() {
	for (int gap = PYRAMID_GAP; gap > 0; gap--) {
		putchar(AIR_BLOCK);
	}
}

void write_pyramid(int height) {
	//      #  #
	//     ##  ##
	//    ###  ###
	//   ####  ####
	//  #####  #####
	// ######  ######

	for (int row = 1; row <= height; row++) {
		int air1 = height - row;
		int block1 = height - air1;
		int block2 = block1;

		while (air1) {
			putchar(AIR_BLOCK);
			air1--;
		}
		while (block1) {
			putchar(PYRAMID_BLOCK);
			block1--;
		}

		write_pyramid_gap();

		while (block2) {
			putchar(PYRAMID_BLOCK);
			block2--;
		}

		putchar('\n');
	}

	fflush(stdout);
}
