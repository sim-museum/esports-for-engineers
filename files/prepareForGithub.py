import os

def is_allowed_file(filename, dirpath):
    allowed_suffixes = {'.py', '.sh'}
    # Check if the file is in the root or a child directory of the root
    is_in_root_or_child = dirpath == '.' or os.path.dirname(dirpath) == '.'
    if is_in_root_or_child:
        allowed_suffixes.update({'.txt', '.TXT', '.pdf'})
    return any(filename.endswith(suffix) for suffix in allowed_suffixes)

def cleanup_files_and_dirs():
    # Walk directory tree bottom-up to handle nested directories properly
    for dirpath, dirnames, filenames in os.walk('.', topdown=False):
        # Remove unwanted files
        for filename in filenames:
            filepath = os.path.join(dirpath, filename)
            if not is_allowed_file(filename, dirpath):
                try:
                    print(f"Deleting file: {filepath}")
                    os.remove(filepath)
                except OSError as e:
                    print(f"Error deleting {filepath}: {e}")
        
        # Try to remove empty directories
        try:
            # Check if directory is empty after file deletion
            if not os.listdir(dirpath) and dirpath != '.':
                print(f"Deleting empty directory: {dirpath}")
                os.rmdir(dirpath)
        except OSError as e:
            print(f"Error deleting directory {dirpath}: {e}")

if __name__ == "__main__":
    cleanup_files_and_dirs()

