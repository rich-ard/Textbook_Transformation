
# Word Cloud Generator

This is a script that uses the 'tm' and 'wordcloud2' R packages to create a word cloud from a text corpus.

You'll need to put text file(s) in a folder, *alone*, then run the script; it will ask for an input folder, and will then read all files inside that folder. If there are images, other scripts, etc. in that folder as well, whatever text R is able to parse from them will appear in your cloud (which can lead to weird results).

This needs to be 'run' rather than 'sourced' as otherwise the final line does not execute, not sure why.

If you want to make graphical changes to the word cloud, check out the wordcloud() help in R - you can use mask images, change colors or sizes, etc. Lots of neat stuff.

Rich - 1.25.17
