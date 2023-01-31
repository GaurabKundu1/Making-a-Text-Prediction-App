# Making a Predictive Text Model

## Author [Gaurab Kundu](https://www.linkedin.com/in/gaurab-kundu/)

## Project Overview

Around the world, people are spending an increasing amount of time on their mobile devices for email, social networking, banking and a whole range of other activities. But typing on mobile devices can be a serious pain. SwiftKey, our corporate partner in this project, builds a smart keyboard that makes it easier for people to type on their mobile devices. One cornerstone of their smart keyboard is predictive text models. When someone types:

I went to the

the keyboard presents three options for what the next word might be. For example, the three words might be gym, store, restaurant. In this capstone we will work on understanding and building predictive text models like those used by SwiftKey.

## Task 0 : Understanding the Problem

The first step in analyzing any new data set is figuring out: (a) what data you have and (b) what are the standard tools and models used for that type of data. Make sure you have downloaded the data from Coursera before heading for the exercises. This exercise uses the files named LOCALE.blogs.txt where LOCALE is the each of the four locales en_US, de_DE, ru_RU and fi_FI. The data is from a [corpus called HC Corpora](https://www.coursera.org/learn/data-science-project/supplement/4phKX/about-the-corpora). The files have been language filtered but may still contain some foreign text.

In this project we will be applying data science in the area of natural language processing. As a first step toward working on this project, we should familiarize ourselves with Natural Language Processing, Text Mining, and the associated tools in R. Here are some resources that may be helpful to get started.

[Natural language processing Wikipedia page](https://en.wikipedia.org/wiki/Natural_language_processing)

[Text mining infrastucture in R](http://www.jstatsoft.org/v25/i05/)

[CRAN Task View: Natural Language Processing](http://cran.r-project.org/web/views/NaturalLanguageProcessing.html)

### Dataset

This is the training data to get started that will be the basis for most of the capstone. we must download the data from the Coursera site and not from external websites to start.

[Capstone Dataset](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip)

Our original exploration of the data and modeling steps will be performed on this data set. Later in the project, if we find additional data sets that may be useful for building our model we may use them.

### Tasks to Accomplish

- Obtaining the data - Can you download the data and load/manipulate it in R?

- Familiarizing ourselves with NLP and text mining - Learn about the basics of natural language processing and how it relates to the data science process we have learned in the Data Science Specialization.

### Questions to Consider

1. What do the data look like?

2. Where do the data come from?

3. Can you think of any other data sources that might help you in this project?

4. What are the common steps in natural language processing?

5. What are some common issues in the analysis of text data?

6. What is the relationship between NLP and the concepts you have learned in the Specialization?

## Task 1 : Getting and Cleaning the Data

Large databases comprising of text in a target language are commonly used when generating language models for various purposes. In this exercise, you will use the English database but may consider three other databases in German, Russian and Finnish.

The goal of this task is to get familiar with the databases and do the necessary cleaning. After this exercise, you should understand what real data looks like and how much effort you need to put into cleaning the data. When you commence on developing a new language, the first thing is to understand the language and its peculiarities with respect to your target. You can learn to read, speak and write the language. Alternatively, you can study data and learn from existing information about the language through literature and the internet. At the very least, you need to understand how the language is written: writing script, existing input methods, some phonetic knowledge, etc.

Note that the data contain words of offensive and profane meaning. They are left there intentionally to highlight the fact that the developer has to work on them.

### Tasks to accomplish

1. Tokenization - identifying appropriate tokens such as words, punctuation, and numbers. Writing a function that takes a file as input and returns a tokenized version of it.

2. Profanity filtering - removing profanity and other words you do not want to predict.

### Tips, tricks, and hints

- <b>Loading the data in</b>. This dataset is fairly large. We emphasize that you don't necessarily need to load the entire dataset in to build your algorithms (see point 2 below). At least initially, you might want to use a smaller subset of the data. Reading in chunks or lines using R's readLines or scan functions can be useful. You can also loop over each line of text by embedding readLines within a for/while loop, but this may be slower than reading in large chunks at a time. Reading pieces of the file at a time will require the use of a file connection in R. For example, the following code could be used to read the first few lines of the English Twitter dataset:con <- file("en_US.twitter.txt", "r") readLines(con, 1) ## Read the first line of text readLines(con, 1) ## Read the next line of text readLines(con, 5) ## Read in the next 5 lines of text close(con) ## It's important to close the connection when you are done. See the connections help page for more information.

- <b>Sampling</b>. To reiterate, to build models you don't need to load in and use all of the data. Often relatively few randomly selected rows or chunks need to be included to get an accurate approximation to results that would be obtained using all the data. Remember your inference class and how a representative sample can be used to infer facts about a population. You might want to create a separate sub-sample dataset by reading in a random subset of the original data and writing it out to a separate file. That way, you can store the sample and not have to recreate it every time. You can use the rbinom function to "flip a biased coin" to determine whether you sample a line of text or not.