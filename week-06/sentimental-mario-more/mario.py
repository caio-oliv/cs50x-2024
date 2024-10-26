import sys
from typing import Final

PYRAMID_HEIGHT_MIN: Final = 1
PYRAMID_HEIGHT_MAX: Final = 8
PYRAMID_GAP: Final = 2
PYRAMID_BLOCK: Final = '#'
AIR_BLOCK: Final = ' '

def main():
	height = get_pyramid_height(PYRAMID_HEIGHT_MIN, PYRAMID_HEIGHT_MAX)
	write_pyramid(height)

def get_pyramid_height(min: int, max: int) -> int:
	while True:
		height = input_int("Height: ")
		if not (height < min or height > max):
			break

	return height


def write_pyramid_gap():
	for _ in range(PYRAMID_GAP):
		sys.stdout.write(AIR_BLOCK)


def write_pyramid(height: int):
	#      #  #
	#     ##  ##
	#    ###  ###
	#   ####  ####
	#  #####  #####
	# ######  ######

	for row in range(1, height + 1):
		air1 = height - row
		block1 = height - air1
		block2 = block1

		while (air1):
			sys.stdout.write(AIR_BLOCK)
			air1 -= 1
		while (block1):
			sys.stdout.write(PYRAMID_BLOCK)
			block1 -= 1
		
		write_pyramid_gap()

		while (block2):
			sys.stdout.write(PYRAMID_BLOCK)
			block2 -= 1

		sys.stdout.write('\n')


def input_int(prompt: str = '', err_msg: str = '') -> int:
	while True:
		try:
			return int(input(prompt))
		except ValueError:
			if err_msg != '':
				print(err_msg)


if __name__ == "__main__":
	main()

