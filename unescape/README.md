# unescape
## R function to correct XML/HTML character encoding

This is a function that uses the 'xml2' package to unescape XML and HTML character encoding (e.g. '&gt;' renders in HTML as '>', '&amp;' renders in HTML as '&').

It takes two inputs, as follows:

unescape(input, values)

'input' is a character vector of varied length
'values' is either "xml" or "html" (defaults to "html")

If 'input' or is not a character vector, the script will attempt to convert it to such.

If 'values' is not either "xml" or "html", the script will output the original input with no changes.



Rich - 2.20.17
