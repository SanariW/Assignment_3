# Assignment 3 - Hangman
# By: Sanari Wickramaratne

# Load word list from file
wordlist <- readLines("Dictionary.txt")

# Choose a random word from the list
secret_word <- tolower(sample(wordlist, 1))

# Get the length of the secret word
word_length <- nchar(secret_word)

# Set the maximum number of wrong guesses
max_wrong_guesses <- 10

# Initialize variables to store guessed letters during game and the number of wrong guesses.
guessed_letters <- character(0)
wrong_guesses <- 0

# Function to display the current state of the game
displayState <- function(secret_word, guessed_letters, wrong_guesses, max_wrong_guesses) {
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
isValidLetter <- function(input) {
  grepl("^[a-zA-Z]$", input)
}

# Main game loop
cat("Welcome to Hangman!\n")
cat("The word has", word_length, "letters.\n")

while (wrong_guesses < max_wrong_guesses) {
  displayState(secret_word, guessed_letters, wrong_guesses, max_wrong_guesses)

  # Prompt user for input
  guess <- readline("Enter your guess: ")
  guess <- tolower(guess)

  # Check if the input is a valid letter
  if (!isValidLetter(guess)) {
    cat("Please enter a valid letter.\n")
    next
  }

  # Check if the letter has already been guessed
  if (guess %in% guessed_letters) {
    cat("You already guessed that letter.\n")
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
    displayState(secret_word, guessed_letters, wrong_guesses, max_wrong_guesses)
    cat("Congratulations! You won!\n")
    break
  }
}

# If the user has used all the guesses
if (wrong_guesses == max_wrong_guesses) {
  displayState(secret_word, guessed_letters, wrong_guesses, max_wrong_guesses)
  cat("Sorry, you lost. The word was:", secret_word, "\n")
}
