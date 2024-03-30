#!/usr/bin/env bash

set -e;

clang --stdlib=c11 'scrabble.c' -o 'scrabble';
