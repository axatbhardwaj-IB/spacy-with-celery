# executor.py
from celery import Celery
from path_finder import get_files_with_extensions
from spacy_functions import identify_entities

# Specifying the allowed file extensions
allowed_extensions = ['.txt']

# Defining the directory path where the files are located
path = "/home/axat/work/spacy-with-celery/txt"

# Obtaining the paths of files with allowed extensions in the specified directory
file_paths = get_files_with_extensions(path, allowed_extensions)

# Initializing Celery
app = Celery('tasks', broker='pyamqp://guest@localhost//')

# Applying the Celery task asynchronously for each file path
for file_path in file_paths:
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            text_content = file.read()
            identify_entities.apply_async(args=[text_content])
    except Exception as e:
        # Handle exceptions, e.g., log the error
        print(f"Error processing file: {file_path}, Error: {e}")
