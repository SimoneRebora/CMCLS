# Syuzhet_analysis

# Welcome!
# This is an R script file, created by Simone
# Everything written after an hashtag is a comment
# Everything else is R code
# To activate the code, place the cursor on the corresponding line
# (or highlight multiple lines/pieces of code) 
# ...and press Ctrl+Enter (or Cmd+Enter for Mac)
# (the command will be automatically copy/pasted into the console)

# before you start, install the required packages
# (if a warning is shown above)

# load the package
library(syuzhet) # you will have to do it every time you restart R

# read a text in the folder
text <- readLines("corpus/Doyle_Study_1887.txt")

# collapse it in a single string
text <- paste(text, collapse = " ")

# here Syuzhet comes into action: it splits the text into sentences
sentences_vector <- get_sentences(text)

# check the sentences
head(sentences_vector)

# ...and calulates the sentiment for each sentence
syuzhet_vector <- get_sentiment(sentences_vector, method="syuzhet")

# let's visualize the results
head(syuzhet_vector)

# put them in a graph
plot(
  syuzhet_vector, 
  type="l", 
  main="Sentiment Arc", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence"
)

# ...it is still too noisy: we'll need to use some filters
simple_plot(syuzhet_vector, title = "Sentiment arc")
# here you might get an error: please make the plot area the highest possible

# we can save the plot as a png file
png("my_simple_plot.png", height = 900, width = 1600, res = 150)
simple_plot(syuzhet_vector, title = "Sentiment arc")
dev.off()

### Your Turn

# Run the same analysis on a different text

# You can pick up a text from Project Gutenberg (Australia)
# for example "1984" by George Orwell:
# https://gutenberg.net.au/plusfifty-n-z.html#orwell
# (but you can choose freely; remember just to save the "text" file)

# Once the file is downloaded to your computer
# you need to upload it to PostiCloud
# (using the "Upload" button in the "Files" Panel)
# then you can re-run the full script
# ...after having changed line 19 accordingly

# For the (only) task today
# download the last graph to your computer (select the file and "More -> Export")
# and save it to the Moodle, Hands-on 4
