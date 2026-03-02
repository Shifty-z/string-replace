#!/bin/sh

# WARNING: This will delete any existing string-replace binaries in the current
# 	directory!
rm -f string-replace

# Nobody wants to remember how to build something, so just run this
# to make a binary. Odin will handle the rest for platforms you care about.
odin build . -o:speed