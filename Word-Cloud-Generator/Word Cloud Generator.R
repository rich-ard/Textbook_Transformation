# Make sure necessary R packages are installed; if not, do so, and load 'em,
# and wipe variables
packages <- c("tm", "tools", "tcltk", "wordcloud2", "SnowballC")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))
}
library(tm)
library(tools)
library(tcltk)
library(wordcloud2)
library(SnowballC)
rm(list=ls(all=TRUE))

# Select the directory where you've stored text files to be converted to a word cloud
print("Select the directory where you've stored your .txt file:")
setwd(tclvalue(tkchooseDirectory()))
pathname <- getwd()

# Clean corpus - kudos to http://antonio-ferraro.eu.pn/word-clouds-in-r-packages-wordcloud2-and-tm/
cleanCorpus <- function(corpus.tmp){
  corpus.tmp <- tm_map(corpus.tmp, removePunctuation)
  corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
  corpus.tmp <- tm_map(corpus.tmp, tolower)
  corpus.tmp <- tm_map(corpus.tmp, PlainTextDocument)
  corpus.tmp.copy <- corpus.tmp
  corpus.tmp <- tm_map(corpus.tmp, removeWords, c("the", "this", stopwords("english")))
  corpus.tmp <- tm_map(corpus.tmp, stemDocument)
  
  # See below for this function; 'stemCompletion' in the current version of
  # the 'tm' package (6.02) isn't working correctly. More info here:
  # http://stackoverflow.com/questions/26204656/multiple-results-of-one-variable-when-applying-tm-method-stemcompletion/26696490#26696490
  corpus.tmp <- tm_map(corpus.tmp, stemCompletionThatWorks,corpus.tmp.copy)
  
  return(corpus.tmp)
}

# stemCompletion() replacement
stemCompletionThatWorks <- function(corpus, dict){
  PlainTextDocument(stripWhitespace(paste(stemCompletion(unlist(strsplit(as.character(corpus), " ")), dictionary = dict, type = "shortest"), sep = "", collapse = " ")))
}

# Build Term Document Matrix (TDM)
generateTDM <- function(path){
  s.dir <-path
  s.cor <-Corpus(DirSource(directory = s.dir, encoding= "UTF-8"))
  s.cor.cl <- cleanCorpus(s.cor)
  s.tdm <- TermDocumentMatrix(s.cor.cl)
  s.tdm
}

# Get TDM
TDM <- generateTDM(pathname)
TDMasMatrix <- as.matrix(TDM)
TDMasDF <- data.frame(TDMasMatrix)
colnames(TDMasDF) <- c("freq", "word")
TDMasDF$word <- as.factor(rownames(TDMasDF))
TDMasDF <- TDMasDF[order(-TDMasDF$freq),]
TDMasDF <- TDMasDF[, c("word", "freq")]

# In some cases, the corpus returns a word/freq pair in which freq=0, which
# throws wordcloud2 for a loop. So those have to go:
count <- 1
for (i in TDMasDF[,1]){
  if (TDMasDF[count,2] == 0){
    TDMasDF <- TDMasDF[-count,]
  }
  count <- count + 1
}

# Produce the word cloud - remember, if there's an image, it needs to be
# a black mask of the shape you want filled.
# mask.filepath <- "C:/Users/Rtbran/Downloads/leaf.gif"
# wordcloud2(TDMasDF, figPath=mask.filepath, size =.4, color='random-dark')

# Play with the wordcloud() settings, there's a lot that can be done visually
wordcloud2(TDMasDF, size=.8, color = 'random-dark')