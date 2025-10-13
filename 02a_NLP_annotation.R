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
library(udpipe)

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

# View the annotated text
View(annotation_df)
