#!/bin/sh

# All the vet options I want used. Not sure if the other -vet-unused flags are included
# in the -vet-unused flag?
vet_options='-vet-packages:"string_replace,tests" -vet-unused -vet-shadowing -vet-using-stmt -vet-cast -vet-semicolon -vet-tabs'

odin check main.odin -file ${vet_options}