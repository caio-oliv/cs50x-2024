#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdint.h>

#define ANSWER_SIZE 128

char* get_str_input(char* str, size_t num);
void lowercase(char* str);

char* get_player_answer(const char* prompt);
uint8_t get_letter_score(char letter);
uint32_t get_word_score(const char* word);

int main(void) {
	char* answer1 = get_player_answer("Player 1: ");
	char* answer2 = get_player_answer("Player 2: ");

	lowercase(answer1);
	lowercase(answer2);

	uint32_t score1 = get_word_score(answer1);
	uint32_t score2 = get_word_score(answer2);

	if (score1 > score2) {
		puts("Player 1 wins!");
	} else if (score1 < score2) {
		puts("Player 2 wins!");
	} else {
		puts("Tie!");
	}
}

uint32_t get_word_score(const char* word) {
	uint32_t score = 0;
	for (int i = 0; word[i]; i++) {
		score += get_letter_score(word[i]);
	}
	return score;
}

uint8_t get_letter_score(char letter) {
	switch (letter) {
		case 'a':
			return 1;
		case 'b':
			return 3;
		case 'c':
			return 3;
		case 'd':
			return 2;
		case 'e':
			return 1;
		case 'f':
			return 4;
		case 'g':
			return 2;
		case 'h':
			return 4;
		case 'i':
			return 1;
		case 'j':
			return 8;
		case 'k':
			return 5;
		case 'l':
			return 1;
		case 'm':
			return 3;
		case 'n':
			return 1;
		case 'o':
			return 1;
		case 'p':
			return 3;
		case 'q':
			return 10;
		case 'r':
			return 1;
		case 's':
			return 1;
		case 't':
			return 1;
		case 'u':
			return 1;
		case 'v':
			return 4;
		case 'w':
			return 4;
		case 'x':
			return 8;
		case 'y':
			return 4;
		case 'z':
			return 10;
		default:
			return 0;
	}
}

char* get_player_answer(const char* prompt) {
	char* answer = malloc(ANSWER_SIZE);

	do {
		fputs(prompt, stdout);
		get_str_input(answer, ANSWER_SIZE);
	} while (strlen(answer) == 0);

	return answer;
}

char* get_str_input(char* str, size_t num) {
	char* result = (char*)fgets(str, num, stdin);

	if (result == NULL) {
		while (fgetc(stdin) != '\n');
	}

	return result;
}

void lowercase(char* str) {
	for (int i = 0; str[i]; i++) {
		str[i] = tolower(str[i]);
	}
}
