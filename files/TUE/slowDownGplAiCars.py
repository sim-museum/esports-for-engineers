#!/usr/bin/python3

"""
This script, 'slowDownGplAiCars.py', is designed to reduce the speed of AI-controlled cars in a racing game. 
It accomplishes this by modifying configuration files ('.ini' files) located in the './tracks' directory. 
The user inputs a percentage value indicating the desired reduction in AI car speed, with 100 indicating 
the default speed and 0 meaning the AI cars do not move at all.

The script consists of two main functions:

1. `replace_dlong_speed_adj_coeff(input_number, file_path)`: 
   This function replaces the 'dlong_speed_adj_coeff' value in the specified '.ini' file with a new value 
   calculated based on the input percentage. If the line contains a default value, it retains the original 
   default value in a comment for reference.

2. `process_ini_files(input_number)`: 
   This function iterates through all '.ini' files in the './tracks' directory (including subdirectories), 
   applying the speed adjustment to each file by calling `replace_dlong_speed_adj_coeff()`.

The script execution starts in the '__main__' block where the user is prompted to input a percentage value. 
If the input is valid (between 0 and 100), the `process_ini_files()` function is invoked to adjust the AI 
car speeds in all configuration files. Otherwise, an error message is displayed.

"""

import os
import re

def replace_dlong_speed_adj_coeff(input_number, file_path):
    """
    Replace the 'dlong_speed_adj_coeff' value in the specified '.ini' file with a new value calculated 
    based on the input percentage. If the line contains a default value, it retains the original default 
    value in a comment for reference.

    Args:
        input_number (float): The percentage value indicating the desired reduction in AI car speed.
        file_path (str): The path to the '.ini' file to be processed.
    """
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
        lines = file.readlines()

    with open(file_path, 'w', encoding='utf-8') as file:
        for line in lines:
            match = re.match(r'(dlong_speed_adj_coeff\s*=\s*)([-+]?\d*\.\d+|\d+)(\s*;\s*default:\s*)?([-+]?\d*\.\d+|\d+)?', line)
            if match:
                original_number = float(match.group(2))
                if match.group(4):  # If the line contains '; default: <original number>'
                    original_default_number = float(match.group(4))
                    new_number = original_default_number * input_number / 100
                    file.write(f'{match.group(1)}{new_number:.6f} ; default: {original_default_number}\n')
                else:
                    new_number = original_number * input_number / 100
                    file.write(f'{match.group(1)}{new_number:.6f} ; default: {original_number}\n')
            else:
                file.write(line)

def process_ini_files(input_number):
    """
    Iterate through all '.ini' files in the './WP/drive_c/Sierra/GPL/tracks' directory (including subdirectories), 
    applying the speed adjustment to each file.

    Args:
        input_number (float): The percentage value indicating the desired reduction in AI car speed.
    """
    tracks_dir = "./WP/drive_c/Sierra/GPL/tracks"
    if not os.path.exists(tracks_dir):
        print("Error: Run gpl.sh first to install GPL")
        return
    
    for dirpath, _, filenames in os.walk(tracks_dir):
        for filename in filenames:

            if filename.endswith('.ini') and os.path.isfile(os.path.join(dirpath, filename)):
#                print(f"Processing file: {os.path.join(dirpath, filename)}")
                replace_dlong_speed_adj_coeff(input_number, os.path.join(dirpath, filename))

if __name__ == "__main__":
    os.system('clear')
    print("slowDownGplAiCars.py:\n")
    print("Reduce the speed of the AI cars, for all mods and tracks.")
    print("Input percentage reduction in the AI speed coefficient, where")
    print("100 means default speed and 0 means AI cars don't move at all.\n")
    input_number = float(input("Enter a number between 0 and 100: "))
    if 0 <= input_number <= 100:
        process_ini_files(input_number)
        print("\nAI car speeds adjusted successfully for all mods and tracks.")
    else:
        print("Input percentage of default AI car speed (number must be between 0 and 100):")
