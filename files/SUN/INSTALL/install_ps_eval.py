import os
import subprocess
import sys

def run_command(command, cwd=None):
    """Run a shell command and exit if it fails."""
    try:
        subprocess.run(command, shell=True, check=True, cwd=cwd)
    except subprocess.CalledProcessError as e:
        print(f"Error: Command '{command}' failed with exit code {e.returncode}")
        sys.exit(1)

def main():
    # Step 1: Install dependencies
    print("Installing dependencies...")
    run_command("sudo apt update && sudo apt install -y git cmake libboost-all-dev")

    # Step 2: Clone PokerStove repository
    print("Cloning PokerStove repository...")
    if not os.path.exists("pokerstove"):
        run_command("git clone https://github.com/andrewprock/pokerstove.git")

    # Step 3: Build PokerStove
    print("Building PokerStove...")
    build_dir = "pokerstove/build"
    os.makedirs(build_dir, exist_ok=True)
    run_command("cmake -DCMAKE_BUILD_TYPE=Release ..", cwd=build_dir)
    run_command("cmake --build . --target all -j$(nproc)", cwd=build_dir)

    # Step 4: Create symbolic link to ps-eval in the parent directory
    print("Creating symbolic link to ps-eval...")
    current_dir = os.getcwd()
    parent_dir = os.path.abspath(os.path.join(current_dir, os.pardir))
    ps_eval_path = os.path.join(current_dir, build_dir, "bin", "ps-eval")
    symlink_path = os.path.join(parent_dir, "ps-eval")

    if not os.path.isfile(ps_eval_path):
        print(f"Error: ps-eval binary not found at {ps_eval_path}")
        sys.exit(1)

    if os.path.islink(symlink_path) or os.path.exists(symlink_path):
        os.remove(symlink_path)  # Remove existing file or symlink

    os.symlink(ps_eval_path, symlink_path)
    print(f"Symbolic link created at {symlink_path}, pointing to {ps_eval_path}")

if __name__ == "__main__":
    main()

