package string_replace

import "core:strings"

process :: proc (input, to_replace, replacement: string) -> string {
	if !strings.contains(input, to_replace) {
		return ""
	}


	replaced := strings.builder_make()

	// Iterating over bytes rather than runes seems like a more natural
	// choice in this case
	for i := 0; i < len(input); i += 1 {
	// Current character is not the start of your replacement
	// window. Replace what you have.
		if input[i] != to_replace[0] {
			strings.write_byte(&replaced, input[i])
			continue
		}

		// This is a sliding window. See if i to length of to_replace
		// in `input_window` is something you need to change.
		// If so, append `replacement`. If not, write a byte
		input_window := input[i: i + len(to_replace)]
		if input_window == to_replace {
			i += len(to_replace) - 1
			strings.write_string(&replaced, replacement)
			continue
		}

		strings.write_byte(&replaced, input[i])
	}

	return strings.to_string(replaced)
}