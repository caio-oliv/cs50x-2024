#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <ctype.h>
#include <string.h>


#define KEY_SIZE 26
#define PLAINTEXT_SIZE 4096

char* get_str_input(char* str, size_t num);

void show_usage(const char* cmd);
void show_ciphertext(const char* cipher);
bool parse_key(char dest[KEY_SIZE], const char* str);
char* get_plaintext();
char substitute_char(char ch, char key[KEY_SIZE]);
void substitute(char* ciphertext, const char* plaintext, char key[KEY_SIZE]);


int main(const int argc, const char* argv[]) {
  if (argc != 2) {
    show_usage(argv[0]);
    return 1;
  }

  char key[KEY_SIZE];
  if (!parse_key(key, argv[1])) {
    show_usage(argv[0]);
    return 1;
  }

  char* plaintext = get_plaintext();
  char* ciphertext = malloc(strlen(plaintext));
  substitute(ciphertext, plaintext, key);
  show_ciphertext(ciphertext);

  return 0;
}

void show_usage(const char* cmd) {
  printf("Usage: %s key\n", cmd);
}

void show_ciphertext(const char* cipher) {
  printf("ciphertext:%s\n", cipher);
}

bool parse_key(char dest[KEY_SIZE], const char* str) {
  uint8_t i = 0;
  uint32_t char_bitmap = 0;

  while (i < KEY_SIZE && str[i]) {
    dest[i] = toupper(str[i]);

    if (!isupper(dest[i])) {
      return false;
    }

    uint32_t bit_entry = 1 << (dest[i] - 'A');
    if (char_bitmap & bit_entry) {
      // character already present
      return false;
    }
    char_bitmap |= bit_entry;
    
    i++;
  }

  // assert the key size
  return i == KEY_SIZE && str[KEY_SIZE] == '\0';
}

void substitute(char* ciphertext, const char* plaintext, char key[KEY_SIZE]) {
  for (int i = 0; plaintext[i]; i++) {
    ciphertext[i] = substitute_char(plaintext[i], key);
  }
}

char substitute_char(char ch, char key[KEY_SIZE]) {
  if (islower(ch)) {
    uint8_t index = ch - 'a';
    return key[index] + ('a' - 'A');
  }
  
  if (isupper(ch)) {
    uint8_t index = ch - 'A';
    return key[index];
  }
  
  return ch;
}

char* get_plaintext() {
  fputs("plaintext:", stdout);
  char* plaintext = malloc(PLAINTEXT_SIZE);
  get_str_input(plaintext, PLAINTEXT_SIZE);
  return plaintext;
}

char* get_str_input(char* str, size_t num) {
  char* result = (char*)fgets(str, num, stdin);

  if (result == NULL) {
    while (fgetc(stdin) != '\n')
      ;
  }

  return result;
}
