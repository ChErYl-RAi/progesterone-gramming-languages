#!/bin/bash
gcc neumannlang/neumann.c -o neumannrun.a
./neumannrun.a neumannlang/test.nm .