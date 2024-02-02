#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    echo "Usage: $0 <input-file-path> <output-directory> [num-copies]"
    exit 1
fi

# Get input file path, output directory, and number of copies from command-line arguments
input_file="$1"
output_directory="$2"
num_copies="${3:-100}"  # Use 100 as the default if not provided

# Check if the input file exists
if [ ! -e "$input_file" ]; then
    echo "Input file does not exist."
    exit 1
fi

# Check if the output directory exists, create it if not
if [ ! -d "$output_directory" ]; then
    mkdir -p "$output_directory"
fi

# Get the base name of the input file without the extension
base_name=$(basename -- "$input_file")
extension="${base_name##*.}"
filename="${base_name%.*}"

# Function to copy file
copy_file() {
    local input="$1"
    local output="$2"
    cp "$input" "$output"
}

# Loop to create the specified number of copies
for ((i=1; i<=$num_copies; i++)); do
    # Generate the destination file name with the loop counter and original file extension
    destination_file="$filename""_$i.$extension"

    # Copy the input file to the output directory with the destination file name
    copy_file "$input_file" "$output_directory/$destination_file"
    
    echo "Copy $i created: $output_directory/$destination_file"
done

echo "Script completed successfully."
