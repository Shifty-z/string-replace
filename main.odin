package main

import "string_replace"
import "core:fmt"
import "core:flags"
import "core:os/os2"

ProgramArgs :: struct {
	input: string `flags:"input" usage:"The string to modify."`,
	to_replace: string `flags:"replace" usage:"What should be replaced."`,
	replacement: string `flags:"replacer" usage:"What should replace 'replace'."`,
}

main :: proc () {
	args := ProgramArgs { }
	parse_err := flags.parse(&args, os2.args[1:])
	if nil != parse_err {
		flags.print_errors(ProgramArgs, parse_err,
		"String Replace - Replaces content in `input`.",
		.Odin)
	}

	// If any of these are empty, the input is bad.
	if "" == args.input || "" == args.to_replace || "" == args.replacement {
		fmt.println("`input`, `replace`, or `replacer` were empty." +
		" These values should not be empty.")
		os2.exit(1)
	}

	string_replace.process(args.input, args.to_replace, args.replacement)
}