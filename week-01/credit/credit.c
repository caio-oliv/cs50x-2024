#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define INPUT_SIZE 1024

#define AMERICAN_EXPRESS "AMEX"
#define MASTER_CARD "MASTERCARD"
#define VISA "VISA"

char* get_str_input(char* str, size_t num);
uint64_t parse_uint64_t(const char* str, const size_t len, uint8_t* err);

uint64_t get_card_number();
bool is_card_number_legit(uint64_t num);
const char* get_card_flag(const uint64_t number);

int main() {
	uint64_t number = get_card_number();

	if (!is_card_number_legit(number)) {
		printf("INVALID\n");
		return 0;
	}

	const char* flag = get_card_flag(number);
	if (flag == NULL) {
		printf("INVALID\n");
		return 0;
	}

	printf("%s\n", flag);
	return 0;
}

const char* get_card_flag(const uint64_t number) {
	uint8_t digit_count = 2;
	uint64_t first_2digit = number;
	while (first_2digit > 99) {
		first_2digit /= 10;
		digit_count += 1;
	}

	if ((first_2digit == 34 || first_2digit == 37) && digit_count == 15) {
		return AMERICAN_EXPRESS;
	} else if ((first_2digit >= 51 && first_2digit <= 55) && digit_count == 16) {
		return MASTER_CARD;
	} else if ((first_2digit >= 40 && first_2digit <= 49) &&
						 (digit_count == 13 || digit_count == 16)) {
		return VISA;
	}

	return NULL;
}

bool is_card_number_legit(uint64_t num) {
	bool mult_by_2 = false;
	uint32_t sum = 0;

	while (num != 0) {
		uint8_t digit = num % 10;

		if (mult_by_2) {
			uint8_t product = digit * 2;
			sum += (product % 10) + (product / 10);
		} else {
			sum += digit;
		}

		num /= 10;
		mult_by_2 = !mult_by_2;
	}

	return (sum % 10) == 0;
}

uint64_t get_card_number() {
	uint64_t number = 0;
	char* str = malloc(INPUT_SIZE);
	if (str == NULL) {
		exit(1);
	}

	do {
		printf("Number: ");
		char* input_result = get_str_input(str, INPUT_SIZE);
		if (input_result == NULL) {
			continue;
		}

		uint8_t parse_error = 0;
		number = parse_uint64_t(str, strlen(str) - 1, &parse_error);
		if (parse_error) {
			number = 0;
			continue;
		}
	} while (number == 0);

	free(str);
	return number;
}

uint64_t parse_uint64_t(const char* str, const size_t len, uint8_t* err) {
	uint64_t num = 0;
	size_t i = 0;
	*err = 2;

	while (str[i] != '\0' && i < len) {
		char c = str[i];
		if (c >= '0' && c <= '9') {
			num = num * 10 + (c - '0');
		} else {
			*err = 1;
			return num;
		}

		i += 1;
	}

	*err = 0;
	return num;
}

char* get_str_input(char* str, size_t num) {
	char* result = (char*)fgets(str, num, stdin);

	if (result == NULL) {
		while (fgetc(stdin) != '\n');
	}

	return result;
}
