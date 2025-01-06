#!/bin/bash

# Clear the screen at the start
clear

# Define variables for readability
export INSTALL_DIR="$PWD/INSTALL"
export WINEPREFIX_DIR="$PWD/WP"
export KATRAIN_DIR="$WINEPREFIX_DIR/../KaTrain"
export DOC_DIR="$WINEPREFIX_DIR/../DOC"
export VENV_DIR="$PWD/venv"

# Ensure virtual environment exists
if [ ! -d "$VENV_DIR" ]; then
    echo "Setting up Python virtual environment..."
    echo
    python3 -m venv "$VENV_DIR" 2>/dev/null
fi

# Activate virtual environment
source "$VENV_DIR/bin/activate" 2>/dev/null

# Install or update KaTrain via pip
echo "Installing or updating KaTrain via pip..."
echo
pip3 install -U katrain >/dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "KaTrain installed or updated successfully."
else
    echo "Failed to install or update KaTrain. Exiting."
    exit 1
fi

echo

# Print information about the engine and network files location
KATRAIN_DATA_DIR=$(python3 -c "import os; from katrain.core.constants import DATA_FOLDER; print(os.path.expanduser(DATA_FOLDER))" 2>/dev/null)
if [ -d "$KATRAIN_DATA_DIR" ]; then
    echo "KataGo engines and network files are located in:"
    echo "$KATRAIN_DATA_DIR"
    echo
    echo "These engines and network files can also be used with other Go software such as Sabaki and Q5Go."
else
    echo "Unable to locate KataGo engines and network files."
    echo "They will be available after installing KaTrain."
fi

echo

# Example: Using a KaTrain engine with Sabaki
echo "Example: Using a KaTrain engine with Sabaki"
echo
echo "1. Navigate to your KaTrain data directory:"
echo "   cd $KATRAIN_DATA_DIR"
echo
echo "2. Generate a configuration file for KataGo using one of the models:"
echo "   ./katago-v1.15.3-opencl-linux-x64 genconfig -model g170e-b15c192-s1672170752-d466197061.txt.gz"
echo
echo "   This will create a 'gtp.cfg' file in the same directory."
echo
echo "3. Open Sabaki and configure KataGo as follows:"
echo "   - Model: KataGo"
echo "   - Path: $KATRAIN_DATA_DIR/katago-v1.15.3-opencl-linux-x64"
echo "   - Arguments: gtp -model 'g170e-b15c192-s1672170752-d466197061.txt.gz' -config 'gtp.cfg'"
echo
echo "This setup will allow you to use the KataGo engine installed with KaTrain in Sabaki."
echo

# Inform the user about the execution flow
echo "The program will now prompt you to choose which version of KaTrain to run."
echo
echo "You can choose between:"
echo "1) The Linux native version of KaTrain (installed via pip)."
echo "2) The Windows version of KaTrain (run via Wine)."
echo

# Prompt the user to choose which version of KaTrain to run
read -p "Enter your choice (1 for Linux native, 2 for Windows version): " USER_CHOICE

if [ "$USER_CHOICE" -eq 1 ]; then
    # Run the Linux native version of KaTrain
    echo
    echo "Running Linux native version of KaTrain..."
    echo
    katrain >/dev/null 2>&1 &
    KATRAIN_PID=$!
    
    # Wait briefly to ensure it starts successfully
    sleep 5
    
    if ps -p $KATRAIN_PID > /dev/null; then
        echo "KaTrain (Linux native version) is running successfully."
        wait $KATRAIN_PID  # Wait for the process to finish before exiting
    else
        echo "KaTrain (Linux native version) failed to start. Please check your installation."
        exit 1
    fi

elif [ "$USER_CHOICE" -eq 2 ]; then
    # Set up Wine environment and run the Windows version of KaTrain
    echo
    echo "Setting up Wine environment for Windows version of KaTrain..."
    echo
    
    export WINEARCH=win64
    export WINEPREFIX=$WINEPREFIX_DIR
    wine winecfg -v win10 >/dev/null 2>&1

    # Change directory to KaTrain installation directory and run KaTrain.exe using Wine
    cd "$KATRAIN_DIR" || { 
        echo "KaTrain directory not found. Exiting."; 
        exit 1; 
    }
    
    echo "Running Windows version of KaTrain using Wine..."
    echo
    
    wine KaTrain.exe >/dev/null 2>&1
    
    if [ $? -ne 0 ]; then
        echo "KaTrain (Windows version) failed to start. Please check your installation."
        exit 1
    fi

else
    echo 
    echo "Invalid choice. Exiting."
    exit 1
fi

echo

# Print out credits (optional, but redirected to /dev/null as per requirements)
cat "$DOC_DIR/KaTrainDoc.txt" >/dev/null 2>&1

printf "\n\nKaTrain tip: To change KataGo engines, click the menu at top left, select General Engine Settings,\nselect download engines, and then pick one of these engines to install.\n\n" >/dev/null 2>&1


