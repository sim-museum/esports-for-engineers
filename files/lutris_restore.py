import os
import shutil

def restore_lutris(backup_dir):
    # Define paths to restore
    config_dir = os.path.expanduser("~/.config/lutris")
    share_dir = os.path.expanduser("~/.local/share/lutris")

    # Restore ~/.config/lutris
    config_backup = os.path.join(backup_dir, "config")
    if os.path.exists(config_backup):
        shutil.copytree(config_backup, config_dir, dirs_exist_ok=True)
        print(f"Restored {config_backup} to {config_dir}")
    else:
        print(f"{config_backup} does not exist. Skipping...")

    # Restore ~/.local/share/lutris
    share_backup = os.path.join(backup_dir, "share")
    if os.path.exists(share_backup):
        shutil.copytree(share_backup, share_dir, dirs_exist_ok=True)
        print(f"Restored {share_backup} to {share_dir}")
    else:
        print(f"{share_backup} does not exist. Skipping...")

if __name__ == "__main__":
    # Specify the backup directory in the current working directory
    current_dir = os.getcwd()
    backup_directory = os.path.join(current_dir, "lutris_backup")
    
    restore_lutris(backup_directory)

