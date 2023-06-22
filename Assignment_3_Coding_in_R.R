# Assignment 3 - Hangman
# By: Sanari Wickramaratne

# This script allows users to play Hangman game.
# Abilities of code include:
# * - Reading word list (dictionary) from project directory.
# * - Choosing a random element from list.
# * - Informing user on the length of secret word.
# * - Informing user on the number of wrong guesses/tries allowed.
# * - Asking for user input. User expected to enter one character only. The code will check if input is a character.
# * - Checking to see if user input is in the secret word and ask for next letter.
# * - If tries are exhausted, notifying user they have lost, revealing secret word, and exiting game.
# * - Notify user about correct letters/wrong letters and remaining tries.
# * - Provide visual cue of how user is progressing.



# 1. Reading the word list (dictionary) from project directory. Please find txt. file below in project directory in GitHub and save it to your working directory.
word_list <- readLines("Dictionary.txt")

# 2. Choosing a random word from the word list.

secret_word <- sample(word_list, 1)

# 3. Informing user on the length of the secret word.

word_length <- nchar(secret_word)

# 4. Informing user on the number of wrong guesses/tries allowed.

guessed <- c()
max_tries <- 10
remaining_tries <- max_tries

# 5. Introduction to game.
cat("Welcome to Sanari's Hangman Game!!!\n")
cat("Your category is cities in Ontario, Canada.\n")
cat("The secret word contains", word_length, "letters.\n")
cat("You have a total of", max_tries, "guesses available.\n")
cat("You are able to guess a single letter or type the full word.\n")

# 6. Asking for user input. User expected to enter one character only. The code will check if input is a character.
user_input <- readline("Please enter a single letter or the full word.")

# 7. Game loop.
while (max_tries > 0) {
  cat("\n")
  cat("Guess a letter: ")
  letter <- toupper(readline())

  if (!grepl("[A-Z]", letter)) {
    cat("Please enter a valid letter!\n")
    next
  }

  if (letter %in% guessed) {
    cat("You have already guessed that letter. Try again.\n")
    next
  }

  guessed <- c(guessed, letter)

  if (letter %in% strsplit(secret_word, "")[[1]]) {
    cat("Good guess!\n")
  } else {
    cat("Wrong guess!\n")
    remaining_tries <- remaining_tries - 1
  }

  displayed_word <- ""
  for (char in strsplit(secret_word, "")[[1]]) {
    if (char %in% guessed) {
      displayed_word <- paste(displayed_word, char, sep = " ")
    } else {
      displayed_word <- paste(displayed_word, "_", sep = " ")
    }
  }

  cat("Word:", displayed_word, "\n")
  cat("Guessed letters:", paste(guessed, collapse = ", "), "\n")
  cat("Remaining tries:", remaining_tries, "\n")

  if (displayed_word == secret_word) {
    cat("\nCongratulations! You guessed the word correctly!\n")
    break
  }
}

if (remaining_tries == 0) {
  cat("\nSorry, you lost the game. The word was:", secret_word, "\n")
}
