# Assignment 3 - Hangman Game
# By: Sanari Wickramaratne

# Load word list found in txt. file within Assignment_3 Repository
wordlist <- readLines("Dictionary.txt")

# Choose a random word from the list
secret_word <- tolower(sample(wordlist, 1))

# Get the length of the secret word
word_length <- nchar(secret_word)

# Set the maximum number of wrong guesses
max_wrong_guesses <- 10

# Initialize variables to store guessed letters during game and the number of wrong guesses
guessed_letters <- character(0)
wrong_guesses <- 0

# Function to visually display the current state of the game for user
display_state <- function(secret_word, guessed_letters, wrong_guesses, max_wrong_guesses) {
  revealed_word <- ""
  for (letter in strsplit(secret_word, "")[[1]]) {
    if (letter %in% guessed_letters) {
      revealed_word <- paste(revealed_word, letter, sep = " ")
    } else {
      revealed_word <- paste(revealed_word, "_", sep = " ")
    }
  }
  cat("Word:", revealed_word, "\n")
  cat("Guesses:", guessed_letters, "\n")
  cat("Wrong guesses:", wrong_guesses, "/", max_wrong_guesses, "\n")
}

# Function to check if the input is a valid letter
valid_letter <- function(input) {
  grepl("^[a-zA-Z]$", input)
}

# Introduction to game
cat("Welcome to Sanari's Hangman Game! The category is cities within Ontario, Canada. I hope you enjoy playing! \n")
cat("The word has", word_length, "letters. You are allowed 20 guesses in total. Good luck!!\n")

# Create a while loop to prompt user to enter a letter until the game is over
while (wrong_guesses < max_wrong_guesses) {
  display_state(secret_word, guessed_letters, wrong_guesses, max_wrong_guesses)

  # Prompt user to enter a letter
  guess <- readline("Please enter a letter: ")
  guess <- tolower(guess)

  # Check if the input is a valid letter
  if (!isvalid_letter(guess)) {
    cat("Please enter a valid letter.\n")
    next
  }
  
  # Converting the guess to lowercase
  guess <- tolower(guess)

  # Check if the letter has already been guessed
  if (guess %in% guessed_letters) {
    cat("You already guessed that letter. Please try again. \n")
    next
  }

  # Add the guess to the guessed letters
  guessed_letters <- c(guessed_letters, guess)

  # Check if the guess is in the secret word
  if (guess %in% strsplit(secret_word, "")[[1]]) {
    cat("Correct guess!\n")
  } else {
    cat("Wrong guess!\n")
    wrong_guesses <- wrong_guesses + 1
  }

  # Check if the user has guessed all the letters
  if (all(strsplit(secret_word, "")[[1]] %in% guessed_letters)) {
    display_state(secret_word, guessed_letters, wrong_guesses, max_wrong_guesses)
    cat("Congratulations! You have successfully guessed the secret word! YAY!! \n")
    break
  }
}

  # If the user has used up all the guesses, let them know that they have lost the game
if (wrong_guesses == max_wrong_guesses) {
  display_state(secret_word, guessed_letters, wrong_guesses, max_wrong_guesses)
  cat("Oh no! You lost the game! The word was:", secret_word, "\n")
}

# END OF GAME
