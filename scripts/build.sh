#!/usr/bin/env bash

set -e;

CSOURCE_EXT='.c';
CHEADER_EXT='.h';

LIB_PATH="$(pwd)/lib";

LIB_CFILE=$(find $LIB_PATH -name "*$CSOURCE_EXT");
LIB_HFILE=$(find $LIB_PATH -name "*$CHEADER_EXT");

CLANG_FLAGS="-Wall -Werror -Wextra -pedantic -Wno-sign-compare -Wno-unused-parameter"`
	`" -Wno-unused-variable -Wshadow -Qunused-arguments -gdwarf-4 -lm"`
	`" --include-directory $LIB_PATH";

OUT_DIR='out';


function filter_flags {
	local extra_flags="";

	for arg in "$@"; do
		if [[ $arg == -* ]]; then
			extra_flags="$extra_flags $arg";
		fi
	done

	echo -n $extra_flags;
}

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
		case $2 in
			'filter-more')
				check_program $week 'filter-more' 'filter';
				;;
			*)
				check_program $week $2 $2;
				;;
		esac
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

prog_main_file="$week/$directory/$program.c";
prog_c_files=$(find "$week/$directory" -name "*$CSOURCE_EXT" -not -wholename $prog_main_file);

extra_flags=$(filter_flags $@);

mkdir -p $OUT_DIR;

clang --stdlib=c17 $CLANG_FLAGS $extra_flags \
	$prog_main_file \
	$LIB_CFILE $prog_c_files \
	-o "$OUT_DIR/$program";
