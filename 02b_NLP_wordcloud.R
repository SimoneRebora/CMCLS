### Welcome!

# This is an R script file, created by Simone
# (with the help of ChatGPT: https://github.com/SimoneRebora/CMCLS/tree/2024-2025/NLP)
# Everything written after an hashtag is a comment
# Everything else is R code
# To activate the code, place the cursor on the corresponding line
# (or highlight multiple lines/pieces of code) 
# ...and press Ctrl+Enter (or Cmd+Enter for Mac)
# (the command will be automatically copy/pasted into the console)

# Load required libraries
if (!require("udpipe")) install.packages("udpipe", dependencies=TRUE)
if (!require("wordcloud")) install.packages("wordcloud", dependencies=TRUE)
if (!require("dplyr")) install.packages("dplyr", dependencies=TRUE)
library(udpipe)
library(wordcloud)
library(dplyr)

# Define the path to the text file inside the "corpus" folder
corpus_folder <- "corpus"
file_name <- "Doyle_Study_1887.txt"  # Replace with the actual file name
file_path <- file.path(corpus_folder, file_name)

# Read the text file
text_data <- readLines(file_path, encoding = "UTF-8")

# Download the English udpipe model (if not already downloaded)
ud_model_path <- "english-ewt-ud-2.5-191206.udpipe"
if (!file.exists(ud_model_path)) {
  udpipe_download_model(language = "english-ewt")
}

# Load the udpipe model
ud_model <- udpipe_load_model(ud_model_path)

# Annotate the text using the udpipe model
annotation <- udpipe_annotate(ud_model, x = text_data)
annotation_df <- as.data.frame(annotation)

# View the first few lines of the annotation
head(annotation_df)

# Optionally, write the output to a CSV file
write.csv(annotation_df, file = "udpipe_annotation_output.csv", row.names = FALSE)

# Extract lemmas and filter out non-lemma rows (like punctuation)
lemma_data <- annotation_df %>%
  filter(!is.na(lemma), upos %in% c("NOUN", "VERB", "ADJ"))  # Filter to include only nouns, verbs, adjectives

# Count the frequency of lemmas
lemma_freq <- lemma_data %>%
  group_by(lemma) %>%
  summarise(frequency = n()) %>%
  arrange(desc(frequency))

# View the most frequent lemmas
head(lemma_freq)

# Generate the word cloud from the most frequent lemmas
set.seed(1234)  # For reproducibility of the word cloud
wordcloud(words = lemma_freq$lemma, 
          freq = lemma_freq$frequency, 
          min.freq = 2,                # Only show lemmas with a frequency of at least 2
          max.words = 100,             # Max number of words in the word cloud
          random.order = FALSE,        # Words in decreasing frequency
          colors = brewer.pal(8, "Dark2"))  # Use a color palette

# Print message
cat("NLP annotation and word cloud generation complete. Results are saved in 'udpipe_annotation_output.csv'.\n")
