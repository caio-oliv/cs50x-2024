#!/usr/bin/env bash

set -e;

clang --stdlib=c11 'plurality.c' -o 'plurality';
