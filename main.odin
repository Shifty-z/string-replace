package main

import "string_replace"
import "core:fmt"
import "core:flags"
import "core:os/os2"

ProgramArgs :: struct {
	i: string `flags:"i" usage:"The string to modify."`,
	replace: string `flags:"replace" usage:"What should be replaced."`,
	replacement: string `flags:"replacement" usage:"What should replace 'replace'."`,
	skip_count: int `flags:"skip-count" usage:"Defaults to zero (none). Starting from the left, how many instances of replace should be skipped."`,
}

main :: proc () {
	args := ProgramArgs { }
	parse_err := flags.parse(&args, os2.args[1:])
	if nil != parse_err {
		flags.print_errors(ProgramArgs, parse_err,
		"String Replace - Replaces content in a string." +
		" An quick and easy to use CLI that replaces content in a string.\n" +
		"Example:\n" +
		"string-replace -i:<SOME_LONG_STRING> -replace:'_' -replacement:' ' | pbcopy",
		.Odin)
		os2.exit(1)
	}

	// If any of these are empty, the input is bad.
	if "" == args.i || "" == args.replace || "" == args.replacement {
		fmt.println("`i`, `replace`, or `replacement` were empty." +
		" These values should not be empty.")
		os2.exit(1)
	}

	result := string_replace.process(args.i, args.replace, args.replacement,
	args.skip_count)
	fmt.println(result)
}