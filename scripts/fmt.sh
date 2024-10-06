#!/usr/bin/env bash

set -e;

CSOURCE_EXT='.c';
CHEADER_EXT='.h';

SRC_PATH='.';

SRC_HFILE=$(find $SRC_PATH -name "*$CSOURCE_EXT");
SRC_CFILE=$(find $SRC_PATH -name "*$CSOURCE_EXT");

clang-format -i $SRC_HFILE $SRC_CFILE;
