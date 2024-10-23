# Load required libraries
library(udpipe)
library(quanteda)

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

# Specify the keyword you want to analyze
keyword <- "good"  # Replace 'your_keyword' with the word you're interested in

# Create a corpus for KWIC extraction
corpus <- corpus(text_data)

# Tokenize the corpus
tokens <- tokens(corpus)

# Extract KWIC (keyword in context)
kwic_results <- kwic(tokens, pattern = keyword, window = 5) # 5 words before and after

# Convert the KWIC results to a data frame
kwic_df <- as.data.frame(kwic_results)

# Save the KWIC results to a CSV file
write.csv(kwic_df, "kwic_results.csv", row.names = FALSE)

# Display result
kwic_results
