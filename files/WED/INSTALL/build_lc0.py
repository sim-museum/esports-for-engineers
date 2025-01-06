import os
import subprocess
import requests

def install_dependencies():
    """Install required dependencies for building Lc0."""
    print("Installing dependencies...")
    subprocess.run([
        "sudo", "apt-get", "update"
    ], check=True)
    subprocess.run([
        "sudo", "apt-get", "install", "-y",
        "git", "ninja-build", "meson", "protobuf-compiler",
        "libprotobuf-dev", "libopenblas-dev", "clang",
        "libstdc++-14-dev", "wget", "build-essential",
        "cmake", "zlib1g-dev"
    ], check=True)

def is_gpu_available():
    """Check if a compatible GPU is available."""
    try:
        result = subprocess.run(["nvidia-smi"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return result.returncode == 0
    except FileNotFoundError:
        return False

def clone_lc0_repo():
    """Clone the Lc0 repository."""
    print("Cloning Lc0 repository...")
    if not os.path.exists("lc0"):
        subprocess.run([
            "git", "clone", "--recurse-submodules",
            "-b", "release/0.31",
            "https://github.com/LeelaChessZero/lc0.git"
        ], check=True)
    else:
        print("Lc0 repository already exists.")

def build_lc0(cpu=True, gpu=False):
    """Build Lc0 for CPU and/or GPU."""
    os.chdir("lc0")
    
    # Create build directory if it doesn't exist
    build_dir = os.path.join(os.getcwd(), "build/release")
    if not os.path.exists(build_dir):
        os.makedirs(build_dir)

    # Run Meson setup
    print("Configuring build with Meson...")
    subprocess.run(["meson", "setup", "--buildtype=release", build_dir], check=True)

    # Build CPU version
    if cpu:
        print("Building Lc0 for CPU...")
        subprocess.run(["ninja", "-C", build_dir], check=True)

    # Build GPU version (if applicable)
    if gpu:
        print("Building Lc0 for GPU...")
        subprocess.run(["ninja", "-C", build_dir], check=True)
    
    os.chdir("..")

def download_small_weight_file():
    """Download a small weight file for Lc0."""
    weights_url = "https://lczero.org/files/networks/weights_11248.pb.gz"  # Example small weight file
    weights_file = "weights_11248.pb.gz"

    if not os.path.exists(weights_file):
        print(f"Downloading small weight file from {weights_url}...")
        response = requests.get(weights_url, stream=True)
        if response.status_code == 200:
            with open(weights_file, "wb") as f:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)
            print(f"Downloaded weight file: {weights_file}")
        else:
            print(f"Failed to download weight file. HTTP Status Code: {response.status_code}")
            exit(1)  # Exit if the download fails
    else:
        print(f"Weight file {weights_file} already exists.")

def download_nibbler():
    """Download and set up Nibbler GUI."""
    print("Downloading Nibbler...")
    if not os.path.exists("Nibbler"):
        subprocess.run([
            "git", "clone",
            "https://github.com/forestdussault/Nibbler.git"
        ], check=True)
    else:
        print("Nibbler repository already exists.")

def main():
    # Step 1: Install dependencies
    install_dependencies()

    # Step 2: Check for GPU availability
    gpu_available = is_gpu_available()
    
    if gpu_available:
        print("GPU detected. Building both CPU and GPU versions of Lc0.")
        # Install CUDA dependencies
        subprocess.run([
            "sudo", "apt-get", "install", "-y",
            "nvidia-cuda-toolkit"
        ], check=True)
    else:
        print("No GPU detected. Building only the CPU version of Lc0.")

    # Step 3: Clone and build Lc0
    clone_lc0_repo()
    build_lc0(cpu=True, gpu=gpu_available)

    # Step 4: Download a small weight file
    download_small_weight_file()

    # Step 5: Download Nibbler GUI
    download_nibbler()

    # Final Instructions
    print("\nSetup complete!")
    print("\nTo use the compiled Lc0 engine with Nibbler:")
    print("1. Open Nibbler.")
    print("2. Go to 'Engine -> Choose engine...' and select the compiled 'lc0' binary.")
    print("   - The CPU binary is located in 'lc0/build/release'.")
    
    if gpu_available:
        print("   - The GPU binary is also located in 'lc0/build/release'.")
    
    print("3. Load the downloaded weight file (weights_11248.pb.gz) in Nibbler.")
    print("   - In Nibbler, go to 'Engine -> Engine settings...' and specify the path to the weights file.")
    

if __name__ == "__main__":
    main()

