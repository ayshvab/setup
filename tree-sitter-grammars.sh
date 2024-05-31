#!/usr/bin/env bash

set -e  # Exit on errors

# Download URL and target directory
version="0.12.198"
download_url="https://github.com/emacs-tree-sitter/tree-sitter-langs/releases/download/$version/tree-sitter-grammars-linux-$version.tar.gz"
target_dir="$HOME/.emacs.d/tree-sitter"

# Create target directory if it doesn't exist
mkdir -p "$target_dir"

# Download archive
wget -P "$target_dir" "$download_url" 
tar -xf "$target_dir/tree-sitter-grammars-linux-$version.tar.gz"  -C "$target_dir"
rm "$target_dir/tree-sitter-grammars-linux-$version.tar.gz"

# Prefix to add
prefix="libtree-sitter-"

cd "$target_dir"
# Loop through all files
for file in *; do
  # Skip directories and hidden files
  if [[ ! -f "$file" || "$file" == "." || "$file" == ".." ]]; then
    continue
  fi
  
  # Rename the file with prefix
  mv "$file" "libtree-sitter-$file";
done

echo "Tree-sitter language pack downloaded now add libtree-sitter- prefix to all grammars!"
