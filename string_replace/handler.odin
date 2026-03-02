package string_replace

import "core:strings"

process :: proc (input, to_replace, replacement: string, skip_count: int) -> string {
	if !strings.contains(input, to_replace) {
		return ""
	}

	// Length of input is likely a decent size to start with
	replaced := strings.builder_make_len_cap(0, len(input))

	// The number of to_replace elements we've skipped
	tokens_skipped := 0

	// Iterating over bytes rather than runes seems like a more natural
	// choice in this case
	for i := 0; i < len(input); i += 1 {
		current_byte := input[i]

		// Current character is not the start of your replacement
		// window. Put what you have
		if current_byte != to_replace[0] {
			strings.write_byte(&replaced, current_byte)
			continue
		}

		// This is a sliding window. See if i to length of to_replace
		// in `input_window` is something you need to change.
		input_window := input[i: i + len(to_replace)]
		found_match := input_window == to_replace
		should_skip := tokens_skipped < skip_count

		if found_match && should_skip {
			tokens_skipped += 1
			strings.write_byte(&replaced, current_byte)
			continue
		}

		if found_match && !should_skip{
			i += len(to_replace) - 1
			strings.write_string(&replaced, replacement)
			continue
		}

		strings.write_byte(&replaced, current_byte)
	}

	return strings.to_string(replaced)
}