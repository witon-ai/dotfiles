#!/bin/zsh

export CHEZMOI_HOME="$HOME/Documents/.config/chezmoi"
export CHEZMOI_AGE_HOME="$CHEZMOI_HOME/age"
export AGE_KEY_FILE_WITHOUT_POSTFIX="$CHEZMOI_AGE_HOME/key"
export AGE_KEY_FILE="$AGE_KEY_FILE_WITHOUT_POSTFIX.txt"
export AGE_KEY_PUBLIC_FILE="$AGE_KEY_FILE_WITHOUT_POSTFIX.pub"
export SERVICE="chezmoi-age-public-key"

echo "Installing chezmoi..."
brew install chezmoi
echo "Generating age key..."
mkdir -p $CHEZMOI_AGE_HOME
chezmoi age-keygen --output=$AGE_KEY_FILE
age-keygen -y $AGE_KEY_FILE > $AGE_KEY_PUBLIC_FILE
