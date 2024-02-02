import os

def get_files_with_extensions(directory_path, extensions):
    file_paths = []

    for root, dirs, files in os.walk(directory_path):
        for file in files:
            if file.endswith(tuple(extensions)):
                file_paths.append(os.path.join(root, file))

    return file_paths

# # Example usage:
# directory_path = "/path/to/your/directory"
# allowed_extensions = ['.pdf', '.txt', '.docx']
# result = get_files_with_extensions(directory_path, allowed_extensions)
# print(result)

# text_files = [f for f in os.listdir("/home/ubuntu/100_txt") if f.endswith(".txt")]

# print(text_files)