#!/bin/bash
clear
# Function to check if ps-eval is working
check_ps_eval() {
    if [[ -x "./ps-eval" ]]; then
        # Capture the output of ps-eval
        output=$(./ps-eval 2>&1)
        # Check if the output contains the expected string
        if [[ "$output" == *"ps-eval, a poker hand evaluator"* ]]; then
            echo "ps-eval is present and working."
            return 0
        else
            echo "ps-eval exists but is not working as expected."
            return 1
        fi
    else
        echo "ps-eval is not present or not executable."
        return 1
    fi
}

# Main script logic
if ! check_ps_eval; then
    # If ps-eval exists but is not working, delete it
    if [[ -e "./ps-eval" ]]; then
        echo "Deleting existing ps-eval..."
        rm -f "./ps-eval"
    fi

    # Navigate to the INSTALL directory
    INSTALL_DIR="./INSTALL"
    if [[ -d "$INSTALL_DIR" ]]; then
        echo "Navigating to INSTALL directory..."
        cd "$INSTALL_DIR" || { echo "Failed to navigate to INSTALL directory."; exit 1; }
    else
        echo "INSTALL directory does not exist. Exiting."
        exit 1
    fi

    # Run the Python script to create a symbolic link to ps-eval in the current directory's parent directory
    PYTHON_SCRIPT="install_ps_eval.py"
    if [[ -f "$PYTHON_SCRIPT" ]]; then
        echo "Running Python script to set up ps-eval..."
        python3 "$PYTHON_SCRIPT" || { echo "Python script failed. Exiting."; exit 1; }
    else
        echo "Python script $PYTHON_SCRIPT not found in INSTALL directory. Exiting."
        exit 1;
    fi

    # Return to the original directory after setup
    cd - || { echo "Failed to return to the original directory."; exit 1; }
else
    echo "No action needed. ps-eval is already set up correctly."
fi

echo ""
echo ""
echo "ps-eval: text mode poker equity calculator, works with Texas Hold em, Omaha, Stud, Draw\n"
echo "    Allowed options:"
echo "      -? [ --help ]          produce help message"
echo "      -g [ --game ] arg (=h) game to use for evaluation"
echo "      -b [ --board ] arg     community cards for he/o/o8"
echo "      -h [ --hand ] arg      a hand for evaluation"
echo "      -q [ --quiet ]         produce no output"
echo ""
echo "       For the --game option, one of the follwing games may be"
echo "       specified."
echo "         h     hold'em"
echo "         o     omaha/8"
echo "         O     omaha high"
echo "         r     razz"
echo "         s     stud"
echo "         e     stud/8"
echo "         q     stud high/low no qualifier"
echo "         d     draw high"
echo "         l     lowball (A-5)"
echo "         k     Kansas City lowball (2-7)"
echo "         t     triple draw lowball (2-7)"
echo "         T     triple draw lowball (A-5)"
echo "         b     badugi"
echo "         3     three-card poker"
echo ""
echo "       examples:"
echo "           ./ps-eval acas"
echo "           ./ps-eval AcAs Kh4d --board 5c8s9h"
echo "           ./ps-eval AcAs Kh4d --board 5c8s9h"
echo "           ./ps-eval --game l 7c5c4c3c2c"
echo "           ./ps-eval --game k 7c5c4c3c2c"
echo "           ./ps-eval --game kansas-city-lowball 7c5c4c3c2c"
echo ""
echo "./ps-eval can take a couple minutes to produce output"


