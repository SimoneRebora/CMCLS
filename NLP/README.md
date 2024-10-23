# NLP with UDpipe

This R project is prepared to run NLP analyses on the files contained in the "corpus" folder. This file will guide you on how to interact with ChatGPT to create the necessary scripts. It is subdivided in a series of tasks.

## 1. Text annotation

[The solution for this task has been uploaded in the file "01_NLP_annotation.R". To run it, open the file, click Ctrl+A (select all) and Ctrl+Enter]

To create your first script, open the ChatGPT interface (https://chatgpt.com/ - you should login via Google) and type:

"I am inside of an R project. I need to run NLP (using udpipe) on one file inside the "corpus" folder, which contains text in English language. Can you prepare the script for me? Thanks for your help!"

To work with the provided script, create a new R script file (in the panel: "File"->"New File"->"R Script") and copy-paste the script there. Examine it, change a few things (most probably just the file path), and run it (by using Ctrl+Enter or Cmd+Enter).

Note: the script might not work perfectly at the first try. In case an error message appears, try to copy paste it to the ChatGPT console and ask it to change the script so that the problem is solved.

Suggestion: if the script works, you can save it and start working on a new file, so you won't overwrite what done before.

## 2. Lemma frequency

[The solution for this task has been uploaded in the file "02_Wordcloud.R". To run it, open the file, click Ctrl+A (select all) and Ctrl+Enter]

Now you can start asking for visualizations. For example, ask ChatGPT to adapt the already-given script to produce a wordcloud of the most frequent lemmas.

### 2.1 Moodle task

If the script worked and you got a wordcloud, export it to a file (click on "Export" in the "Plots" panel) and save it to the "Hands-on 2" task in the Moodle. Note that the file will be saved inside the Posit Cloud project. To download it to your computer, go to the "Files" panel and look for a "Rplot.png" file. Select it, click on "More" and "Export". You can then upload it to the Moodle.

## 3. Most frequent verbs

[The solution for this task has been uploaded in the file "03_Verb_barchart.R". To run it, open the file, click Ctrl+A (select all) and Ctrl+Enter]

Ask ChatGPT to modify the script so that it visualizes a barchart of the most frequent verbs.

### 3.1 Moodle task

Save the plot to the Moodle.

## 4. Keyword in context

[The solution for this task has been uploaded in the file "04_KWIC.R". To run it, open the file, click Ctrl+A (select all) and Ctrl+Enter]

Ask ChatGPT to modify the script so that it shows keyword in context for a given word (and save it to a .csv file).
Note: here you might have to insist a little in explaining precisely the task to ChatGPT.
Suggestion: if you get into too complex errors, you might have to restart ChatGPT and ask it directly to do this task. It will probably use a different (and better) approach.

### 4.1 Moodle task

Save the file to the Moodle.

## 5. Collocations (or: co-occurrences)

[The solution for this task has been uploaded in the file "05_Cooccurrences.R". To run it, open the file, click Ctrl+A (select all) and Ctrl+Enter]

Ask ChatGPT to modify the script so that it shows the most frequent word co-occurrences (and save them to a .csv file).
Note: here again you might have to insist a little in explaining precisely the task.
Suggestion: you might have to tell ChatGPT that udpipe has a built-in function called "cooccurrence" (as it tends to forget...)

### 5.1 Moodle task

Save the file to the Moodle.
