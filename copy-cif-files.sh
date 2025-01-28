#!/bin/bash

# Default values
source_dir="."
target_dir="cif_files"

# Help function
usage() {
    echo "Usage: $0 [-s source_directory] [-t target_directory]"
    echo "Options:"
    echo "  -s    Source directory containing AF3 output folders (default: current directory)"
    echo "  -t    Target directory for copied CIF files (default: ./cif_files)"
    echo "  -h    Display this help message"
    exit 1
}

# Parse command line arguments
while getopts "s:t:h" opt; do
    case $opt in
        s) source_dir="$OPTARG";;
        t) target_dir="$OPTARG";;
        h) usage;;
        ?) usage;;
    esac
done

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Error: Source directory '$source_dir' does not exist"
    exit 1
fi

# Create target directory if it doesn't exist
mkdir -p "$target_dir"

# Find and copy CIF files
echo "Searching for CIF files in $source_dir..."
count=0

find "$source_dir" -type f -name "*_model.cif" | while read -r cif_file; do
    # Get the parent folder name (which should be the protein/structure name)
    parent_folder=$(basename "$(dirname "$(dirname "$cif_file")")")
    
    # Create new filename with parent folder name
    new_filename="${parent_folder}_model.cif"
    
    # Copy the file
    cp "$cif_file" "$target_dir/$new_filename"
    
    echo "Copied: $cif_file -> $target_dir/$new_filename"
    ((count++))
done

echo "Completed! Copied $count CIF files to $target_dir"
