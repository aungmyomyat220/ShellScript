#!/bin/bash

# Function to display usage
show_usage() {
  echo "Usage: ./file_encrypt_decrypt.sh [option]"
  echo ""
  echo "Options:"
  echo "  usage              Show this usage information"
  echo "  encrypt            Encrypt a file"
  echo "  decrypt            Decrypt a file"
  echo ""
  echo "Example:"
  echo "  ./file_encrypt_decrypt.sh encrypt"
  echo "  ./file_encrypt_decrypt.sh decrypt"
}

# Function to encrypt a file
encrypt_file() {
  echo "Enter the file to encrypt:"
  read -r input_file
  if [ ! -f "$input_file" ]; then
    echo "Error: File does not exist."
    exit 1
  fi

  echo "Enter the output file name (encrypted):"
  read -r output_file

  echo "Enter the encryption password:"
  read -rs password

  openssl enc -aes-256-cbc -salt -in "$input_file" -out "$output_file" -pass pass:"$password"
  
  if [ $? -eq 0 ]; then
    echo "File encrypted successfully: $output_file"

    # Prompt to delete the original file
    echo "Do you want to delete the original file? (yes/no)"
    read -r delete_choice
    if [[ "$delete_choice" =~ ^(yes|y)$ ]]; then
      rm "$input_file"
      echo "Original file deleted."
    else
      echo "Original file retained."
    fi
  else
    echo "Encryption failed."
  fi
}

# Function to decrypt a file
decrypt_file() {
  echo "Enter the file to decrypt:"
  read -r input_file
  if [ ! -f "$input_file" ]; then
    echo "Error: File does not exist."
    exit 1
  fi

  echo "Enter the output file name (decrypted):"
  read -r output_file

  echo "Enter the decryption password:"
  read -rs password

  openssl enc -aes-256-cbc -d -in "$input_file" -out "$output_file" -pass pass:"$password"
  
  if [ $? -eq 0 ]; then
    echo "File decrypted successfully: $output_file"
  else
    echo "Decryption failed. Check your password."
  fi
}

# Main script logic
case $1 in
  usage)
    show_usage
    ;;
  encrypt)
    encrypt_file
    ;;
  decrypt)
    decrypt_file
    ;;
  *)
    echo "Invalid option. Type './file_encrypt_decrypt.sh usage' for help."
    exit 1
    ;;
esac

