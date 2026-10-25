# Zeta analysis

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

# Call the packages
library(stylo)

# first, we need to make sure that the "ANONYMOUS" file is not in the corpus folder anymore
unlink("corpus/ANONYMOUS.txt")

# then we create two new folders
dir.create("primary_set")
dir.create("secondary_set")
# this is because the function we'll be using (called "oppose")
# expects to have files in two folders with these names

# then we prepare the corpus by dividing it into two parts

# first, we list all the files in the "corpus" folder
list_files <- list.files("corpus", full.names = T)
list_files

# now we can create two groups (males and females)
groupA_files <- list_files[4:9]
groupA_files

groupB_files <- list_files[c(1, 2, 3, 10, 11, 12)]
groupB_files

# we create new names for the files to be copied
groupA_files_new <- gsub(pattern = "corpus/", replacement = "primary_set/", groupA_files, fixed = T)
groupA_files_new

groupB_files_new <- gsub(pattern = "corpus/", replacement = "secondary_set/", groupB_files, fixed = T)
groupB_files_new

# then we copy the files!
file.copy(groupA_files, groupA_files_new)
file.copy(groupB_files, groupB_files_new)

# now that everything is set...
# we can run the Zeta analysis (it's called "oppose" in stylo)
oppose(text.slice.length = 3000,
        write.png.file = TRUE)

# for the "markers" visualization, you can use just an additional argument
oppose(text.slice.length = 3000,
        write.png.file = TRUE,
        visualization = "markers")

# important: delete the folders, in case you want to run different analyses
unlink("primary_set/", recursive = T)
unlink("secondary_set/", recursive = T)

#####
# Your turn!
#####

# ...if there is no more time
# just save one of the visualizations to the Moodle

# ...if there is some time left
# repeat the whole procedure with a different group 
# e.g. Virginia Woolf vs. all the others...
# note that you will have to change just lines 34 and 37
# ...and re-run the whole script

