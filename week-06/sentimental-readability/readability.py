from typing import Final


TEXT_SIZE: Final = 4096
WORD_SEPARATOR: Final = ' '


def main():
	text = input("Text: ")

	letters = count_letters(text)
	words = count_words(text)
	sentences = count_sentences(text)

	letter_avg = (letters / words) * 100.0
	sentence_avg = (sentences / words) * 100.0
	score = readability_score(letter_avg, sentence_avg)

	grade: int = round(score)
	show_grade(grade)


def count_letters(text: str) -> int:
	count: int = 0
	
	for ch in text:
		if ch.isalpha():
			count += 1
	
	return count


def count_words(text: str) -> int:
	count: int = 0

	previous_separator: bool = text[0] == WORD_SEPARATOR;
	if not previous_separator:
		count += 1

	for ch in text:
		if (ch == WORD_SEPARATOR):
			previous_separator = True
		elif (previous_separator):
			count += 1
			previous_separator = False

	return count


def count_sentences(text: str) -> int:
	count: int = 0

	for ch in text:
		if is_sentence_terminator(ch):
			count += 1
	
	return count


def is_sentence_terminator(ch: str) -> bool:
	return ch == '.' or ch == '!' or ch == '?'


def show_grade(grade: int):
	if grade >= 16:
		print("Grade 16+")
	elif (grade < 1):
		print("Before Grade 1")
	else:
		print("Grade %i\n", grade)


def readability_score(letter_avg: float, sentence_avg: float) -> float:
	return 0.0588 * letter_avg - 0.296 * sentence_avg - 15.8


if __name__ == "__main__":
	main()
