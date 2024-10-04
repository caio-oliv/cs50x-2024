#!/usr/bin/env bash

set -e;

CSOURCE_EXT='.c';
CHEADER_EXT='.h';

LIB_PATH='../../lib';

LIB_CFILE=$(find $LIB_PATH -name "*$CSOURCE_EXT");
LIB_HFILE=$(find $LIB_PATH -name "*$CHEADER_EXT");

CLANG_FLAGS='-Wall -Wextra -pedantic';

clang --stdlib=c17 $CLANG_FLAGS "$@" 'tideman.c' $LIB_CFILE -o 'tideman';
