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

inherit
	RANDOMIZER

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
					Result.append_character (random_a_to_z_upper_with_exceptions (ic_string.item.out))
				else
					Result.append_character (random_a_to_z_with_exceptions (ic_string.item.out))
				end
			end
		ensure
			same_size: a_string.count = Result.count
		end

end
