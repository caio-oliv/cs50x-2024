#include <stddef.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#include <strings.h>
#include <ctype.h>

#include "dictionary.h"

#define WORD_BYTE_SIZE (LENGTH + 1)

#define LOAD_CHUNK_SIZE 1024

#define HASH_MAP_ARRAY_SIZE 256

// Represents a node in a hash table
typedef struct node {
	char word[LENGTH + 1];
	struct node* next;
} node;

const unsigned int N = HASH_MAP_ARRAY_SIZE;

// Hash table
node* table[HASH_MAP_ARRAY_SIZE];

bool hash_map_add(const char word[WORD_BYTE_SIZE]);
node* alloc_node(void);
void node_set_word(node* no, const char word[WORD_BYTE_SIZE]);

bool is_word_char(const char ch);

// Returns true if word is in dictionary, else false
bool check(const char* word) {
	uint32_t w_hash = hash(word);

	node* no = table[w_hash];
	while (no) {
		if (strcasecmp(no->word, word) == 0) {
			return true;
		}
		no = no->next;
	}

	return false;
}

// Hashes word to a number
unsigned int hash(const char* word) {
	uint64_t sum = 0;
	while (*word != '\0') {
		sum += tolower(*word);
		word++;
	}

	return sum % N;
}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char* dictionary) {
	// Open the dictionary file
	FILE* source = fopen(dictionary, "r");
	if (source == NULL) {
		return false;
	}

	// Read each word in the file
	char word[WORD_BYTE_SIZE] = {'\0'};
	char buf[LOAD_CHUNK_SIZE] = {'\0'};

	size_t read = 0;
	size_t word_idx = 0;
	do {
		read = fread(buf, sizeof(char), LOAD_CHUNK_SIZE, source);

		// Add each word to the hash table
		for (uint32_t i = 0; i < read; i++) {
			if (is_word_char(buf[i])) {
				word[word_idx] = buf[i];
				word_idx++;
				continue;
			}

			word[word_idx] = '\0';
			if (!hash_map_add(word)) {
				return false;
			}

			word_idx = 0;
		}
	} while (read == LOAD_CHUNK_SIZE);

	// Close the dictionary file
	fclose(source);
	return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void) {
	uint32_t size = 0;

	for (uint32_t i = 0; i < N; i++) {
		const node* no = table[i];
		while (no) {
			size += 1;
			no = no->next;
		}
	}

	return size;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void) {
	for (uint32_t i = 0; i < N; i++) {
		node* no = table[i];
		while (no) {
			node* temp = no;
			no = no->next;
			free(temp);
		}

		table[i] = NULL;
	}

	return true;
}

bool hash_map_add(const char word[WORD_BYTE_SIZE]) {
	uint32_t w_hash = hash(word);

	node* new_node = alloc_node();
	if (new_node == NULL) {
		return false;
	}

	new_node->next = NULL;
	node_set_word(new_node, word);

	node* node_it = table[w_hash];
	if (node_it == NULL) {
		table[w_hash] = new_node;
		return true;
	}

	while (node_it->next) {
		node_it = node_it->next;
	}

	node_it->next = new_node;
	return true;
}

node* alloc_node(void) {
	return malloc(sizeof(node));
}

void node_set_word(node* no, const char word[WORD_BYTE_SIZE]) {
	memcpy(no->word, word, WORD_BYTE_SIZE);
}

bool is_word_char(const char ch) {
	return (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z') || ch == '\'';
}
