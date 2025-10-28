# SentiArt_analysis

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

# load the packages
library(udpipe)
library(tidyverse)
library(reshape2)
library(syuzhet)

# process the text with udpipe
text <- readLines("corpus/Doyle_Study_1887.txt")
text <-  paste(text, collapse = "\n\n")
text_annotated <- udpipe(x = text, object = "english")
View(text_annotated)

# read SentiArt dictionary
sentiart <- read.csv("materials/SentiArt.csv", stringsAsFactors = F)
View(sentiart)

# Sentiart includes values per word (not lemma) in lowercase
# so we need to lowercase the tokens in our text and perform the analysis on them
text_annotated$token_lower <- tolower(text_annotated$token)

# limit the analysis only to some POS tags (content words)
sentiart_POS_sel <- c("NOUN", "VERB", "ADV", "ADJ")
text_annotated$token_lower[which(!text_annotated$upos %in% sentiart_POS_sel)] <- NA

# use left_join to add multiple annotations at once
text_annotated <- left_join(text_annotated, sentiart, by = c("token_lower" = "word")) 

# see the annotations
View(text_annotated)

# calculate mean values per sentence
# ...and per emotion
sentences_annotated <- text_annotated %>%
  group_by(sentence_id) %>%
  summarize(AAP = sum(AAPz, na.rm = T), # i.e. "Aesthetic-Affective Potential"
            anger = sum(ang_z, na.rm = T),
            fear = sum(fear_z, na.rm = T),
            disgust = sum(disg_z, na.rm = T),
            happiness = sum(hap_z, na.rm = T),
            sadness = sum(sad_z, na.rm = T),
            surprise = sum(surp_z, na.rm = T))

View(sentences_annotated)

# define function for rolling plot 
# (taken from https://github.com/mjockers/syuzhet/blob/master/R/syuzhet.R)
rolling_plot <- function (raw_values, window = 0.1){
  wdw <- round(length(raw_values) * window)
  rolled <- rescale(zoo::rollmean(raw_values, k = wdw, fill = 0))
  half <- round(wdw/2)
  rolled[1:half] <- NA
  end <- length(rolled) - half
  rolled[end:length(rolled)] <- NA
  return(rolled)
}

# apply rolling function to each emotion
sentences_annotated$AAP <- rolling_plot(sentences_annotated$AAP)
sentences_annotated$anger <- rolling_plot(sentences_annotated$anger)
sentences_annotated$fear <- rolling_plot(sentences_annotated$fear)
sentences_annotated$happiness <- rolling_plot(sentences_annotated$happiness)
sentences_annotated$disgust <- rolling_plot(sentences_annotated$disgust)
sentences_annotated$sadness <- rolling_plot(sentences_annotated$sadness)
sentences_annotated$surprise <- rolling_plot(sentences_annotated$surprise)

# create index for percentage of book
sentences_annotated$book_percentage <- 1:length(sentences_annotated$sentence_id)/length(sentences_annotated$sentence_id)*100
sentences_annotated$sentence_id <- NULL
View(sentences_annotated)

# reshape the data to long format for ggplot2 to handle multiple lines
df_long <- melt(sentences_annotated, id.vars = "book_percentage", variable.name = "emotion", value.name = "value")

# Create the line plot with multiple lines, one for each emotion
ggplot(df_long, aes(x = book_percentage, y = value, color = emotion)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "dotted") +
  labs(x = "Book Percentage", y = "Value", title = "Multiple Emotions analysis") +
  theme_minimal()

