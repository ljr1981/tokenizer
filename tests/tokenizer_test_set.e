note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TOKENIZER_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_other
		select
			default_create
		end

	EQA_COMMONLY_USED_ASSERTIONS
		rename
			default_create as default_create_other
		end

feature -- Test routines

	tokenizer_test
			-- Tests of the {TOKENIZER}
		note
			synopsis: "[
				The purpose of this test is to prove that no token of
				`test_plain_text' will ever be the same as `test_plain_text'.
				We ask for a token of the plain text ten thousand times.
				]"
			testing:
				"covers/{TOKENIZER}.tokenize",
				"covers/{TOKENIZER}.random_a_to_z_as_lower_with_exception",
				"covers/{TOKENIZER}.random_a_to_z_as_upper_with_exception"
		local
			l_tokenizer: TOKENIZER
		do
			create l_tokenizer
			across
				1 |..| 10_000 as ic
			loop
				assert_strings_not_equal ("tokenized", test_plain_text, l_tokenizer.tokenize_alpha_only (test_plain_text))
			end
		end

feature {NONE} -- Implementation

	test_plain_text: STRING = "ABC"

end


