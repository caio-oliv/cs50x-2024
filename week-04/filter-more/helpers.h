#pragma once

#include "bmp.h"

// Convert image to grayscale
void grayscale(uint32_t height, uint32_t width, RGBTRIPLE image[height][width]);

// Reflect image horizontally
void reflect(uint32_t height, uint32_t width, RGBTRIPLE image[height][width]);

// Detect edges
void edges(uint32_t height, uint32_t width, RGBTRIPLE image[height][width]);

// Blur image
void blur(uint32_t height, uint32_t width, RGBTRIPLE image[height][width]);
