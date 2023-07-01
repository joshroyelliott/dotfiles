#!/bin/sh

dotfiles_dir="$HOME/.config/dotfiles"
symlinked_files=("zshrc" "tmux.conf")

for file in "${symlinked_files[@]}"; do
    dotfile_path="$dotfiles_dir/$file"
    symlink_path="$HOME/.$file"

    # Check if the file exists and is not a symlink
    if [[ -e "$symlink_path" && ! -L "$symlink_path" ]]; then
        echo "File '$symlink_path' already exists and is not a symlink. Skipping..."
        continue
    fi

    # Check if the file is already symlinked
    if [[ -L "$symlink_path" && "$(readlink "$symlink_path")" == "$dotfile_path" ]]; then
        echo "File '$symlink_path' is already symlinked to '$dotfile_path'. Skipping..."
        continue
    fi

    # Create the symbolic link
    ln -s "$dotfile_path" "$symlink_path"
    echo "Created symlink for '$dotfile_path' in '$symlink_path'"
done
