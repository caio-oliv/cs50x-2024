#!/usr/bin/env bash

set -e;

build_script='./scripts/build.sh';

eval $build_script w1 credit;
eval $build_script w1 mario-more;
eval $build_script w1 me;
eval $build_script w1 world;

eval $build_script w2 readability;
eval $build_script w2 scrabble;
eval $build_script w2 substitution;

eval $build_script w3 plurality;
eval $build_script w3 tideman;

eval $build_script w4 filter-more;
eval $build_script w4 recover;
eval $build_script w4 volume;
