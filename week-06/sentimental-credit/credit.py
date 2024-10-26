from typing import Final


INPUT_SIZE: Final = 1024

AMERICAN_EXPRESS: Final = "AMEX"
MASTER_CARD: Final = "MASTERCARD"
VISA: Final = "VISA"

def main():
	number = input_int("Number: ")

	if not is_card_number_legit(number):
		print("INVALID\n")
		return 0

	flag = get_card_flag(number)
	if flag is None:
		print("INVALID\n")
		return 0

	print(flag)


def get_card_flag(number: int) -> str | None:
	digit_count = 2
	first_2digit = number
	while (first_2digit > 99):
		first_2digit //= 10
		digit_count += 1

	if (first_2digit == 34 or first_2digit == 37) and digit_count == 15:
		return AMERICAN_EXPRESS
	elif (first_2digit >= 51 and first_2digit <= 55) and digit_count == 16:
		return MASTER_CARD
	elif (first_2digit >= 40 and first_2digit <= 49) and (digit_count == 13 or digit_count == 16):
		return VISA

	return None


def is_card_number_legit(num: int) -> bool:
	mult_by_2: bool = False
	sum: int = 0

	while (num != 0):
		digit = num % 10

		if (mult_by_2):
			product = digit * 2
			sum += (product % 10) + (product // 10)
		else:
			sum += digit

		num //= 10
		mult_by_2 = not mult_by_2

	return (sum % 10) == 0


def input_int(prompt: str = '', err_msg: str = '') -> int:
	while True:
		try:
			return int(input(prompt))
		except ValueError:
			if err_msg != '':
				print(err_msg)


if __name__ == "__main__":
	main()
