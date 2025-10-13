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
library(udpipe)

# Set the path to the text file (modify this to your file's name)
file_path <- "corpus/Doyle_Study_1887.txt"

# Load the text data from the file
text_data <- readLines(file_path, warn = FALSE)

# Join the lines of text into one continuous string
text_data <- paste(text_data, collapse = " ")

# Download or load the English language model (run only once if not downloaded)
# If you don't have the English model yet, uncomment the line below to download it
# udpipe_download_model(language = "english")

# Load the English model
model <- udpipe_load_model("english-ewt-ud-2.5-191206.udpipe")

# Perform NLP (annotate the text)
annotated_text <- udpipe_annotate(model, x = text_data)

# Convert the annotated text into a data frame for easier manipulation
annotation_df <- as.data.frame(annotated_text)

# Display the first few rows of the annotated data
head(annotation_df)

# Filter the annotations to include only relevant parts of speech
# Selecting Nouns, Adjectives, Verbs, etc. based on your needs
filtered_annotations <- annotation_df[annotation_df$upos %in% c("NOUN", "ADJ", "VERB"), ]

# Compute word co-occurrences, focusing on the filtered terms
cooccurrences <- cooccurrence(
  x = filtered_annotations, 
  term = "lemma", 
  group = c("doc_id", "paragraph_id", "sentence_id")
)

# View the top co-occurrences
head(cooccurrences)

# Save the co-occurrences to a CSV file
write.csv(cooccurrences, "word_cooccurrences.csv", row.names = FALSE)
