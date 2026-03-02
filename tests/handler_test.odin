package tests

import "../string_replace"
import "core:testing"
import "core:fmt"

@(test)
replace_single_letter_multiple_times :: proc (t: ^testing.T) {
	input := "bingo bango bongo"
	to_replace := "o"
	replacement := "a"
	skip_count := 0
	expected_result := "binga banga banga"

	result := string_replace.process(input, to_replace, replacement, 0)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: %s", result)
}

@(test)
replace_single_phrase_once :: proc (t: ^testing.T) {
	input := "bingo bango bongo"
	to_replace := "in"
	replacement := "IN"
	skip_count := 0
	expected_result := "bINgo bango bongo"

	result := string_replace.process(input, to_replace, replacement, skip_count)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: %s", result)
}

@(test)
replacement_longer_than_input :: proc (t: ^testing.T) {
	input := "in"
	to_replace := "in"
	replacement := "bingo was his name"
	skip_count := 0
	expected_result := "bingo was his name"

	result := string_replace.process(input, to_replace, replacement, skip_count)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: %s", result)
}

@(test)
to_replace_longer_than_input :: proc (t: ^testing.T) {
	input := "in"
	to_replace := "inn"
	replacement := "bingo was his name"
	skip_count := 0
	expected_result := ""

	result := string_replace.process(input, to_replace, replacement, skip_count)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: >%s< (an empty string)", result)
}

@(test)
to_replace_not_found_in_input :: proc (t: ^testing.T) {
	input := "You should do your homework"
	to_replace := "not"
	replacement := "always"
	skip_count := 0
	expected_result := ""

	result := string_replace.process(input, to_replace, replacement, skip_count)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: >%s< (an empty string", result)
}

@(test)
to_replace_single_char_with_emoji :: proc (t: ^testing.T) {
	input := "You should work for Democracy."
	to_replace := "Y"
	replacement := "🫵"
	skip_count := 0
	expected_result := "🫵ou should work for Democracy."

	result := string_replace.process(input, to_replace, replacement, skip_count)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: %s", result)
}

@(test)
to_replace_word_with_emoji :: proc (t: ^testing.T) {
	input := "You should work for Democracy."
	to_replace := "You"
	replacement := "🫵"
	skip_count := 0
	expected_result := "🫵 should work for Democracy."

	result := string_replace.process(input, to_replace, replacement, skip_count)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: %s", result)
}

@(test)
to_replace_space_with_hypens :: proc (t: ^testing.T) {
	input := "Do it for Freedom."
	to_replace := " "
	replacement := "-"
	skip_count := 0
	expected_result := "Do-it-for-Freedom."

	result := string_replace.process(input, to_replace, replacement, skip_count)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: %s", result)
}

@(test)
to_replace_emoji_with_character :: proc (t: ^testing.T) {
	input := "🆓dom"
	to_replace := "🆓"
	replacement := "f"
	skip_count := 0
	expected_result := "fdom"

	result := string_replace.process(input, to_replace, replacement, skip_count)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: %s", result)
}

@(test)
to_replace_emoji_with_another_emoji :: proc (t: ^testing.T) {
	input := "That's a 🐦‍⬛"
	to_replace := "🐦‍⬛"
	replacement := "🦅"
	skip_count := 0
	expected_result := "That's a 🦅"

	result := string_replace.process(input, to_replace, replacement, skip_count)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: %s", result)
}

// NOTE: Token is just an instance of to_replace.
@(test)
to_replace_should_skip_one_token :: proc (t: ^testing.T) {
	input := "Return, refit, and redeploy to purge the stain of this failure with the peroxide of victory"
	to_replace := " "
	replacement := "-"
	skip_count := 1
	expected_result := "Return, refit,-and-redeploy-to-purge-the-stain-of-this-failure-with-the-peroxide-of-victory"

	result := string_replace.process(input, to_replace, replacement, skip_count)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: %s", result)
}

@(test)
to_replace_should_skip_multiple_tokens :: proc (t: ^testing.T) {
	input := "Return, refit, and redeploy to purge the stain of this failure with the peroxide of victory"
	to_replace := " "
	replacement := "-"
	skip_count := 5
	expected_result := "Return, refit, and redeploy to purge-the-stain-of-this-failure-with-the-peroxide-of-victory"

	result := string_replace.process(input, to_replace, replacement, skip_count)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: %s", result)
}

@(test)
to_replace_given_more_tokens_to_skip_than_possible :: proc (t: ^testing.T) {
	input := "Return, refit, and redeploy to purge the stain of this failure with the peroxide of victory"
	to_replace := " "
	replacement := "-"
	skip_count := 26
	expected_result := "Return, refit, and redeploy to purge the stain of this failure with the peroxide of victory"

	result := string_replace.process(input, to_replace, replacement, skip_count)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: %s", result)
}

// Added this because you swapped from builder_make to builder_make_len_cap
// and you wanted to make sure your code didn't cause problems defaulting
// capacity to the length of input.
@(test)
to_replace_input_length_grows :: proc (t: ^testing.T) {
	input := "Return, refit, and redeploy"
	to_replace := "r"
	replacement := "purple"
	skip_count := 0
	expected_result := "Retupurplen, purpleefit, and purpleedeploy"

	result := string_replace.process(input, to_replace, replacement, skip_count)
	defer delete(result)

	testing.expectf(t, result == expected_result,
	"Result was: %s", result)
}