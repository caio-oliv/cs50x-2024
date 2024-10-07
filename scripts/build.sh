#!/usr/bin/env bash

set -e;

CSOURCE_EXT='.c';
CHEADER_EXT='.h';

LIB_PATH='lib';

LIB_CFILE=$(find $LIB_PATH -name "*$CSOURCE_EXT");
LIB_HFILE=$(find $LIB_PATH -name "*$CHEADER_EXT");

CLANG_FLAGS='-Wall -Wextra -pedantic';
OUT_DIR='out';


ERROR_USAGE=-1;
ERROR_PROGRAM_NOT_FOUND=-2;

week='noweek';
directory='dir';
program='program';

function check_program {
	if [ -f "$1/$2/$3.c" ]; then
		week=$1;
		directory=$2;
		program=$3;
	else
		echo 'Source code not found';
		exit $ERROR_PROGRAM_NOT_FOUND;
	fi
}

case $1 in
	'w1')
		week='week-01';
		case $2 in
			'credit')
				check_program $week 'credit' 'credit';
				;;
			'mario-more')
				check_program $week 'mario-more' 'mario';
				;;
			'me')
				check_program $week 'me' 'hello';
				;;
			'world')
				check_program $week 'world' 'hello';
				;;
		esac
		;;
	'w2')
		week='week-02';
		check_program $week $2 $2;
		;;
	'w3')
		week='week-03';
		check_program $week $2 $2;
		;;
	'w4')
		week='week-04';
		check_program $week $2 $2;
		;;
	'w5')
		week='week-05';
		check_program $week $2 $2;
		;;
	*)
		echo 'Usage: build.sh <week> <program>';
		exit $ERROR_USAGE;
		;;
esac

mkdir -p $OUT_DIR;
clang --stdlib=c17 $CLANG_FLAGS "$week/$directory/$program.c" $LIB_CFILE -o "$OUT_DIR/$program";
