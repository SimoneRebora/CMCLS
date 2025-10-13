### Welcome!

# This is an R script file, created by Simone
# (with the help of ChatGPT: https://github.com/SimoneRebora/CMCLS/tree/2024-2025/NLP)
# Everything written after an hashtag is a comment
# Everything else is R code
# To activate the code, place the cursor on the corresponding line
# (or highlight multiple lines/pieces of code) 
# ...and press Ctrl+Enter (or Cmd+Enter for Mac)
# (the command will be automatically copy/pasted into the console)

# before you start, install the required packages
# (if a warning is shown above)

# Load required libraries
library(udpipe)
library(wordcloud)
library(dplyr)
library(ggplot2)


### Part 1
## NLP annotation

# Define the path to the text file inside the "corpus" folder
file_path <- "corpus/Doyle_Study_1887.txt"

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

# View the annotated text
View(annotation_df)


### Part 2
## Wordcloud

# print the POS types available
unique(annotation_df$upos)

# select only some (e.g. nouns, verbs, adjectives)
my_selection <- c("NOUN", "VERB", "ADJ")

# Extract lemmas and filter out non-lemma rows (like punctuation)
lemma_data <- annotation_df %>%
  filter(!is.na(lemma), upos %in% my_selection)  # Filter to include only selected POS

# Count the frequency of lemmas
lemma_freq <- lemma_data %>%
  group_by(lemma) %>%
  summarise(frequency = n()) %>%
  arrange(desc(frequency))

# View the most frequent lemmas
head(lemma_freq)

# Generate the word cloud from the most frequent lemmas
wordcloud(words = lemma_freq$lemma, 
          freq = lemma_freq$frequency, 
          min.freq = 2,                # Only show lemmas with a frequency of at least 2
          max.words = 100,             # Max number of words in the word cloud
          random.order = FALSE,        # Words in decreasing frequency
          colors = brewer.pal(8, "Dark2"))  # Use a color palette

### Your Turn (Part 2) - start

# create another wordcloud
# with a different POS selection

# tip: just modify line 53 above
# ...and re-run the script from there

### Your Turn (Part 2) - end


### Part 3
### Barchart of one POS

# select your POS
my_pos <- "VERB"

# Extract POS lemmas from the annotation
pos_data <- annotation_df %>%
  filter(upos == my_pos)  # Filter to include only your POS

# Count the frequency of lemmas
pos_freq <- pos_data %>%
  group_by(lemma) %>%
  summarise(frequency = n()) %>%
  arrange(desc(frequency))

# View the most frequent lemmas
head(pos_freq)

# Bar chart of the most frequent lemmas (Top 10)
top_pos <- head(pos_freq, 10)

# Plot the bar chart using ggplot2
ggplot(top_pos, aes(x = reorder(lemma, frequency), y = frequency)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +  # Flip coordinates for better readability
  labs(title = "Top 10 Most Frequent lemmas", x = my_pos, y = "Frequency") +
  theme_minimal()

### Your Turn (Part 3) - start

# create another barchart
# with a different POS

# tip: just modify line 93 above
# ...and re-run the script from there

### Your Turn (Part 3) - end


### Part 4
### KWIC analysis

# first, define your lemma
my_lemma <- "Sherlock"

# let's find all its the appearances
my_matches <- which(annotation_df$lemma== my_lemma)

# print keyword in context via loop
for(i in 1:length(my_matches)){
  
  cat(i, "\t", annotation_df$token[(my_matches[i]-5):(my_matches[i]+5)], "\n")
  
}

# save it to file
sink("KWIC_results.txt")
for(i in 1:length(my_matches)){
  
  cat(i, "\t", annotation_df$token[(my_matches[i]-5):(my_matches[i]+5)], "\n")
  
}
sink()

### Your Turn (Part 4) - start

# repeat the KWIC analysis
# with a different lemma

# tip: just modify line 133 above
# ...and re-run the script from there

### Your Turn (Part 4) - end


### Part 5
### Cooccurrences

# print the POS types available
unique(annotation_df$upos)

# select (again) only some POS tags
my_selection <- c("NOUN", "VERB", "ADJ")

# Filter the annotations to include only relevant parts of speech
filtered_annotations <- annotation_df[annotation_df$upos %in% my_selection, ]

# Compute word co-occurrences, focusing on the filtered terms
cooccurrences <- cooccurrence(
  x = filtered_annotations, 
  term = "lemma", 
  group = c("doc_id", "paragraph_id", "sentence_id") # co-occ context is the sentence
)

# View the top co-occurrences
head(cooccurrences)

# Save the co-occurrences to a CSV file
write.csv(cooccurrences, "word_cooccurrences.csv", row.names = FALSE)

### Your Turn (Part 5) - start

# repeat the co-occurrence analysis
# with a different POS selection

# tip: just modify line 172 above
# ...and re-run the script from there

### Your Turn (Part 5) - end