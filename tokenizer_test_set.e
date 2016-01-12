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
			testing:
				"covers/{TOKENIZER}.tokenize",
				"covers/{TOKENIZER}.random_a_to_z_as_lower_with_exception",
				"covers/{TOKENIZER}.random_a_to_z_as_upper_with_exception"
		local
			l_tokenizer: TOKENIZER
		do
			create l_tokenizer
			assert_strings_not_equal ("tokenized", "LARRY", l_tokenizer.tokenize ("LARRY"))
		end

end


