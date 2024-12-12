#!/bin/bash

# This script converts programming files (like .c, .py, .txt) into PDFs so I can print them physically as a very primitive backup stategy :)
# Install:
# sudo apt-get install enscript
# sudo apt-get install ghostscript
# Usage: ./backup.sh file1.txt file2.py

# Function to convert a single file to PDF
convert_to_pdf() {
    input_file=$1
    output_file="${input_file%.*}.pdf"

    # Use enscript to convert the text file to PostScript
    # Remove unsupported options for page length and line spacing
    enscript --output=- --font=Courier8 "$input_file" | ps2pdf - "$output_file"

    echo "Converted $input_file to $output_file"
}

# Loop through all input files
for file in "$@"; do
    if [ -f "$file" ]; then
        convert_to_pdf "$file"
    else
        echo "File $file not found."
    fi
done
