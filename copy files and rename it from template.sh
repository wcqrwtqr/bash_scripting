#!/usr/bin/env sh

# Define the source folder, template file, and target folder
# Make sure you run the bash script file from the same updated
# to avoid the issue of
source_folder="."
template_file="./main_empty_form.docx"
target_folder="./updated_folder"


# Loop through each .docx file in the source folder
for file in "$source_folder"/*.docx; do
    # Get the base name of the file (without extension)
    base_name=$(basename "$file" .docx)

    # Define the new file path in the target folder
    new_file="$target_folder/${base_name}.docx"

    # Copy the template file and rename it to the base name
    cp "$template_file" "$new_file"
done

echo "Template copies created successfully in $target_folder."
