library(dplyr)
library(tidyr)
library(tidytext)
library(tm)
library(widyr)
library(stringi)
library(reshape2)
library(sentimentr)

## set seed for reproducibility
set.seed(424242)

## load the files
train_url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
train_data_file <- "data/Coursera-SwiftKey.zip"

if (!file.exists('data')) {
  dir.create('data')
}
if (!file.exists("data/final/en_US")) {
  tempFile <- tempfile()
  download.file(train_url, tempFile)
  unzip(tempFile, exdir = "data")
  unlink(tempFile)
}

# blogs
blogs_file_name <- "data/final/en_US/en_US.blogs.txt"
con <- file(blogs_file_name, open = "r")
blogs <- readLines(con, encoding = "UTF-8", skipNul = TRUE)
close(con)

# news
news_file_name <- "data/final/en_US/en_US.news.txt"
con <- file(news_file_name, open = "r")
news <- readLines(con, encoding = "UTF-8", skipNul = TRUE)
close(con)

# twitter
twitter_file_name <- "data/final/en_US/en_US.twitter.txt"
con <- file(twitter_file_name, open = "r")
twitter <- readLines(con, encoding = "UTF-8", skipNul = TRUE)
close(con)

rm(con)

## merge into one dataframe

# sample the sources
sample_blogs <- sample(blogs, length(blogs) * 0.5, replace = FALSE)
sample_news <- sample(news, length(news) * 0.5, replace = FALSE)
sample_twitter <- sample(twitter, length(twitter) * 0.5, replace = FALSE)

# remove all non-English characters from the sampled data
sample_blogs <- iconv(sample_blogs, "latin1", "ASCII", sub = "")
sample_news <- iconv(sample_news, "latin1", "ASCII", sub = "")
sample_twitter <- iconv(sample_twitter, "latin1", "ASCII", sub = "")

# remove outliers
remove_outliers <- function(data) {
  first <- quantile(nchar(data), 0.25)
  third <- quantile(nchar(data), 0.75)
  data <- data[nchar(data) > first]
  data <- data[nchar(data) < third]
  return(data)
}

sample_blogs <- remove_outliers(sample_blogs)
sample_news <- remove_outliers(sample_news)
sample_twitter <- remove_outliers(sample_twitter)

# merge into one dataframe
sample_data <- c(sample_blogs, sample_news, sample_twitter)


## tidy the corpus
corpus <- VCorpus(VectorSource(sample_data))  # Build corpus
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))  # Space converter function
corpus <- tm_map(corpus, toSpace, "(f|ht)tp(s?)://(.*)[.][a-z]+")  # Mutate URLs to spaces
corpus <- tm_map(corpus, toSpace, "@[^\\s]+")  # Mutate Twitter handles to spaces
corpus <- tm_map(corpus, toSpace, "\\b[A-Z a-z 0-9._ - ]*[@](.*?)[.]{1,3} \\b")  # Mutate email patterns to spaces
corpus <- tm_map(corpus, tolower)  # Convert all words to lowercase
corpus <- tm_map(corpus, removeWords, stopwords("english"))  # Remove common English stop words
corpus <- tm_map(corpus, removePunctuation)  # Remove punctuation marks
corpus <- tm_map(corpus, removeNumbers)  # Remove numbers
corpus <- tm_map(corpus, stripWhitespace)  # Trim whitespace
corpus <- tm_map(corpus, removeWords, lexicon::profanity_arr_bad)  # Remove profanity
corpus <- tm_map(corpus, PlainTextDocument)  # Convert to plain text documents

## build n-grams databases
corpus_text <- data.frame(text = unlist(sapply(corpus, '[', "content")), stringsAsFactors = FALSE)
corpus_text_tibble <- tibble(line = 1:nrow(corpus_text), text = corpus_text$text)

corpus_text_bigram <- corpus_text_tibble %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>% 
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  count(word1, word2, sort = TRUE) %>%
  distinct() %>%
  filter(n > 2)

corpus_text_trigram <- corpus_text_tibble %>%
  unnest_tokens(trigram, text, token = "ngrams", n = 3) %>%
  filter(!is.na(trigram)) %>% 
  separate(trigram, c("word1", "word2", "word3"), sep = " ") %>%
  count(word1, word2, word3, sort = TRUE) %>%
  distinct() %>%
  filter(n > 2)

corpus_text_quadgram <- corpus_text_tibble %>%
  unnest_tokens(quadgram, text, token = "ngrams", n = 4) %>%
  filter(!is.na(quadgram)) %>% 
  separate(quadgram, c("word1", "word2", "word3", "word4"), sep = " ") %>%
  count(word1, word2, word3, word4, sort = TRUE) %>%
  distinct() %>%
  filter(n > 2)

## save RDS for shiny app
saveRDS(corpus_text_bigram, "bigram.RData")
saveRDS(corpus_text_trigram, "trigram.RData")
saveRDS(corpus_text_quadgram, "quadgram.RData")