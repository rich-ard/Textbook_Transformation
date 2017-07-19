# String Trimmer

This is a function that uses the 'stringr' R package to remove characters which appear at the beginning or end of a character vector.

It takes three inputs, as follows:

trimwords(input, chars_to_lose, string_position)

'input' is a character vector of varied length
'chars_to_lose' is a character vector of length 1
'string_position' is either "end" or "beginning" (defaults to "beginning").

If 'input' or 'chars_to_lose' are not character vectors, the script will output the original input.

If 'chars_to_lose' is a vector of length > 1, the script will output the original input.

This will remove single instances of 'chars_to_lose', so:

 trimwords(input="Kittens Kittens Kittens!", chars_to_lose="Kittens")

...returns:

 Kittens Kittens!

It is also character-specific, so:

 trimwords(input="Hats Hats Hats!", chars_to_lose="Hats", string_position="end")

...returns

 Hats Hats Hats!

...as the exclamation point at the end of the input string results in the final "Hats" not being removed. Instead,

 trimwords(input="Hats Hats Hats!", chars_to_lose="Hats!", string_position="end")

...returns

 Hats Hats



Rich - 2.15.17
