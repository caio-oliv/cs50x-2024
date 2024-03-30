#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <ctype.h>
#include <math.h>
#include <string.h>


#define TEXT_SIZE 4096
#define WORD_SEPARATOR ' '

char* get_str_input(char* str, size_t num);
char* get_answer(const char* prompt);

bool is_sentence_terminator(char ch);
uint64_t count_letters(const char* text);
uint64_t count_words(const char* text);
uint64_t count_sentences(const char* text);
float readability_score(float letter_avg, float sentence_avg);
void show_grade(int8_t grade);


int main(void) {
  char* text = get_answer("Text: ");

  uint64_t letters = count_letters(text);
  uint64_t words = count_words(text);
  uint64_t sentences = count_sentences(text);
  free(text);

  float letter_avg = ((float)letters / (float)words) * 100.0;
  float sentence_avg = ((float)sentences / (float)words) * 100.0;
  float score = readability_score(letter_avg, sentence_avg);

  int8_t grade = (int8_t)round(score);
  show_grade(grade);
}


void show_grade(int8_t grade) {
  if (grade >= 16) {
    puts("Grade 16+");
  } else if (grade < 1) {
    puts("Before Grade 1");
  } else {
    printf("Grade %i\n", grade);
  }
}

float readability_score(float letter_avg, float sentence_avg) {
  return 0.0588 * letter_avg - 0.296 * sentence_avg - 15.8;
}

uint64_t count_letters(const char* text) {
  uint64_t count = 0;
  for (int i = 0; text[i]; i++) {
    if (isalpha(text[i])) {
      count += 1;
    }
  }

  return count;
}

uint64_t count_words(const char* text) {
  uint64_t count = 0;

  bool previous_separator = text[0] == WORD_SEPARATOR;
  if (!previous_separator) {
    count += 1;
  }

  for (int i = 0; text[i]; i++) {
    if (text[i] == WORD_SEPARATOR) {
      previous_separator = true;
    } else if (previous_separator) {
      count += 1;
      previous_separator = false;
    }
  }

  return count;
}

uint64_t count_sentences(const char* text) {
  uint64_t count = 0;

  bool previous_terminator = false;
  for (int i = 0; text[i]; i++) {
    if (is_sentence_terminator(text[i])) {
      count += 1;
      previous_terminator = true;
    } else {
      previous_terminator = false;
    }
  }

  return count;
}

bool is_sentence_terminator(char ch) {
  return (ch == '.' || ch == '!' || ch == '?');
}


char* get_answer(const char* prompt) {
  char* answer = malloc(TEXT_SIZE);

  do {
    fputs(prompt, stdout);
    get_str_input(answer, TEXT_SIZE);
  } while (strlen(answer) == 0);

  return answer;
}

char* get_str_input(char* str, size_t num) {
  char* result = (char*)fgets(str, num, stdin);

  if (result == NULL) {
    while (fgetc(stdin) != '\n')
      ;
  }

  return result;
}
