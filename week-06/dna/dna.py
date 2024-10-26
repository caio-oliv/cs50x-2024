import sys
import csv
from io import TextIOWrapper
from collections.abc import Sequence
from dataclasses import dataclass
from typing import Final

type DNASubSequence = str
type DNASequence = str
type DNAMatches = dict[DNASubSequence, int]

NO_MATCH_MSG: Final = "No match"

@dataclass
class Args:
	csv_database_path: str
	dna_seq_path: str

@dataclass
class DNAMatch:
	name: str
	matches: DNAMatches

def main():
	args = parse_args()

	dna_sequence = read_dna_sequence(args.dna_seq_path)

	with open(args.csv_database_path) as csv_file:
		match_found = find_dna_match(csv_file, dna_sequence)
		if match_found is not None:
			print(match_found.name)
		else:
			print(NO_MATCH_MSG)
	return

def parse_args() -> Args:
	"""Check for command-line usage"""
	if len(sys.argv) != 3:
		print("Usage: dna.py [csv] [DNA sequence]")
		exit(1)
	
	return Args(csv_database_path=sys.argv[1], dna_seq_path=sys.argv[2])

def find_dna_match(csv_file: TextIOWrapper, dna_sequence: DNASequence) -> DNAMatch | None:
	reader = csv.DictReader(csv_file)
	
	matches = init_dna_matches(reader.fieldnames[1:])
	fill_dna_matches(matches, dna_sequence)

	for row in reader:
		all_matches = True
		for subseq in matches:
			if int(row[subseq]) != matches[subseq]:
				all_matches = False
				break
		if all_matches:
			return DNAMatch(name=row["name"], matches=matches)
	return None

def read_dna_sequence(filename: str) -> str:
	"""Read DNA sequence file"""
	with open(filename) as dna_file:
		return dna_file.read()

def init_dna_matches(sequences: Sequence[str]) -> DNAMatches:
	matches: DNAMatches = {}
	for subseq in sequences:
		matches[subseq] = 0
	return matches

def fill_dna_matches(matches: DNAMatches, dna_sequence: DNASequence, ):
	for subseq in matches:
		matches[subseq] = longest_match(dna_sequence, subseq)

def longest_match(sequence: str, subsequence: str) -> int:
	"""Returns length of longest run of subsequence in sequence."""
	longest_run = 0
	subsequence_length = len(subsequence)
	sequence_length = len(sequence)

	# Check each character in sequence for most consecutive runs of subsequence
	for i in range(sequence_length):
		# Initialize count of consecutive runs
		count = 0

		# Check for a subsequence match in a "substring" (a subset of characters) within sequence
		# If a match, move substring to next potential match in sequence
		# Continue moving substring and checking for matches until out of consecutive matches
		while True:
			# Adjust substring start and end
			start = i + count * subsequence_length
			end = start + subsequence_length

			# If there is a match in the substring
			if sequence[start:end] == subsequence:
				count += 1
			
			# If there is no match in the substring
			else:
				break
		
		# Update most consecutive matches found
		longest_run = max(longest_run, count)

	# After checking for runs at each character in seqeuence, return longest run found
	return longest_run

if __name__ == "__main__":
	main()
