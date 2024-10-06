#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>

// Max number of candidates
#define MAX 9

// Maximum name size
#define MAX_NAME_SIZE 32

#define EXIT_ERROR_MEM -1
#define EXIT_ERROR_FILE_STREAM -2

typedef char* string;

// Candidates have name and vote count
typedef struct {
	char* name;
	int votes;
} candidate;

// Array of candidates
candidate candidates[MAX];

// Number of candidates
int candidate_count;

int get_int_input();
void get_str_input(string str, size_t num);
bool empty_str(const string str);

// Function prototypes
void fprint_candidates(FILE* restrict stream);
void get_all_votes(size_t voter_count);
int get_voter_count(const string prompt);
void get_vote(const string prompt, string name);
bool vote(const string name);
void print_winner(void);

int main(int argc, char* argv[]) {
	// Check for invalid usage
	if (argc < 2) {
		printf("Usage: plurality [candidate ...]\n");
		return 1;
	}

	// Populate array of candidates
	candidate_count = argc - 1;
	if (candidate_count > MAX) {
		printf("Maximum number of candidates is %i\n", MAX);
		return 2;
	}
	for (int i = 0; i < candidate_count; i++) {
		candidates[i].name = argv[i + 1];
		candidates[i].votes = 0;
	}

	int voter_count = get_voter_count("Number of voters: ");

	get_all_votes(voter_count);

	// Display winner of election
	print_winner();
}

void fprint_candidates(FILE* restrict stream) {
	for (int i = 0; i < candidate_count; i++) {
		fprintf(
			stream,
			"candidate \"%s\" has %i votes\n",
			candidates[i].name,
			candidates[i].votes
		);
	}
}

void get_all_votes(size_t voter_count) {
	string name = (string)malloc(MAX_NAME_SIZE);
	if (name == NULL) {
		exit(EXIT_ERROR_MEM);
	}

	// Loop over all voters
	for (int i = 0; i < voter_count; i++) {
		get_vote("Vote: ", name);

		// Check for invalid vote
		if (!vote(name)) {
			printf("Invalid vote.\n");
		}
	}

	free(name);
}

// Update vote totals given a new vote
bool vote(const string name) {
	for (int i = 0; i < candidate_count; i++) {
		if (strcmp(name, candidates[i].name) == 0) {
			candidates[i].votes += 1;
			return true;
		}
	}

	return false;
}

// Print the winner (or winners) of the election
void print_winner(void) {
	int winner_votes = 0;

	for (int i = 0; i < candidate_count; i++) {
		if (candidates[i].votes > winner_votes) {
			winner_votes = candidates[i].votes;
		}
	}

	for (int i = 0; i < candidate_count; i++) {
		if (candidates[i].votes == winner_votes) {
			fputs(candidates[i].name, stdout);
			fputs("\n", stdout);
		}
	}
}

void get_vote(const string prompt, string name) {
	do {
		if (prompt) {
			fputs(prompt, stdout);
		}
		get_str_input(name, MAX_NAME_SIZE);
	} while (empty_str(name));
}

int get_voter_count(const string prompt) {
	if (prompt) {
		fputs(prompt, stdout);
	}
	return get_int_input();
}

void get_str_input(string str, size_t size) {
	do {
		*str = '\0';
		char* result = fgets(str, size, stdin);

		if (result == NULL) {
			while (fgetc(stdin) != '\n');
		}
	} while (empty_str(str) || *str == '\n');

	size_t len = strlen(str);
	if (str[len - 1] == '\n' || str[len - 1] == '\r') {
		str[len - 1] = '\0';
	}
}

int get_int_input() {
	int value = 0;
	int result = scanf("%d", &value);

	if (result == EOF) {
		exit(EXIT_ERROR_FILE_STREAM);
	} else if (result == 0) {
		while (fgetc(stdin) != '\n') {};
	}

	return value;
}

bool empty_str(const string str) {
	return *str == '\0';
}
