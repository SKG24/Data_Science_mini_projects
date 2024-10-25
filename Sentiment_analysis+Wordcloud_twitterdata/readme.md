# Sentiment Analysis and Word Cloud for Twitter Data on Apple

This project performs sentiment analysis and generates a word cloud from tweets related to Apple Inc. The analysis aims to gain insights into public sentiment surrounding Apple and its products, visualizing the results through sentiment scores and word frequencies.

## Goal

To analyze and visualize the sentiment distribution and key terms in tweets about Apple, providing a clear view of the public's emotions and opinions.

## Project Structure

This project follows these main steps:
1. **Data Cleaning and Preprocessing**: Prepares the tweet text data for analysis by handling punctuation, numbers, whitespace, and stopwords.
2. **Text Representation (Term-Document Matrix)**: Constructs a structured representation of the text data.
3. **Visualization**: Creates a bar plot and a word cloud to visualize term frequencies.
4. **Sentiment Analysis**: Analyzes sentiment using NRC Emotion Lexicon and visualizes sentiment distributions for deeper insights.

## Approach

### 1. Data Preprocessing
The text data undergoes several preprocessing steps to ensure it is clean and ready for analysis. Steps include:
   - **Converting to Lowercase**: Ensures uniformity in words (e.g., "Apple" and "apple" are treated the same).
   - **Removing Punctuation, Numbers, URLs, and Stopwords**: Eliminates unnecessary elements and common words (e.g., "the," "is") that don’t contribute to sentiment analysis.
   - **Removing Specific Terms**: Terms like "apple" and "aapl" are removed as they dominate the text without adding value to the analysis.

### 2. Term-Document Matrix (TDM) Construction
   - The TDM structures the cleaned text data, organizing the frequency of each term across all documents.
   - It enables easy extraction of word frequencies, crucial for building the word cloud and analyzing common terms.

### 3. Visualization: Word Frequency
   - A bar plot and word cloud visualize the frequencies of the most common terms in the data.
   - **Bar Plot**: Displays words with a frequency of 25 or more across all tweets.
   - **Word Cloud**: Provides a more engaging visualization of the most common words, where word size indicates frequency.

### 4. Sentiment Analysis
   - Using the **syuzhet** package and NRC Emotion Lexicon, sentiment scores are obtained for each tweet.
   - **Bar Plot of Sentiment Scores**: Aggregates and visualizes sentiment scores across tweets, with categories like positive, negative, anger, and joy.

