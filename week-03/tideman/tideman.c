#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <stdio.h>

#include "../../lib/common.h"
#include "../../lib/array.h"

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
	uint8_t winner;
	/**
	 * Candidate index of the loser of this pair
	 */
	uint8_t loser;
	/**
	 * Number of voters that preferrend this pair
	 */
	uint32_t winner_strength;
} pair_t;

// Function prototypes
uint8_t validade_args(
	int argc,
	const string argv[],
	string out_candidates[MAX_CANDIDATES]
);
void init_winning_graph(bool locked[MAX_CANDIDATES][MAX_CANDIDATES]);
void init_preferences_graph(uint32_t preferences[MAX_CANDIDATES][MAX_CANDIDATES]
);
void take_preferences(
	uint32_t voter_count,
	uint8_t candidate_count,
	const string candidates[MAX_CANDIDATES],
	uint32_t out_preferences[MAX_CANDIDATES][MAX_CANDIDATES]
);

bool vote(
	const string name,
	const string candidates[],
	uint8_t candidate_count,
	uint8_t* out_vote
);
void record_preferences(
	uint32_t preferences[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t ranks[],
	const uint8_t candidate_count
);
bool is_preference_tie(
	const uint32_t preferences[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_a,
	const uint8_t candidate_b
);
bool is_preferred_candidate(
	const uint32_t preferences[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_a,
	const uint8_t candidate_b
);
uint8_t fill_pairs(
	pair_t pairs[PAIR_CAPACITY],
	const uint32_t preferences[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_count
);
void sort_pairs(pair_t pairs[PAIR_CAPACITY], const uint8_t pair_count);
int32_t cmp_pair(const pair_t* pair_a, const pair_t* pair_b);
void print_pair(const pair_t pair, FILE* stream);
void graph_pairs(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const pair_t pairs[PAIR_CAPACITY],
	const uint8_t pair_count,
	const uint8_t candidate_count
);
bool winning_graph_has_cycle(
	const bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_count
);
int32_t get_winner(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_count
);
bool won_over_some(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate,
	const uint8_t candidate_count
);
bool lose_over_some(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate,
	const uint8_t candidate_count
);

string make_candidate_name(void);
string read_candidate_name(string out_name, const string prompt);
uint32_t read_voter_count(const string prompt);

int main(int argc, string argv[]) {
	// Array of candidates
	string candidates[MAX_CANDIDATES] = {""};
	// preferences[i][j] is number of voters who prefer i over j
	uint32_t preferences[MAX_CANDIDATES][MAX_CANDIDATES] = {{0}};
	pair_t pairs[PAIR_CAPACITY];
	// locked[i][j] means i is locked in over j
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES] = {{false}};

	const uint8_t candidate_count = validade_args(argc, argv, candidates);

	const uint32_t voter_count = read_voter_count("Number of voters: ");
	take_preferences(voter_count, candidate_count, candidates, preferences);

	const uint32_t pair_count = fill_pairs(pairs, preferences, candidate_count);
	sort_pairs(pairs, pair_count);

	graph_pairs(winning_graph, pairs, pair_count, candidate_count);

	int32_t winner = get_winner(winning_graph, candidate_count);
	if (winner < 0) {
		return EXIT_ERROR_NO_WINNER;
	}

	puts(candidates[winner]);
	return 0;
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

	uint8_t candidate_count = argc - 1;
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

void init_winning_graph(bool locked[MAX_CANDIDATES][MAX_CANDIDATES]) {
	// Clear graph of locked in pairs
	for (int i = 0; i < MAX_CANDIDATES; i++) {
		init_zero((bool*)locked[i], MAX_CANDIDATES);
	}
}

void init_preferences_graph(uint32_t preferences[MAX_CANDIDATES][MAX_CANDIDATES]
) {
	// Clear graph of locked in pairs
	for (int i = 0; i < MAX_CANDIDATES; i++) {
		init_zero((uint32_t*)preferences[i], MAX_CANDIDATES);
	}
}

void take_preferences(
	const uint32_t voter_count,
	const uint8_t candidate_count,
	const string candidates[MAX_CANDIDATES],
	uint32_t out_preferences[MAX_CANDIDATES][MAX_CANDIDATES]
) {
	// A rank by the voter preference
	// Stores the candidate index
	uint8_t* ranks = (uint8_t*)box(candidate_count * sizeof(uint8_t));
	string name = make_candidate_name();

	// Query for votes
	for (uint32_t i = 0; i < voter_count; i++) {
		// Query for each rank
		for (uint8_t rank = 0; rank < candidate_count; rank++) {
			printf("Rank %i: ", rank + 1);
			read_candidate_name(name, NULL);

			if (!vote(name, candidates, candidate_count, &ranks[rank])) {
				printf("Invalid vote.\n");
				exit(EXIT_ERROR_INVALID_VOTE);
			}
		}

		record_preferences(out_preferences, ranks, candidate_count);
		printf("\n");
	}

	free(name);
	free(ranks);
}

// Update ranks given a new vote
bool vote(
	const string name,
	const string candidates[],
	const uint8_t candidate_count,
	uint8_t* out_vote
) {
	for (uint8_t idx = 0; idx < candidate_count; idx++) {
		if (strcmp(candidates[idx], name) == 0) {
			*out_vote = idx;
			return true;
		}
	}

	return false;
}

// Update preferences given one voter's ranks
void record_preferences(
	uint32_t preferences[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t ranks[],
	const uint8_t candidate_count
) {
	for (uint8_t up_rank = 0; up_rank < candidate_count; up_rank++) {
		uint8_t low_rank_start = up_rank + 1;
		for (uint8_t low_rank = low_rank_start; low_rank < candidate_count;
				 low_rank++) {
			preferences[ranks[up_rank]][ranks[low_rank]] += 1;
		}
	}
}

bool is_preference_tie(
	const uint32_t preferences[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_a,
	const uint8_t candidate_b
) {
	return preferences[candidate_a][candidate_b] ==
		preferences[candidate_b][candidate_a];
}

bool is_preferred_candidate(
	const uint32_t preferences[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_a,
	const uint8_t candidate_b
) {
	return preferences[candidate_a][candidate_b] >
		preferences[candidate_b][candidate_a];
}

// Record pairs of candidates where one is preferred over the other
uint8_t fill_pairs(
	pair_t pairs[PAIR_CAPACITY],
	const uint32_t preferences[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_count
) {
	uint8_t count = 0;

	for (uint8_t cand_a = 0; cand_a < candidate_count; cand_a++) {
		for (uint8_t cand_b = 0; cand_b < candidate_count; cand_b++) {
			const uint32_t votes = preferences[cand_a][cand_b];
			if (is_preferred_candidate(preferences, cand_a, cand_b)) {
				pairs[count] =
					(pair_t){.winner = cand_a, .loser = cand_b, .winner_strength = votes};
				count += 1;
			}
		}
	}

	return count;
}

static int32_t cmp_pair_blank_des(const void* pair_a, const void* pair_b) {
	return cmp_pair((pair_t*)pair_b, (pair_t*)pair_a);
}

// Sort pairs in decreasing order by the winner strength
void sort_pairs(pair_t pairs[PAIR_CAPACITY], const uint8_t pair_count) {
	qsort(pairs, pair_count, sizeof(pair_t), cmp_pair_blank_des);
}

int32_t cmp_pair(const pair_t* pair_a, const pair_t* pair_b) {
	return (int32_t)pair_a->winner_strength - (int32_t)pair_b->winner_strength;
}

void print_pair(const pair_t pair, FILE* stream) {
	fprintf(
		stream,
		"pair {.winner = %hhu, .loser = %hhu, .winner_strength = %u}",
		pair.winner,
		pair.loser,
		pair.winner_strength
	);
}

// Lock pairs into the candidate graph in order, without creating cycles
void graph_pairs(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const pair_t pairs[PAIR_CAPACITY],
	const uint8_t pair_count,
	const uint8_t candidate_count
) {
	for (uint8_t i = 0; i < pair_count; i++) {
		const pair_t pair = pairs[i];
		winning_graph[pair.winner][pair.loser] = true;
		if (winning_graph_has_cycle(winning_graph, candidate_count)) {
			winning_graph[pair.winner][pair.loser] = false;
			continue;
		}
	}
}

bool winning_graph_has_cycle(
	const bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate_count
) {
	const size_t size = sizeof(bool) * candidate_count;
	bool* visited = box(size);
	init_zero(visited, size);
	bool* on_stack = box(size);
	init_zero(on_stack, size);

	uint8_t* stack = box(sizeof(uint8_t) * MAX_CANDIDATES);
	size_t stack_count = 0;

	for (uint8_t w = 0; w < candidate_count; w++) {
		if (visited[w]) {
			continue;
		}

		array_push(stack, &stack_count, &w, sizeof(uint8_t));

		while (stack_count != 0) {
			uint8_t top = *(uint8_t*)array_last(stack, stack_count, sizeof(uint8_t));

			if (!visited[top]) {
				visited[top] = true;
				on_stack[top] = true;
			} else {
				on_stack[top] = false;
				array_pop(stack, &stack_count, sizeof(uint8_t));
			}

			for (uint8_t i = 0; i < candidate_count; i++) {
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
	const uint8_t candidate_count
) {
	for (uint8_t canidate = 0; canidate < candidate_count; canidate++) {
		if (won_over_some(winning_graph, canidate, candidate_count) &&
				!lose_over_some(winning_graph, canidate, candidate_count)) {
			return canidate;
		}
	}

	return -1;
}

bool won_over_some(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate,
	const uint8_t canidate_count
) {
	for (uint8_t i = 0; i < canidate_count; i++) {
		if (winning_graph[candidate][i]) {
			return true;
		}
	}
	return false;
}

bool lose_over_some(
	bool winning_graph[MAX_CANDIDATES][MAX_CANDIDATES],
	const uint8_t candidate,
	const uint8_t canidate_count
) {
	for (uint8_t i = 0; i < canidate_count; i++) {
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
