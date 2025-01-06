import os
import shutil

def backup_lutris(backup_dir):
    # Define paths to backup
    config_dir = os.path.expanduser("~/.config/lutris")
    share_dir = os.path.expanduser("~/.local/share/lutris")

    # Ensure backup directory exists
    os.makedirs(backup_dir, exist_ok=True)

    # Backup ~/.config/lutris
    config_backup = os.path.join(backup_dir, "config")
    if os.path.exists(config_dir):
        shutil.copytree(config_dir, config_backup, dirs_exist_ok=True)
        print(f"Backed up {config_dir} to {config_backup}")
    else:
        print(f"{config_dir} does not exist. Skipping...")

    # Backup ~/.local/share/lutris
    share_backup = os.path.join(backup_dir, "share")
    if os.path.exists(share_dir):
        shutil.copytree(share_dir, share_backup, dirs_exist_ok=True)
        print(f"Backed up {share_dir} to {share_backup}")
    else:
        print(f"{share_dir} does not exist. Skipping...")

if __name__ == "__main__":
    # Specify the backup directory in the current working directory
    current_dir = os.getcwd()
    backup_directory = os.path.join(current_dir, "lutris_backup")
    
    backup_lutris(backup_directory)

