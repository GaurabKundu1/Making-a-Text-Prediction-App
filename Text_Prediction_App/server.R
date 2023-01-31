library(shiny)
library(dplyr)
library(tm)
library(sentimentr)

freq_bigram <- readRDS("bigram.RData")
freq_trigram <- readRDS("trigram.RData")
freq_quadgram <- readRDS("quadgram.RData")

## take the user input, clean and vectorize it
clean_input <- function(input) {
  
  if (input == "" | is.na(input)) {
    return("")
  }
  
  input <- tolower(input)
  input <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", input, ignore.case = FALSE, perl = TRUE)  # remove URLs
  input <- gsub("\\S+[@]\\S+", "", input, ignore.case = FALSE, perl = TRUE)  # remove email addresses
  input <- gsub("@[^\\s]+", "", input, ignore.case = FALSE, perl = TRUE)  # remove Twitter handles
  input <- gsub("#[^\\s]+", "", input, ignore.case = FALSE, perl = TRUE)  # remove hash tags
  input <- gsub("[0-9](?:st|nd|rd|th)", "", input, ignore.case = FALSE, perl = TRUE)  # remove ordinal numbers
  input <- removeWords(input, lexicon::profanity_arr_bad)  # remove profane words
  input <- gsub("[^\\p{L}'\\s]+", "", input, ignore.case = FALSE, perl = TRUE)  # remove punctuation
  input <- gsub("[.\\-!]", " ", input, ignore.case = FALSE, perl = TRUE)  # remove punctuation (leaving ')
  input <- gsub("^\\s+|\\s+$", "", input)  # remove trim leading  
  input <- stripWhitespace(input)  # remove trailing whitespace
  
  if (input == "" | is.na(input)) {
    return("")
  }
  
  input <- unlist(strsplit(input, " "))
  
  return(input)
  
}

## select which n-gram to use based on the output of clean_input for arguments to function predictionMatch
predictNextWord <- function(input, word = 0) {
  
  input <- clean_input(input)
  
  if (input[1] == "") {
    output <- NULL
  } else if (length(input) == 1) {
    output <- predictionMatch(input, ngrams = 2)
  } else if (length(input) == 2) {
    output <- predictionMatch(input, ngrams = 3)
  } else if (length(input) > 2) {
    output <- predictionMatch(input, ngrams = 4)
  }
  
  if (word == 0) {
    return(output)
  } else if (word == 1) {
    return(output[1])
  } else if (word == 2) {
    return(output[2])
  } else if (word == 3) {
    return(output[3])
  }
  
}

## use a function (outside of reactivity) to query the n-grams
predictionMatch <- function(userInput, ngrams) {
  
  # quadgram (and higher)
  if (ngrams > 3) {
    userInput1 <- paste(userInput[length(userInput) - 2])
    userInput2 <- paste(userInput[length(userInput) - 1])
    userInput3 <- paste(userInput[length(userInput)])
    dataTokens <- freq_quadgram %>% filter(word1 == userInput1) %>%
      filter(word2 == userInput2) %>%
      filter(word3 == userInput3)
    if (nrow(dataTokens) >= 1) {
      return(dataTokens$word4[1:3])
    }
    # backoff to trigram
    return(predictionMatch(userInput, ngrams - 1))
  }
  
  # trigram
  if (ngrams == 3) {
    userInput1 <- paste(userInput[length(userInput)-1])
    userInput2 <- paste(userInput[length(userInput)])
    dataTokens <- freq_trigram %>% filter(word1 == userInput1) %>%
      filter(word2 == userInput2)
    if (nrow(dataTokens) >= 1) {
      return(dataTokens$word3[1:3])
    }
    # backoff to bigram
    return(predictionMatch(userInput, ngrams - 1))
  }
  
  # bigram (and lower)
  if (ngrams < 3) {
    userInput1 <- userInput[length(userInput)]
    dataTokens <- freq_bigram %>% filter(word1 == userInput1)
    return(dataTokens$word2[1:3])
  }
  
}


shinyServer(function(input, output) {
  
  # user's sentence
  output$userSentence <- renderText({input$userInput});
  
  # predicted words
  output$prediction1 <- reactive({predictNextWord(input$userInput, 1)})
  output$prediction2 <- reactive({predictNextWord(input$userInput, 2)})
  output$prediction3 <- reactive({predictNextWord(input$userInput, 3)})
  
})