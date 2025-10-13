### Welcome!

# This is an R script file, created by Simone
# Everything written after an hashtag is a comment
# Everything else is R code
# To activate the code, place the cursor on the corresponding line
# (or highlight multiple lines/pieces of code) 
# ...and press Ctrl+Enter (or Cmd+Enter for Mac)
# (the command will be automatically copy/pasted into the console)

### 1. Basic functions

# print something to the screen
print("Hello world")

# get info on a function
help(print)

# the "cat" function
cat("Hello world")
help(cat)

# concatenate and print
cat("The cat is", "on the table")
cat("The cat is", "on the table", "sleeping")

# add arguments
cat("The cat is", "on the table", "sleeping", sep = "\n")
cat("The cat is", "on the table", "sleeping", sep = " happy ")

### Your Turn (1) - start

# use the cat function to print this message:
# "The cat is with Simone on the table with Simone sleeping"
# you can complete the code here below:
cat("The cat is", "on the table", "sleeping", sep = "")
# tip: just modify the "sep" section

### Your Turn (1) - end


### 2. Creating variables

# numbers
my_number <- 1
my_number

# strings of text
my_string <- "to be or not to be"
my_string

# vectors
my_first_vector <- c(1,2,3,4,5)
my_first_vector

# vectors (of strings)
my_second_vector <- c("to", "be", "or", "not", "to", "be")
my_second_vector

# lists
my_list <- list(my_first_vector, my_second_vector)
my_list

### Your Turn (2) - start

# create and show a third vector
my_third_vector <- c()


### Your Turn (2) - end


### 3. Working with text files

# print working directory
getwd()

# read text line by line
my_text <- readLines("corpus/Cbronte_Jane_1847.txt")
head(my_text)

# split the text into words
my_words <- strsplit(my_text, "\\W")
head(my_words)

# split the text into words (in lowercase)
my_words <- strsplit(tolower(my_text), "\\W")
head(my_words)

# calculate the frequency of words
word_freq <- table(unlist(my_words))
word_freq

# print the most used words
sort(word_freq, decreasing = T)

# print just 100 most used words
sort(word_freq, decreasing = T)[1:100]

### Your Turn (3) - start

# do the same with another file in the "corpus" folder
my_text <- readLines("") # you have to change just this piece of code!
my_words <- strsplit(tolower(my_text), "\\W")
word_freq <- table(unlist(my_words))
sort(word_freq, decreasing = T)[1:100]


# Now you can go back to the "Hands-on 1" questionnaire in the Moodle
# Click on "Next Page"
# ...and answer the questions by using the output in the Console

### Your Turn (3) - end


### Appendix

### A1. Cheat sheets
# good practice when you start coding with R is to use cheat sheets
# you can download some from here (or just Google them!)
# https://iqss.github.io/dss-workshops/R/Rintro/base-r-cheat-sheet.pdf
# https://posit.co/resources/cheatsheets/


### A2. ChatGPT
# Large Language Models are very good in writing code!
# You just need to provide clear instructions
# However, never trust them 100% (especially when task is complex): always test the script!
# Example: https://chat.openai.com/share/ef0e31ba-9136-40ab-9e78-6c046de48b78
