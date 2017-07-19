# This function requires the 'stringr' package be loaded.
# It takes three variables:
# 'input', the character vector to be examined
# 'chars_to_lose', which is the text string to be removed from the beginning or end of the above, as determined by:
# 'string_position', which should be either "beginning" or "end". Default is 'beginning'.

trimwords <-
  function(input,
           chars_to_lose,
           string_position = "beginning"){
    # This is a character vector that will be returned at the end:
    output <- ""
    # ...and a counter variable for use in multiple-string vectors
    count <- 1
    
    
    # If the input is not a character vector,
    # or chars_to_remove is of length > 1, simply skip to the end and return the input
    if (is.character(input)==FALSE |
        is.character(chars_to_lose)==FALSE |
        length(chars_to_lose)>1) {output<-input}
    
    else if (tolower(string_position) == "end") {
      #####################################################################
      # Remove all instances of chars_to_lose at the end of text:
      
      # First, a function that will look for chars_to_lose as the end of a string.
      # If it is the end of the string, it will return the remainder string.
      # Otherwise, it will return an empty character vector.
      StringBeforeRemoveit <- function(foo, bar) {
        trimws(unlist(str_extract_all(
          foo, paste0(
            c(
              "\\w.*\\s.*(?=",
              str_replace_all(bar, "(\\W)", "\\\\\\1"),
              "$)"
            ),
            sep = "",
            collapse = ""
          )
        )))
      }
      
      # Now, if that character vector is empty, the output is the entire original string;
      # otherwise, the output is the remainder string.
      for (i in 1:length(input)){
      if (identical(StringBeforeRemoveit(input[count], chars_to_lose),
                    character(0))){
          output[count]<-input[count]
        } else {
        output[count] <- (StringBeforeRemoveit(input[count], chars_to_lose))
        } 
      count <- count +1
      }
    } else if (tolower(string_position) == "beginning"){
      #####################################################################
      # Remove all instances of chars_to_lose at the beginning of text:
      
      # First, a function that will look for chars_to_lose as the beginning of a string.
      # If it is the beginning of the string, it will return the remainder string.
      # Otherwise, it will return an empty character vector.
      StringAfterRemoveit <- function(foo, bar) {
        trimws(unlist(str_extract_all(
          foo, paste0(
            c("(?<=^", str_replace_all(bar, "(\\W)", "\\\\\\1"), ").*"),
            sep = "",
            collapse = ""
          )
        )))
      }
      
      # Now, if that character vector is empty, the output is the entire original string;
      # otherwise, the output is the remainder string.
      for (i in 1:length(input)){
      if (identical(StringAfterRemoveit(input[count], chars_to_lose),
                    character(0))) {
        output[count]<-input[count]
      } else {
        output[count] <- (StringAfterRemoveit(input[count], chars_to_lose))
      } 
      count <- count +1
      }
    }
    return(output)
  }