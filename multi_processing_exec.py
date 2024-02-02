from concurrent.futures import ProcessPoolExecutor
from path_finder import get_files_with_extensions
from spacy_functions import identify_entities

# Specifying the allowed file extensions
allowed_extensions = ['.txt']

# Defining the directory path where the files are located
path = "/home/axat/work/spacy-with-celery/txt"

# Obtaining the paths of files with allowed extensions in the specified directory
file_paths = get_files_with_extensions(path, allowed_extensions)

def process_file(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            print (file_path, "/n/n/n")
            text_content = file.read()
            # Using SpaCy function on the text content
            entities = identify_entities(text_content)
            print (entities)

            # You can add additional processing here if needed

    except Exception as e:
        # Handle exceptions, e.g., log the error
        print(f"Error processing file: {file_path}, Error: {e}")

# Using ProcessPoolExecutor for concurrent processing
with ProcessPoolExecutor() as executor:
    # Applying the task asynchronously for each file path
    executor.map(process_file, file_paths)
