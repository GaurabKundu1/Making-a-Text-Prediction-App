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

### Tasks to Accomplish

- Tokenization - identifying appropriate tokens such as words, punctuation, and numbers. Writing a function that takes a file as input and returns a tokenized version of it.

- Profanity filtering - removing profanity and other words you do not want to predict.

### Tips, Tricks, and Hints

- <b>Loading the data in</b>. This dataset is fairly large. We emphasize that you don't necessarily need to load the entire dataset in to build your algorithms (see point 2 below). At least initially, you might want to use a smaller subset of the data. Reading in chunks or lines using R's readLines or scan functions can be useful. You can also loop over each line of text by embedding readLines within a for/while loop, but this may be slower than reading in large chunks at a time. Reading pieces of the file at a time will require the use of a file connection in R. For example, the following code could be used to read the first few lines of the English Twitter dataset:con <- file("en_US.twitter.txt", "r") readLines(con, 1) ## Read the first line of text readLines(con, 1) ## Read the next line of text readLines(con, 5) ## Read in the next 5 lines of text close(con) ## It's important to close the connection when you are done. See the connections help page for more information.

- <b>Sampling</b>. To reiterate, to build models you don't need to load in and use all of the data. Often relatively few randomly selected rows or chunks need to be included to get an accurate approximation to results that would be obtained using all the data. Remember your inference class and how a representative sample can be used to infer facts about a population. You might want to create a separate sub-sample dataset by reading in a random subset of the original data and writing it out to a separate file. That way, you can store the sample and not have to recreate it every time. You can use the rbinom function to "flip a biased coin" to determine whether you sample a line of text or not.

## Task 2 : Exploratory Data Analysis

The first step in building a predictive model for text is understanding the distribution and relationship between the words, tokens, and phrases in the text. The goal of this task is to understand the basic relationships you observe in the data and prepare to build your first linguistic models.

### Tasks to accomplish

- Exploratory analysis - perform a thorough exploratory analysis of the data, understanding the distribution of words and relationship between the words in the corpora. 

- Understand frequencies of words and word pairs - build figures and tables to understand variation in the frequencies of words and word pairs in the data.

### Questions to consider

1. Some words are more frequent than others - what are the distributions of word frequencies? 

2. What are the frequencies of 2-grams and 3-grams in the dataset? 

3. How many unique words do you need in a frequency sorted dictionary to cover 50% of all word instances in the language? 90%? 

4. How do you evaluate how many of the words come from foreign languages? 

5. Can you think of a way to increase the coverage -- identifying words that may not be in the corpora or using a smaller number of words in the dictionary to cover the same number of phrases?

## Task 3 : Modeling

The goal here is to build your first simple model for the relationship between words. This is the first step in building a predictive text mining application. You will explore simple models and discover more complicated modeling techniques.

### Tasks to accomplish

- Build basic n-gram model - using the exploratory analysis you performed, build a basic [n-gram model](http://en.wikipedia.org/wiki/N-gram) for predicting the next word based on the previous 1, 2, or 3 words.

- Build a model to handle unseen n-grams - in some cases people will want to type a combination of words that does not appear in the corpora. Build a model to handle cases where a particular n-gram isn't observed.

### Questions to consider

1. How can you efficiently store an n-gram model (think Markov Chains)?

2. How can you use the knowledge about word frequencies to make your model smaller and more efficient?

3. How many parameters do you need (i.e. how big is n in your n-gram model)?

4. Can you think of simple ways to "smooth" the probabilities (think about giving all n-grams a non-zero probability even if they aren't observed in the data) ?

5. How do you evaluate whether your model is any good?

6. How can you use [backoff models](http://en.wikipedia.org/wiki/Katz%27s_back-off_model) to estimate the probability of unobserved n-grams?

### Hints, tips, and tricks

As you develop your prediction model, two key aspects that you will have to keep in mind are the size and runtime of the algorithm. These are defined as:

- <b>Size</b>: the amount of memory (physical RAM) required to run the model in R

- <b>Runtime</b>: The amount of time the algorithm takes to make a prediction given the acceptable input

Our goal for this prediction model is to minimize both the size and runtime of the model in order to provide a reasonable experience to the user.

Keep in mind that currently available predictive text models can run on mobile phones, which typically have limited memory and processing power compared to desktop computers. Therefore, we should consider very carefully :

(1) how much memory is being used by the objects in your workspace; and 

(2) how much time it is taking to run your model.

 Ultimately, our model will need to run in a Shiny app that runs on the [shinyapps.io](https://www.shinyapps.io/) server.

### Tips, tricks, and hints

Here are a few tools that may be of use to us as we work on their algorithm:

- object.size(): this function reports the number of bytes that an R object occupies in memory

- Rprof(): this function runs the profiler in R that can be used to determine where bottlenecks in your function may exist. The profr package (available on CRAN) provides some additional tools for visualizing and summarizing profiling data.

- gc(): this function runs the garbage collector to retrieve unused RAM for R. In the process it tells you how much memory is currently being used by R.

There will likely be a tradeoff that we have to make in between size and runtime. For example, an algorithm that requires a lot of memory, may run faster, while a slower algorithm may require less memory. we will have to find the right balance between the two in order to provide a good experience to the user.

## Task 4 : Prediction Model

The goal of this exercise is to build and evaluate our first predictive model. We will use the [n-gram and backoff models](https://github.com/GaurabKundu1/Johns-Hopkins-University-Data-Science-Capstone-Making-a-predictive-text-model/tree/main/Week%202%20Milestone%20Report) we built in previous tasks to build and evaluate our predictive model. The goal is to make the model efficient and accurate. 

### Tasks to accomplish

- Build a predictive model based on the previous data modeling steps - you may combine the models in any way you think is appropriate.

- Evaluate the model for efficiency and accuracy - use timing software to evaluate the computational complexity of your model. Evaluate the model accuracy using different metrics like perplexity, accuracy at the first word, second word, and third word.

### Questions to consider

1. How does the model perform for different choices of the parameters and size of the model?

2. How much does the model slow down for the performance you gain?

3. Does perplexity correlate with the other measures of accuracy?

4. Can you reduce the size of the model (number of parameters) without reducing performance?

## Task 5 : Creative Exploration

So far we have used basic models to understand and predict words. In this next task, our goal is to use all the resources we have available to us (from the Data Science Specialization, resources on the web, or our own creativity) to improve the predictive accuracy while reducing computational runtime and model complexity (if we can). Be sure to hold out a test set to evaluate the new, more creative models we are building.

### Tasks to accomplish

- Explore new models and data to improve your predictive model.

- Evaluate your new predictions on both accuracy and efficiency. 

### Questions to consider

1. What are some alternative data sets you could consider using? 

2. What are ways in which the n-gram model may be inefficient?

3. What are the most commonly missed n-grams? Can you think of a reason why they would be missed and fix that? 

4. What are some other things that other people have tried to improve their model? 

5. Can you estimate how uncertain you are about the words you are predicting? 

## Task 6 : [Data Product]( https://gaurabkundu1.shinyapps.io/Text_Prediction_App/)

The goal of this exercise is to create a product to highlight the prediction algorithm that we have built and to provide an interface that can be accessed by others via a Shiny app..

### Tasks to accomplish

- Create a data product to show off our prediction algorithm. We should create a Shiny app that accepts an n-gram and predicts the next word.

### Questions to consider

1. What are the most interesting ways you could show off your algorithm?

2. Are there any data visualizations you think might be helpful (look at the Swiftkey data dashboard if you have it loaded on your phone)?

3. How should you document the use of your data product (separately from how you created it) so that others can rapidly deploy your algorithm?

### Tips, tricks, and hints

Consider the size of the predictive model we have developed. We may have to sacrifice some accuracy to have a fast enough/small enough model to load into Shiny. 

## Task 7 : Slide Deck

The goal of this exercise is to "pitch" our data product to our boss or an investor. The slide deck is constrained to be 5 slides or less and should: 

(1) explain how your model works, 

(2) describe its predictive performance quantitatively and 

(3) show off the app and how it works. 

### Tasks to accomplish

- Create a slide deck promoting our product. Write 5 slides using RStudio Presenter explaining our product and why it is awesome!

### Questions to consider

1. How can you briefly explain how your predictive model works?

2. How can you succinctly quantitatively summarize the performance of your prediction algorithm?

3. How can you show the user how the product works?

### Tips, tricks, and hints

[The Rstudio presentation information is available here](https://support.rstudio.com/hc/en-us/articles/200486468-Authoring-R-Presentations). 