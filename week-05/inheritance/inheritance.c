#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#include <time.h>

// Each person has two parents and two alleles
typedef struct person_s {
	struct person_s* parents[2];
	char alleles[2];
} person;

const int GENERATIONS = 3;
const int INDENT_LENGTH = 4;

person* create_family(int generations);
void print_family(person* p, int generation);
void init_person(person* person);
void inherit_parent_alleles(person* person);
void free_family(person* p);
char random_allele(void);
uint32_t rand_max(const uint32_t max);
person* alloc_person(void);

int main(void) {
	// Seed random number generator
	srand(time(0));

	// Create a new family with three generations
	person* p = create_family(GENERATIONS);

	// Print family tree of blood types
	print_family(p, 0);

	// Free memory
	free_family(p);
}

// Create a new individual with `generations`
person* create_family(int generations) {
	person* pers = alloc_person();

	// If there are still generations left to create
	if (generations > 1) {
		// Create two new parents for current person by recursively calling
		// create_family
		person* parent0 = create_family(generations - 1);
		person* parent1 = create_family(generations - 1);

		pers->parents[0] = parent0;
		pers->parents[1] = parent1;

		inherit_parent_alleles(pers);
	}

	// If there are no generations left to create
	else {
		init_person(pers);
	}

	return pers;
}

void init_person(person* pers) {
	pers->parents[0] = NULL;
	pers->parents[1] = NULL;

	pers->alleles[0] = random_allele();
	pers->alleles[1] = random_allele();
}

void inherit_parent_alleles(person* pers) {
	pers->alleles[0] = pers->parents[0]->alleles[rand_max(2)];

	pers->alleles[1] = pers->parents[1]->alleles[rand_max(2)];
}

// Free `p` and all ancestors of `p`.
void free_family(person* pers) {
	if (pers == NULL) {
		return;
	}

	free_family(pers->parents[0]);
	free_family(pers->parents[1]);

	free(pers);
}

// Print each family member and their alleles.
void print_family(person* p, int generation) {
	// Handle base case
	if (p == NULL) {
		return;
	}

	// Print indentation
	for (int i = 0; i < generation * INDENT_LENGTH; i++) {
		printf(" ");
	}

	// Print person
	if (generation == 0) {
		printf(
			"Child (Generation %i): blood type %c%c\n",
			generation,
			p->alleles[0],
			p->alleles[1]
		);
	} else if (generation == 1) {
		printf(
			"Parent (Generation %i): blood type %c%c\n",
			generation,
			p->alleles[0],
			p->alleles[1]
		);
	} else {
		for (int i = 0; i < generation - 2; i++) {
			printf("Great-");
		}
		printf(
			"Grandparent (Generation %i): blood type %c%c\n",
			generation,
			p->alleles[0],
			p->alleles[1]
		);
	}

	// Print parents of current generation
	print_family(p->parents[0], generation + 1);
	print_family(p->parents[1], generation + 1);
}

// Randomly chooses a blood type allele.
char random_allele(void) {
	int r = rand() % 3;
	if (r == 0) {
		return 'A';
	} else if (r == 1) {
		return 'B';
	} else {
		return 'O';
	}
}

uint32_t rand_max(const uint32_t max) {
	return (uint32_t)(rand() % max);
}

person* alloc_person(void) {
	return malloc(sizeof(person));
}
