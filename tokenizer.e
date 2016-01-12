note
	description: "Summary description for {TOKENIZER}."
	synopsis: "[
		The idea is that this class lives in a tokenizer within a vault.
		The vault is operating as a separate service with its own database.
		The client calls the tokenizer within the value, passing it a value
		and pattern to be tokenized. The vault returns the token. When the
		client wants the plain-text (vs. tokenized text) back, it:
		
		(a) logs into the vault (auth access only)
		(b) calls the detokenizer, passing the token
		(c) receives the plain-text (possibly encrypted) result
		
		In this way, the vault is:
		
		(a) the sole responsible party for tokenizing
		(b) the sole keeper-of-the-keys in changing tokens-to-plain-text
		
		This class represents only the tokenizing part of the use-case.
		The vault, storage of tokens, and token management is a separate
		matter completely.
		]"
	EIS: "src=https://en.wikipedia.org/wiki/Tokenization_(data_security)"
	EIS: "src=http://www.informationlife.net/considerations-using-tokenization-mask-your-sensitive-data/"
	EIS: "src=http://blog.shift4.com/2013/09/tokenization-is-encryption-not-part-4.html"
	todo: "[
		(1) Add tokenization of:
			(a) digits-only
			(b) alphanumeric
			(c) other variants
		(2) Add tokenizing patterns based on regex
			Example: In a 16-digit credit card number, leave 
						certain original numbers alone (do not 
						tokenize them)
		]"

class
	TOKENIZER

feature -- Access

feature -- Basic Operations

	tokenize_alpha_only (a_string: STRING): STRING
			-- Perform `tokenize' of `a_string'.
		note
			term: "token", "A random value not mathematically related to the PAN, used as a reference to the sensitive data it is protecting"
			term: "PAN", "Primary Account Number"
		require
			alpha_only: across a_string as ic_string some alphabet_lower.has (ic_string.item.as_lower) end
		do
			create Result.make_empty
			across
				a_string as ic_string
			loop
				if ic_string.item.is_upper then
					Result.append_character (random_a_to_z_as_upper_with_exception (ic_string.item))
				else
					Result.append_character (random_a_to_z_as_lower_with_exception (ic_string.item))
				end
			end
		ensure
			same_size: a_string.count = Result.count
		end

feature {NONE} -- Implementation

	random_vowel: CHARACTER
			-- A `random_vowel'.
		do
			Result := random_character (alpha_vowels)
		end

	random_consodent: CHARACTER
			-- A `random_consodent'.
		do
			Result := random_character (alpha_consonents)
		end

	random_digit: CHARACTER
			-- A `random_digit'.
		do
			Result := random_character (digits)
		end

	random_digit_with_exception (a_exception: CHARACTER): CHARACTER
			-- A `random_digit_with_exception' of `a_exception' removed.
		require
			in_digits: digits.has (a_exception)
		do
			Result := random_character (string_with_exception_removed (digits, a_exception))
		end

	random_a_to_z_as_upper: CHARACTER
			-- A `random_a_to_z_as_upper' character.
		do
			Result := random_a_to_z_as_lower.as_upper
		end

	random_a_to_z_as_upper_with_exception (a_exception: CHARACTER): CHARACTER
			-- A `random_a_to_z_as_upper' character.
		do
			Result := random_a_to_z_as_lower_with_exception (a_exception.as_lower).as_upper
		end

	random_a_to_z_as_lower: CHARACTER
			-- A `random_a_to_z_as_lower' character.
		do
			Result := random_character (alphabet_lower)
		end

	random_a_to_z_as_lower_with_exception (a_exception: CHARACTER): CHARACTER
			-- A `random_a_to_z_as_lower' character.
		do
			Result := random_character (string_with_exception_removed (alphabet_lower, a_exception.as_lower))
		end

	random_character (a_string: STRING): CHARACTER
			-- A `random_character' from `a_string'.
		do
			Result := a_string [random_in_range (1 |..| a_string.count)]
		end

	random_in_range (a_range: INTEGER_INTERVAL): INTEGER
			-- A `random_in_range' of `a_range'.
		do
			Result := new_random \\ (a_range.upper - a_range.lower) + 1 + a_range.lower
		end

	new_random: INTEGER
			-- Random integer
			-- Each call returns another random number.
		do
			random_sequence.forth
			Result := random_sequence.item
		end

	string_with_exception_removed (a_string: STRING; a_exception: CHARACTER): STRING
			-- A `string_with_exception_removed'--as in--`a_exception' removed from `a_string'.
		do
			Result := a_string.twin
			Result.replace_substring_all (a_exception.out, "")
		end

feature -- Constants

	alphabet_lower: STRING = "abcdefghijklmnopqrstuvwxyz"

	alpha_vowels: STRING = "aeiouy"

	alpha_consonents: STRING = "bcdfghjklmnpqrstvwxz"

	digits: STRING = "0123456789"

feature {NONE} -- Implementation

	random_sequence: RANDOM
			-- Random sequence
		local
			l_time: TIME
			l_seed: INTEGER
		once
			-- This computes milliseconds since midnight.
			-- Milliseconds since 1970 would be even better.
			create l_time.make_now
			l_seed := l_time.hour
			l_seed := l_seed * 60 + l_time.minute
			l_seed := l_seed * 60 + l_time.second
			l_seed := l_seed * 1000 + l_time.milli_second
			create Result.set_seed (l_seed)
		end

end
