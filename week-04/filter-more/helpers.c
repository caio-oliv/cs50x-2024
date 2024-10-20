#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "helpers.h"

#define MIN(a, b) (a < b ? a : b)
#define MAX(a, b) (a > b ? a : b)
#define IN_BOUNDS(min, max, val) (val >= min && val <= max)

#define M2x2 4
#define M3x3 9
#define M4x4 16

typedef enum rgb_channel_e {
	ch_blue_e = 0,
	ch_green_e = 1,
	ch_red_e = 2,
	ch_alpha_e = 3,
} rgb_channel_t;

RGBTRIPLE* make_pixel_row(const size_t width);
RGBTRIPLE pixel_black(void);
void print_pixel(const RGBTRIPLE pixel);

void take_channel_grid3(
	const uint32_t height,
	const uint32_t width,
	const RGBTRIPLE image[height][width],
	/// Index based
	const uint32_t y,
	const uint32_t x,
	const rgb_channel_t channel,
	uint8_t out_grid3[9]
);

uint8_t pixel_average(const RGBTRIPLE pixel);
RGBTRIPLE nearest_pixel_average(
	const uint32_t height,
	const uint32_t width,
	RGBTRIPLE image[height][width],
	/// Index based
	const uint32_t y,
	const uint32_t x
);
RGBTRIPLE sobel_filter(
	const uint32_t height,
	const uint32_t width,
	const RGBTRIPLE image[height][width],
	/// Index based
	const uint32_t y,
	const uint32_t x
);

float d_convolution_grid3(
	const uint32_t height,
	const uint32_t width,
	const RGBTRIPLE image[height][width],
	const uint32_t y,
	const uint32_t x,
	const rgb_channel_t channel,
	const float kernel[M3x3]
);
float d_convolution(const float matrix[M3x3], const float kernel[M3x3]);

// Row order
const float K_SOBEL_GY[M3x3] = {-1, -2, -1, 0, 0, 0, 1, 2, 1};
const float K_SOBEL_GX[M3x3] = {-1, 0, 1, -2, 0, 2, -1, 0, 1};

// Convert image to grayscale
void grayscale(
	uint32_t height,
	uint32_t width,
	RGBTRIPLE image[height][width]
) {
	for (uint32_t y = 0; y < height; y += 1) {
		for (uint32_t x = 0; x < width; x += 1) {
			const uint8_t avg = pixel_average(image[y][x]);

			image[y][x].rgbtBlue = avg;
			image[y][x].rgbtGreen = avg;
			image[y][x].rgbtRed = avg;
		}
	}
}

// Reflect image horizontally
void reflect(uint32_t height, uint32_t width, RGBTRIPLE image[height][width]) {
	const size_t row_size = sizeof(RGBTRIPLE) * width;
	RGBTRIPLE* row = make_pixel_row(width);

	for (uint32_t y = 0; y < height; y += 1) {
		memcpy(row, image[y], row_size);

		for (uint32_t x_up = 0, x_down = width - 1; x_up < width;
				 x_up += 1, x_down -= 1) {
			image[y][x_down] = row[x_up];
		}
	}

	free(row);
}

// Blur image
void blur(uint32_t height, uint32_t width, RGBTRIPLE image[height][width]) {
	const size_t row_size = sizeof(RGBTRIPLE) * width;
	RGBTRIPLE* row1 = make_pixel_row(width);
	RGBTRIPLE* row2 = make_pixel_row(width);

	for (uint32_t y = 0; y < height; y += 1) {
		for (uint32_t x = 0; x < width; x += 1) {
			row1[x] = nearest_pixel_average(height, width, image, y, x);
		}

		if (y > 0) {
			memcpy(image[y - 1], row2, row_size);
		}
		memcpy(row2, row1, row_size);
	}
	memcpy(image[height - 1], row2, row_size);

	free(row1);
	free(row2);
}

// Detect edges
void edges(uint32_t height, uint32_t width, RGBTRIPLE image[height][width]) {
	const size_t row_size = sizeof(RGBTRIPLE) * width;
	RGBTRIPLE* row1 = make_pixel_row(width);
	RGBTRIPLE* row2 = make_pixel_row(width);

	for (uint32_t y = 0; y < height; y += 1) {
		for (uint32_t x = 0; x < width; x += 1) {
			row1[x] = sobel_filter(height, width, image, y, x);
		}

		if (y > 0) {
			memcpy(image[y - 1], row2, row_size);
		}
		memcpy(row2, row1, row_size);
	}
	memcpy(image[height - 1], row2, row_size);

	free(row1);
	free(row2);
}

RGBTRIPLE pixel_black(void) {
	return (RGBTRIPLE){.rgbtBlue = 0, .rgbtGreen = 0, .rgbtRed = 0};
}

uint8_t pixel_average(const RGBTRIPLE pixel) {
	const uint32_t sum = (uint32_t)pixel.rgbtBlue + (uint32_t)pixel.rgbtGreen +
		(uint32_t)pixel.rgbtRed;
	return sum / 3;
}

RGBTRIPLE* make_pixel_row(const size_t width) {
	RGBTRIPLE* row = (RGBTRIPLE*)malloc(sizeof(RGBTRIPLE) * width);
	if (row == NULL) {
		exit(-1);
	}

	return row;
}

void take_channel_grid3(
	const uint32_t height,
	const uint32_t width,
	const RGBTRIPLE image[height][width],
	/// Index based
	const uint32_t y,
	const uint32_t x,
	const rgb_channel_t channel,
	uint8_t out_grid3[9]
) {
	uint8_t grid_idx = 0;
	for (int8_t yy = -1; yy <= 1; yy += 1) {
		if (!IN_BOUNDS(0, height, y + yy)) {
			out_grid3[grid_idx] = 0;
			grid_idx += 1;
			out_grid3[grid_idx] = 0;
			grid_idx += 1;
			out_grid3[grid_idx] = 0;
			grid_idx += 1;
			continue;
		}

		for (int8_t xx = -1; xx <= 1; xx += 1) {
			if (!IN_BOUNDS(0, width, x + xx)) {
				out_grid3[grid_idx] = 0;
				grid_idx += 1;
				continue;
			}

			out_grid3[grid_idx] = ((uint8_t*)&image[y + yy][x + xx])[channel];
			grid_idx += 1;
		}
	}
}

RGBTRIPLE sobel_filter(
	const uint32_t height,
	const uint32_t width,
	const RGBTRIPLE image[height][width],
	/// Index based
	const uint32_t y,
	const uint32_t x
) {
	float b_gy =
		d_convolution_grid3(height, width, image, y, x, ch_blue_e, K_SOBEL_GY);
	float g_gy =
		d_convolution_grid3(height, width, image, y, x, ch_green_e, K_SOBEL_GY);
	float r_gy =
		d_convolution_grid3(height, width, image, y, x, ch_red_e, K_SOBEL_GY);

	float b_gx =
		d_convolution_grid3(height, width, image, y, x, ch_blue_e, K_SOBEL_GX);
	float g_gx =
		d_convolution_grid3(height, width, image, y, x, ch_green_e, K_SOBEL_GX);
	float r_gx =
		d_convolution_grid3(height, width, image, y, x, ch_red_e, K_SOBEL_GX);

	float blue = sqrt((b_gx * b_gx) + (b_gy * b_gy));
	float green = sqrt((g_gx * g_gx) + (g_gy * g_gy));
	float red = sqrt((r_gx * r_gx) + (r_gy * r_gy));

	return (RGBTRIPLE){.rgbtBlue = blue, .rgbtGreen = green, .rgbtRed = red};
}

float d_convolution_grid3(
	const uint32_t height,
	const uint32_t width,
	const RGBTRIPLE image[height][width],
	const uint32_t y,
	const uint32_t x,
	const rgb_channel_t channel,
	const float kernel[M3x3]
) {
	uint8_t grid[M3x3] = {0};
	float grid_f[M3x3] = {0.0f};

	take_channel_grid3(height, width, image, y, x, channel, grid);
	for (uint8_t i = 0; i < 9; i += 1) {
		grid_f[i] = (float)grid[i];
	}

	return d_convolution(grid_f, kernel);
}

RGBTRIPLE nearest_pixel_average(
	const uint32_t height,
	const uint32_t width,
	RGBTRIPLE image[height][width],
	/// Index based
	const uint32_t y,
	const uint32_t x
) {
	uint32_t y_min = (uint32_t)MAX((int32_t)(y - 1), (int32_t)0);
	uint32_t x_min = (uint32_t)MAX((int32_t)(x - 1), (int32_t)0);
	uint32_t y_max = MIN(height - 1, y + 1);
	uint32_t x_max = MIN(width - 1, x + 1);

	uint32_t blue = 0;
	uint32_t green = 0;
	uint32_t red = 0;
	uint8_t pixel_count = 0;

	for (uint32_t yy = y_min; IN_BOUNDS(y_min, y_max, yy); yy += 1) {
		for (uint32_t xx = x_min; IN_BOUNDS(x_min, x_max, xx); xx += 1) {
			RGBTRIPLE pixel = image[yy][xx];

			blue += pixel.rgbtBlue;
			green += pixel.rgbtGreen;
			red += pixel.rgbtRed;
			pixel_count += 1;
		}
	}

	return (RGBTRIPLE
	){.rgbtBlue = blue / pixel_count,
		.rgbtGreen = green / pixel_count,
		.rgbtRed = red / pixel_count};
}

float d_convolution(const float matrix[M3x3], const float kernel[M3x3]) {
	return (matrix[0] * kernel[0]) + (matrix[1] * kernel[1]) +
		(matrix[2] * kernel[2]) + (matrix[3] * kernel[3]) +
		(matrix[4] * kernel[4]) + (matrix[5] * kernel[5]) +
		(matrix[6] * kernel[6]) + (matrix[7] * kernel[7]) + (matrix[8] * kernel[8]);
}

void print_pixel(const RGBTRIPLE pixel) {
	printf(
		"pixel {.blue = %i\n, .green = %i\n, .red = %i\n}",
		pixel.rgbtBlue,
		pixel.rgbtGreen,
		pixel.rgbtRed
	);
}
