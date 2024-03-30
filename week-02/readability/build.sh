#!/usr/bin/env bash

set -e;

clang --stdlib=c11 -lm 'readability.c' -o 'readability';
