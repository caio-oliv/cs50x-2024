#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/// common header
#define EXIT_ERROR_MEM -1
#define EXIT_ERROR_FILE_STREAM -2
#define EXIT_ERROR_INVALID_USAGE 1

// Type definitions
typedef char* string;

// Function prototypes
int get_int_input(void);
void get_str_input(string out_str, size_t num);
bool empty_str(const string str);

void* box(size_t size);
void init_zero(void* ptr, size_t size);

/// array header
void array_push(
	void* arr,
	size_t* count,
	const void* item,
	const size_t item_size
);
void* array_pop(void* arr, size_t* count);

void* array_last(const void* arr, const size_t count);

#define MAX_CANDIDATES 9
#define PAIR_CAPACITY (MAX_CANDIDATES * (MAX_CANDIDATES - 1) / 2)

#define MAX_CANDIDATE_NAME 64

#define EXIT_ERROR_TOO_MANY_CANDIDATES 2
#define EXIT_ERROR_INVALID_VOTE 3
#define EXIT_ERROR_NO_WINNER 4

// Type definitions
typedef struct pair_s {
	/**
	 * Candidate index of the winner of this pair
	 */
	int winner;
	/**
	 * Candidate index of the loser of this pair
	 */
	int loser;
} pair_t;

// Function prototypes
uint8_t validade_args(
	int argc,
	const string argv[],
	string out_candidates[MAX_CANDIDATES]
);
void init_winning_graph(bool graph[MAX_CANDIDATES][MAX_CANDIDATES]);
void init_preferences_graph(int pref[MAX_CANDIDATES][MAX_CANDIDATES]);
void take_preferences(
	uint32_t voter_count,
	uint8_t candidate_cnt,
	const string candts[MAX_CANDIDATES],
	int out_preferences[MAX_CANDIDATES][MAX_CANDIDATES]
);

bool real_vote(
	const string name,
	const string candts[],
	uint8_t candidate_cnt,
	int* out_vote
);
void real_record_preferences(
	int pref[MAX_CANDIDATES][MAX_CANDIDATES],
	const int ranks[],
	const uint8_t candidate_cnt
);
bool is_preference_tie(
	const int pref[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_a,
	const uint8_t candidate_b
);
int fill_pairs(
	pair_t pair_arr[PAIR_CAPACITY],
	const int pref[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_cnt
);
void real_sort_pairs(pair_t pair_arr[PAIR_CAPACITY], const int pair_cnt);
int32_t cmp_pair(const pair_t* pair_a, const pair_t* pair_b);
void print_pair(const pair_t pair, FILE* stream);
void graph_pairs(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const pair_t pair_arr[PAIR_CAPACITY],
	const int pair_cnt,
	const uint8_t candidate_cnt
);
bool winning_graph_has_cycle(
	const bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_cnt
);
int32_t get_winner(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_cnt
);
bool won_over_some(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate,
	const uint8_t candidate_cnt
);
bool lose_over_some(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate,
	const uint8_t candidate_cnt
);

string make_candidate_name(void);
string read_candidate_name(string out_name, const string prompt);
uint32_t read_voter_count(const string prompt);

/// # Globals:

// Array of candidates
string candidates[MAX_CANDIDATES] = {};
uint8_t candidate_count = 0;

// preferences[i][j] is number of voters who prefer i over j
int preferences[MAX_CANDIDATES][MAX_CANDIDATES] = {};

pair_t pairs[PAIR_CAPACITY] = {};
int pair_count = 0;

// locked[i][j] means i is locked in over j
bool locked[MAX_CANDIDATES][MAX_CANDIDATES] = {};

int get_pair_strength(const pair_t pair);

/// Expected functions prototypes:
bool vote(int rank, string name, int ranks[]);
void record_preferences(int ranks[]);
void add_pairs(void);
void sort_pairs(void);
void lock_pairs(void);
void print_winner(void);

int main(int argc, string argv[]) {
	candidate_count = validade_args(argc, argv, candidates);

	const uint32_t voter_count = read_voter_count("Number of voters: ");
	take_preferences(voter_count, candidate_count, candidates, preferences);

	pair_count = fill_pairs(pairs, preferences, candidate_count);
	real_sort_pairs(pairs, pair_count);

	graph_pairs(locked, pairs, pair_count, candidate_count);

	int32_t winner = get_winner(locked, candidate_count);
	if (winner < 0) {
		return EXIT_ERROR_NO_WINNER;
	}

	puts(candidates[winner]);
	return 0;
}

bool vote(int rank, string name, int ranks[]) {
	return real_vote(name, candidates, candidate_count, ranks + rank);
}

void record_preferences(int ranks[]) {
	real_record_preferences(preferences, ranks, candidate_count);
}

void add_pairs(void) {
	init_zero(pairs, sizeof(pair_t) * PAIR_CAPACITY);
	pair_count = fill_pairs(pairs, preferences, MAX_CANDIDATES);
}

void sort_pairs(void) {
	real_sort_pairs(pairs, pair_count);
}

void lock_pairs(void) {
	graph_pairs(locked, pairs, pair_count, candidate_count);
}

void print_winner(void) {
	int32_t winner = get_winner(locked, candidate_count);
	if (winner < 0) {
		puts("draw");
	}

	puts(candidates[winner]);
}

uint8_t validade_args(
	const int argc,
	const string argv[],
	string out_candidates[MAX_CANDIDATES]
) {
	// Check for invalid usage
	if (argc < 2) {
		fputs("Usage: tideman [candidate ...]\n", stdout);
		exit(EXIT_ERROR_INVALID_USAGE);
	}

	candidate_count = argc - 1;
	if (candidate_count > MAX_CANDIDATES) {
		printf("Maximum number of candidates is %i\n", MAX_CANDIDATES);
		exit(EXIT_ERROR_TOO_MANY_CANDIDATES);
	}

	// Populate array of candidates
	for (int i = 0; i < candidate_count; i++) {
		out_candidates[i] = argv[i + 1];
	}

	return candidate_count;
}

void init_winning_graph(bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES]) {
	// Clear graph of locked in pairs
	for (int i = 0; i < MAX_CANDIDATES; i++) {
		init_zero((bool*)winning_graph[i], MAX_CANDIDATES);
	}
}

void init_preferences_graph(int pref[MAX_CANDIDATES][MAX_CANDIDATES]) {
	// Clear graph of locked in pairs
	for (int i = 0; i < MAX_CANDIDATES; i++) {
		init_zero((int*)pref[i], MAX_CANDIDATES);
	}
}

void take_preferences(
	const uint32_t voter_count,
	const uint8_t candidate_cnt,
	const string candts[MAX_CANDIDATES],
	int out_preferences[MAX_CANDIDATES][MAX_CANDIDATES]
) {
	// A rank by the voter preference
	// Stores the candidate index
	int* ranks = (int*)box(candidate_cnt * sizeof(int));
	string name = make_candidate_name();

	// Query for votes
	for (uint32_t i = 0; i < voter_count; i++) {
		// Query for each rank
		for (uint8_t rank = 0; rank < candidate_cnt; rank++) {
			printf("Rank %i: ", rank + 1);
			read_candidate_name(name, NULL);

			if (!real_vote(name, candts, candidate_cnt, &ranks[rank])) {
				printf("Invalid vote.\n");
				exit(EXIT_ERROR_INVALID_VOTE);
			}
		}

		real_record_preferences(out_preferences, ranks, candidate_cnt);
		printf("\n");
	}

	free(name);
	free(ranks);
}

// Update ranks given a new vote
bool real_vote(
	const string name,
	const string candts[],
	const uint8_t candidate_cnt,
	int* out_vote
) {
	for (uint8_t idx = 0; idx < candidate_cnt; idx++) {
		if (strcmp(candts[idx], name) == 0) {
			*out_vote = (int)idx;
			return true;
		}
	}

	return false;
}

// Update preferences given one voter's ranks
void real_record_preferences(
	int pref[MAX_CANDIDATES][MAX_CANDIDATES],
	const int ranks[],
	const uint8_t candidate_cnt
) {
	for (uint8_t up_rank = 0; up_rank < candidate_cnt; up_rank++) {
		uint8_t low_rank_start = up_rank + 1;
		for (uint8_t low_rank = low_rank_start; low_rank < candidate_cnt;
				 low_rank++) {
			pref[ranks[up_rank]][ranks[low_rank]] += 1;
		}
	}
}

bool is_preference_tie(
	const int pref[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_a,
	const uint8_t candidate_b
) {
	return pref[candidate_a][candidate_b] == pref[candidate_b][candidate_a];
}

bool is_preferred_candidate(
	const int pref[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_a,
	const uint8_t candidate_b
) {
	return pref[candidate_a][candidate_b] > pref[candidate_b][candidate_a];
}

// Record pairs of candidates where one is preferred over the other
int fill_pairs(
	pair_t pair_arr[PAIR_CAPACITY],
	const int pref[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_cnt
) {
	int count = 0;

	for (uint8_t cand_a = 0; cand_a < candidate_cnt; cand_a++) {
		for (uint8_t cand_b = 0; cand_b < candidate_cnt; cand_b++) {
			const int votes = pref[cand_a][cand_b];
			if (votes != 0 && is_preferred_candidate(pref, cand_a, cand_b)) {
				pair_arr[count] = (pair_t){.winner = (int)cand_a, .loser = (int)cand_b};
				count += 1;
			}
		}
	}

	return count;
}

int get_pair_strength(const pair_t pair) {
	return preferences[pair.winner][pair.loser];
}

static int32_t cmp_pair_blank_des(const void* pair_a, const void* pair_b) {
	return cmp_pair((pair_t*)pair_b, (pair_t*)pair_a);
}

// Sort pairs in decreasing order by the winner strength
void real_sort_pairs(pair_t pair_arr[PAIR_CAPACITY], const int pair_cnt) {
	qsort(pair_arr, pair_cnt, sizeof(pair_t), cmp_pair_blank_des);
}

int32_t cmp_pair(const pair_t* pair_a, const pair_t* pair_b) {
	return (int32_t)get_pair_strength(*pair_a) -
		(int32_t)get_pair_strength(*pair_b);
}

void print_pair(const pair_t pair, FILE* stream) {
	fprintf(
		stream,
		"pair {.winner = %i, .loser = %i, .winner_strength = %i}",
		pair.winner,
		pair.loser,
		get_pair_strength(pair)
	);
}

// Lock pairs into the candidate graph in order, without creating cycles
void graph_pairs(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const pair_t pair_arr[PAIR_CAPACITY],
	const int pair_cnt,
	const uint8_t candidate_cnt
) {
	for (uint32_t i = 0; i < pair_cnt; i++) {
		const pair_t pair = pair_arr[i];
		winning_graph[pair.winner][pair.loser] = true;
		if (winning_graph_has_cycle(winning_graph, candidate_cnt)) {
			winning_graph[pair.winner][pair.loser] = false;
			continue;
		}
	}
}

bool winning_graph_has_cycle(
	const bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_cnt
) {
	const size_t size = sizeof(bool) * candidate_cnt;
	bool* visited = box(size);
	init_zero(visited, size);
	bool* on_stack = box(size);
	init_zero(on_stack, size);

	uint8_t* stack = box(sizeof(uint8_t) * MAX_CANDIDATES);
	size_t stack_count = 0;

	for (uint8_t w = 0; w < candidate_cnt; w++) {
		if (visited[w]) {
			continue;
		}

		array_push(stack, &stack_count, &w, sizeof(uint8_t));

		while (stack_count != 0) {
			uint8_t top = *(uint8_t*)array_last(stack, stack_count);

			if (!visited[top]) {
				visited[top] = true;
				on_stack[top] = true;
			} else {
				on_stack[top] = false;
				array_pop(stack, &stack_count);
			}

			for (uint8_t i = 0; i < candidate_cnt; i++) {
				bool edge = winning_graph[top][i];
				if (!edge) {
					continue;
				}

				if (!visited[i]) {
					array_push(stack, &stack_count, &i, sizeof(uint8_t));
				} else if (on_stack[i]) {
					return true;
				}
			}
		}
	}
	return false;
}

// Print the winner of the election
int32_t get_winner(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_cnt
) {
	for (uint8_t canidate = 0; canidate < candidate_cnt; canidate++) {
		if (won_over_some(winning_graph, canidate, candidate_cnt) &&
				!lose_over_some(winning_graph, canidate, candidate_cnt)) {
			return canidate;
		}
	}

	return -1;
}

bool won_over_some(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate,
	const uint8_t candidate_cnt
) {
	for (uint8_t i = 0; i < candidate_cnt; i++) {
		if (winning_graph[candidate][i]) {
			return true;
		}
	}
	return false;
}

bool lose_over_some(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate,
	const uint8_t candidate_cnt
) {
	for (uint8_t i = 0; i < candidate_cnt; i++) {
		if (winning_graph[i][candidate]) {
			return true;
		}
	}
	return false;
}

string make_candidate_name(void) {
	return (string)box(MAX_CANDIDATE_NAME * sizeof(char));
}

string read_candidate_name(string out_name, const string prompt) {
	if (prompt) {
		fputs(prompt, stdout);
	}

	get_str_input(out_name, MAX_CANDIDATE_NAME);
	return out_name;
}

uint32_t read_voter_count(const string prompt) {
	if (prompt) {
		fputs(prompt, stdout);
	}

	return (uint32_t)get_int_input();
}

/// common body
void get_str_input(string out_str, size_t size) {
	do {
		*out_str = '\0';
		char* result = fgets(out_str, size, stdin);

		if (result == NULL) {
			while (fgetc(stdin) != '\n');
		}
	} while (empty_str(out_str) || *out_str == '\n');

	size_t len = strlen(out_str);
	if (out_str[len - 1] == '\n' || out_str[len - 1] == '\r') {
		out_str[len - 1] = '\0';
	}
}

int get_int_input(void) {
	int value = 0;
	int result = scanf("%d", &value);

	if (result == EOF) {
		exit(EXIT_ERROR_FILE_STREAM);
	} else if (result == 0) {
		while (fgetc(stdin) != '\n');
	}

	return value;
}

bool empty_str(const string str) {
	return *str == '\0';
}

void* box(size_t size) {
	void* ptr = malloc(size);
	if (!ptr) {
		exit(EXIT_ERROR_MEM);
	}
	return ptr;
}

void init_zero(void* ptr, size_t size) {
	memset(ptr, 0, size);
}

/// array body
void array_push(
	void* arr,
	size_t* count,
	const void* item,
	const size_t item_size
) {
	memcpy(arr + *count, item, item_size);
	*count += 1;
}

void* array_pop(void* arr, size_t* count) {
	void* last = array_last(arr, *count);
	*count -= 1;
	return last;
}

void* array_last(const void* arr, const size_t count) {
	return (void*)(arr + count - 1);
}
