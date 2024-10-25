setwd("/Users/sanatkumargupta/Desktop/data_science_mini_projects/Sentiment_analysis+Wordcloud_twitterdata")


# Read file
apple <- read.csv("/Users/sanatkumargupta/Desktop/data_science_mini_projects/Sentiment_analysis+Wordcloud_twitterdata/apple.csv")
str(apple)

# Build corpus
library(tm) #text mining
corpus <- iconv(apple$text, to = "utf-8-mac")
corpus <- Corpus(VectorSource(corpus)) 
inspect(corpus[1:5]) # to check data

# Cleaning text data
corpus <- tm_map(corpus, tolower) #convert to lowercase
inspect(corpus[1:5]) #A corpus in text mining is a collection of text documents used for processing, analysis, and extraction of insights, such as cleaning, tokenizing, or building models from textual data.

corpus <- tm_map(corpus, removePunctuation) # to remove puntuation
inspect(corpus[1:5])

corpus <- tm_map(corpus, removeNumbers) # to remove number
inspect(corpus[1:5])

cleanset <- tm_map(corpus, removeWords, stopwords('english')) # remove word is action to remove words, stopwords are common words used in english which don't have significant meaning in data mining
inspect(cleanset[1:5])

removeURL <- function(x) gsub('http[[:alnum:]]*', '', x) # to remove urls
cleanset <- tm_map(cleanset, content_transformer(removeURL))
inspect(cleanset[1:5])

cleanset <- tm_map(cleanset, removeWords, c('aapl', 'apple'))
cleanset <- tm_map(cleanset, gsub, 
                   pattern = 'stocks', 
                   replacement = 'stock') #replacement

cleanset <- tm_map(cleanset, stripWhitespace) # to remove whitespace caused during removal operations done above
inspect(cleanset[1:5])

# Term document matrix
# this is done to structure data
tdm <- TermDocumentMatrix(cleanset)
tdm
tdm <- as.matrix(tdm)
dim(tdm) # to check dimension
tdm[1:100, 1:3] # 1 to 10 words, 1 to 3 columns ... column is number of documents

# Bar plot
w <- rowSums(tdm)
w
w <- subset(w, w>=25)
barplot(w,
        las = 2,
        col = rainbow(50))

# Word cloud
library(wordcloud)
w <- sort(rowSums(tdm), decreasing = TRUE)
set.seed(222)
wordcloud(words = names(w),
          freq = w,
          max.words = 150,
          random.order = F, 
          min.freq = 10,
          colors = brewer.pal(8, 'Dark2'),
          scale = c(5, 0.3),
          rot.per = 0.7)

# similarly explore wordcloud2 and lettercloud

# Sentiment analysis
library(syuzhet) #used for sentiment analysis. It provides functions to extract sentiments from text, such as positive, negative, anger, joy, etc.
library(lubridate) #package simplifies working with dates and times in R.
library(ggplot2) #powerful visualization library for creating graphs and plots.
library(scales) #Provides functions for scaling visual elements in plots (like adjusting axes).
library(reshape2) #Used for reshaping data 
library(dplyr) #package that provides easy-to-use tools for data manipulation (e.g., filtering, summarizing, and mutating data).


# Read file
apple <- read.csv("/Users/sanatkumargupta/Desktop/data_science_mini_projects/Sentiment_analysis+Wordcloud_twitterdata/apple.csv")
tweets <- iconv(apple$text, to = 'utf-8-mac') #accesses the text column of the apple data frame, which likely contains the tweet texts.
#This function is used to convert the encoding of text. Here, it's converting the tweet texts into UTF-8 (Mac) encoding, ensuring that any special characters are handled properly.

# Obtain sentiment scores
s <- get_nrc_sentiment(tweets) #This function from the syuzhet package calculates the sentiment scores for each tweet based on the NRC Emotion Lexicon. It returns a data frame where each row corresponds to a tweet and each column represents a different sentiment 
head(s)
tweets[4]
get_nrc_sentiment('delay') #This calculates the sentiment scores for the word "delay." It's used here as a test to check how the function evaluates a single word's sentiment.

# Bar plot
barplot(colSums(s),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Sentiment Scores for Apple Tweets')
