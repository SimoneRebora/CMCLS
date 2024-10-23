# Load required libraries
if (!require("udpipe")) install.packages("udpipe", dependencies=TRUE)
if (!require("wordcloud")) install.packages("wordcloud", dependencies=TRUE)
if (!require("ggplot2")) install.packages("ggplot2", dependencies=TRUE)
if (!require("dplyr")) install.packages("dplyr", dependencies=TRUE)
library(udpipe)
library(wordcloud)
library(ggplot2)
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

# Extract verbs (lemma) from the annotation
verb_data <- annotation_df %>%
  filter(upos == "VERB")  # Filter to include only verbs

# Count the frequency of verbs (lemmas)
verb_freq <- verb_data %>%
  group_by(lemma) %>%
  summarise(frequency = n()) %>%
  arrange(desc(frequency))

# View the most frequent verbs
head(verb_freq)

# Bar chart of the most frequent verbs (Top 10)
top_verbs <- head(verb_freq, 10)  # Select the top 10 verbs

# Plot the bar chart using ggplot2
ggplot(top_verbs, aes(x = reorder(lemma, frequency), y = frequency)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +  # Flip coordinates for better readability
  labs(title = "Top 10 Most Frequent Verbs", x = "Verbs", y = "Frequency") +
  theme_minimal()

# Print message
cat("NLP annotation and verb frequency bar chart generation complete. Results are saved in 'udpipe_annotation_output.csv'.\n")
