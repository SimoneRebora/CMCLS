### Topic modeling with R

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
library(mallet) 
library(tidyverse)
library(ggwordcloud)
library(tidytext)
library(litedown)

### Define variables
# here you define the variables for your topic modeling
num_topics <- 10 # number of topics
num_iterations <- 200 # number of iterations
len_split <- 1000 # length of the split texts (they will be the actual documents to work on)
my_folder <- "corpus" # the folder where the files to be analyzed are
my_stoplist <- "materials/stopwords-en.stopwords" # define the stopwords to be removed 

# read all files in your folder
all_files <- list.files(my_folder, full.names = T)

# load function to split text files
load("materials/split_texts_function.RData")
# view the function
View(split_texts)

# split files into smaller documents
my_texts <- split_texts(file_list = all_files, split_length = len_split, my_folder = my_folder)

# explore the documents
my_texts[1]
my_texts[200]

# prepare texts for topic model
text.instances <- mallet.import(text.array = my_texts, 
                                stoplist = my_stoplist, 
                                id.array = names(my_texts))

# define all variables (better not to change alpha and beta)
topic.model <- MalletLDA(num.topics=num_topics, alpha.sum = 1, beta = 0.1)

# load documents for topic modeling
topic.model$loadDocuments(text.instances)

# prepare topic models' features (again, you can leave the values as they are)
topic.model$setAlphaOptimization(20, 50) # this is for optimization

# create the topic models
topic.model$train(num_iterations)

### Now, we can start exploring them!

# extract the vocabulary from the topic model
vocabulary <- mallet.word.freqs(topic.model)
View(vocabulary)

# extract topics per words
topic.words <- mallet.topic.words(topic.model, smoothed=TRUE, normalized=TRUE)
colnames(topic.words) <- vocabulary$word
View(topic.words)

# extract topics per document
doc.topics <- mallet.doc.topics(topic.model, smoothed=TRUE, normalized=TRUE)
rownames(doc.topics) <- names(my_texts)
View(doc.topics)

### Produce better word/topic visualizations

# use a loop to visualize the top words per topic in a table
top_words <- data.frame()
firstwords <- character()
for(i in 1:num_topics){
  words.per.topic <- mallet.top.words(topic.model, word.weights = topic.words[i,], num.top.words = 20)
  words.per.topic$topic <- i
  top_words <- rbind(top_words, words.per.topic)
  rownames(top_words) <- 1:length(top_words$term)
  firstwords[i] <- paste(words.per.topic$term[1:5], collapse = " ")
  names(firstwords)[i] <- paste("Topic", i)
}

# visualize the table of top words per topics
View(top_words)

# visualize the first five words per topic
firstwords

### Wordcloud visualization

# prepare the plot
p1 <- ggplot(
  top_words,
  aes(label = term, size = weight)) +
  geom_text_wordcloud_area() +
  scale_size_area(max_size = 20) +
  theme_minimal() +
  facet_wrap(~topic)

# show it
p1

# save it
ggsave(p1, filename = "Topics_wordcloud.png", scale = 0.6, height = 9, width = 16)
# tip: if you are not satisfied with the image in the file...
# try to change the values of scale (higher => smaller font)
# and of height/width (higher => bigger image)

### Alternative visualization (barcharts)

# prepare the plot
p2 <- top_words %>%
  mutate(term = reorder_within(term, weight, topic)) %>%
  ggplot(aes(weight, term, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  scale_y_reordered()

# show it
p2

# save it
ggsave(p2, filename = "Topics_barchart.png", scale = 0.6, height = 16, width = 16)

### Cluster the documents per topic

# first assign names that correspond to: the first five words of the topics
colnames(doc.topics) <- firstwords

# visualize an heatmap and save it to a file
png(filename = "heatmap.png", width = 4000, height = 4000)
heatmap(doc.topics, margins = c(25,25), Rowv = NA, Colv = NA, cexRow = 2, cexCol = 2)
dev.off()

# simplify the visualization 

# start by changing variable type
doc.topics <- as.data.frame(doc.topics)

# create a variable that contains the groups (i.e. the books)
groups_tmp <- rownames(doc.topics)
groups_tmp <- strsplit(groups_tmp, "_")
groups_tmp <- sapply(groups_tmp, function(x) paste(x[1:2], collapse = "_"))

# add it to the dataframe
doc.topics$group <- groups_tmp

# calculate mean for each topic probability per group
doc.topics.simple <- doc.topics %>% 
  group_by(group) %>%
  summarise(across(everything(), mean))

# re-convert the format to matrix
groups_tmp <- doc.topics.simple$group
doc.topics.simple$group <- NULL
doc.topics.simple <- as.matrix(doc.topics.simple)
rownames(doc.topics.simple) <- groups_tmp

# visualize another heatmap and save it to a file
png(filename = "heatmap_simple.png", width = 1000, height = 1000)
heatmap(doc.topics.simple, margins = c(30,30), Rowv = NA, Colv = NA, cexRow = 2, cexCol = 2)
dev.off()

### Your Turn - start

## Option 1 (simple). Repeat the topic modeling procedure by changing the number of topics
# (...not too much, please!! If possible, stay in the range 5-15)

## Option 2 (complex). Repeat the topic modeling procedure on a different corpus
# you can download some more files from here:
# https://github.com/computationalstylistics/100_english_novels 
# or here (in German!):
# https://github.com/computationalstylistics/68_german_novels/tree/master
# ...and then upload them to the PositCloud "Files" panel
# suggestion: do not use all texts, not to overload PositCloud 
# tip: name the folder differently, to avoid merging with the "corpus" already present

# Once completed the analysis, upload any result file to the Moodle

