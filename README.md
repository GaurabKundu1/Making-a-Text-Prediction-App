# Making a Predictive Text Model

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