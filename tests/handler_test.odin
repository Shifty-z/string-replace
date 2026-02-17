package tests

import "../string_replace"
import "core:testing"
import "core:fmt"

@(test)
replace_single_letter_multiple_times :: proc (t: ^testing.T) {
	result := string_replace.process("bingo bango bongo", "o", "a")
	defer delete(result)

	testing.expectf(t, result == "binga banga banga",
	"Result was: %s", result)
}

@(test)
replace_single_phrase_once :: proc (t: ^testing.T) {
	result := string_replace.process("bingo bango bongo", "in", "IN")
	defer delete(result)

	testing.expectf(t, result == "bINgo bango bongo",
	"Result was: %s", result)
}

@(test)
replacement_longer_than_input :: proc (t: ^testing.T) {
	result := string_replace.process("in", "in", "bingo was his name")
	defer delete(result)

	testing.expectf(t, result == "bingo was his name",
	"Result was: %s", result)
}

@(test)
to_replace_longer_than_input :: proc (t: ^testing.T) {
	result := string_replace.process("in", "inn", "bingo was his name")
	defer delete(result)

	testing.expectf(t, result == "",
	"Result was: >%s< (an empty string)", result)
}

@(test)
to_replace_not_found_in_input :: proc (t: ^testing.T) {
	result := string_replace.process("You should do your homework",
	"not", "always")
	defer delete(result)

	testing.expectf(t, result == "",
	"Result was: >%s< (an empty string", result)
}

@(test)
to_replace_single_char_with_emoji :: proc (t: ^testing.T) {
	result := string_replace.process("You should work for Democracy.",
	"Y", "🫵")
	defer delete(result)

	testing.expectf(t, result == "🫵ou should work for Democracy.",
	"Result was: %s", result)
}

@(test)
to_replace_word_with_emoji :: proc (t: ^testing.T) {
	result := string_replace.process("You should work for Democracy.",
	"You", "🫵")
	defer delete(result)

	testing.expectf(t, result == "🫵 should work for Democracy.",
	"Result was: %s", result)
}

@(test)
to_replace_space_with_hypens :: proc (t: ^testing.T) {
	result := string_replace.process("Do it for Freedom.", " ", "-")
	defer delete(result)

	testing.expectf(t, result == "Do-it-for-Freedom.",
	"Result was: %s", result)
}

@(test)
to_replace_emoji_with_character :: proc (t: ^testing.T) {
	result := string_replace.process("🆓dom", "🆓", "f")
	defer delete(result)

	testing.expectf(t, result == "fdom",
	"Result was: %s", result)
}

@(test)
to_replace_emoji_with_another_emoji :: proc (t: ^testing.T) {
	result := string_replace.process("That's a 🐦‍⬛", "🐦‍⬛", "🦅")
	defer delete(result)

	testing.expectf(t, result == "That's a 🦅",
	"Result was: %s", result)
}