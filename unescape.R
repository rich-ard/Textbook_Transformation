# This function requires the 'xml2' package be loaded.
# It takes as input a character vector of variable length, and unescapes xml or html values.
# Format is unescape(x, values) where 'x' is the character vector, and 'values' is either
# 'html' or 'xml' (default is html).

unescape <- function(input, values='html'){
  
  output <- ''
  count <- 1
  
  unescape_xml <- function(x){
    xml2::xml_text(xml2::read_xml(paste0("<x>", x, "</x>")))
  }
  
  unescape_html <- function(x){
    xml2::xml_text(xml2::read_html(paste0("<x>", x, "</x>")))
  }
  
  for (i in 1:length(input)){
    if (values=="html"){
      output[count] <- unescape_html(as.character(input[count]))
    }
    else if (values=="xml"){
      output[count] <- unescape_xml(as.character(input[count]))
    }
    else{
      output[count] <- input[count]
    }
    count <- count +1
  }
  return(output)
}

