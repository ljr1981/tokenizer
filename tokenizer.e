note
	description: "Summary description for {TOKENIZER}."
	EIS: "src=https://en.wikipedia.org/wiki/Tokenization_(data_security)"
	EIS: "src=http://www.informationlife.net/considerations-using-tokenization-mask-your-sensitive-data/"
	EIS: "src=http://blog.shift4.com/2013/09/tokenization-is-encryption-not-part-4.html"

class
	TOKENIZER

feature -- Access

feature -- Basic Operations

	tokenize (a_string: STRING): STRING
			-- `tokenize' `a_string' into a Result.
		note
			term: "token", "A random value not mathematically related to the PAN, used as a reference to the sensitive data it is protecting"
			term: "PAN", "Primary Account Number"
		do
			create Result.make_empty
		end

end
