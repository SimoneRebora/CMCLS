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

# download the sentiment dictionaries included in Syuzhet
afinn_dict <- get_sentiment_dictionary("afinn")
syuzhet_dict <- get_sentiment_dictionary("syuzhet")
nrc_dict_eng <- get_sentiment_dictionary("nrc")
nrc_dict_deu <- get_sentiment_dictionary("nrc", language = "german")

# let's explore them!
View(afinn_dict)
View(syuzhet_dict)
View(nrc_dict_eng)
View(nrc_dict_deu)

# let's test syuzhet on tough sentences
my_sentence <- "I was not that happy"
get_sentiment(my_sentence, method="syuzhet")
get_sentiment(my_sentence, method="afinn")
get_sentiment(my_sentence, method="nrc")

my_sentence <- "Well, he was like a potato!"
get_sentiment(my_sentence, method="syuzhet")
get_sentiment(my_sentence, method="afinn")
get_sentiment(my_sentence, method="nrc")

# the issue with repeated words
my_sentence <- "He was a happy man"
get_sentiment(my_sentence, method="syuzhet")

my_sentence <- "He was not only a happy man, he was also a happy potato"
get_sentiment(my_sentence, method="syuzhet")

### Your Turn

# Simple: try other sentences!

my_sentence <- "..."
get_sentiment(my_sentence, method="...")

# Advanced: repeat the syuzhet analysis with a different dictionary

# Suggestion: you can copy/paste here below the content of the file:
# "03a_Syuzhet_analysis.R"
# ...and change just one line before running it!

