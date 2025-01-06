#!/bin/bash

VENV_PATH="./ese_env"

# Check if virtual environment exists
if [ ! -d "$VENV_PATH" ]; then
    echo "Creating ese python virtual environment..."
    python3 -m venv "$VENV_PATH"
fi

# Check if already activated
if [[ "$VIRTUAL_ENV" != "" ]]; then
    echo "ese pythom virtual environment already activated: $VIRTUAL_ENV"
else
    echo "Activating virtual environment..."
    source "$VENV_PATH/bin/activate"
fi

if ! python3 -c "import sympy" 2>/dev/null; then
    echo "Installing sympy..."
    pip install sympy
else
    echo "sympy is already installed"
fi

if ! python3 -c "import numpy" 2>/dev/null; then
    echo "Installing numpy..."
    pip install numpy
else
    echo "numpy is already installed"
fi

if ! python3 -c "import matplotlib" 2>/dev/null; then
    echo "Installing matplotlib ..."
    pip install matplotlib
else
    echo "matplotlib is already installed"
fi


python3 quiz.py
