#!/usr/bin/python3
"""
This program, setRaceLaps.py, is designed to revise the configuration
files (.ini files) for a set of races in Grand Prix Legends
(GPL). Specifically, it allows the user to adjust the number of laps
for each race by modifying the 'numberOfLaps' parameter in the
respective .ini files.

The user is prompted to input an integer between 0 and 20. Based on
this input, the program adjusts the number of laps for each race
accordingly. If the input is 0, the program resets the number of laps
to the original default value specified in the .ini files. If the
input is a positive integer, it calculates a new value for the number
of laps based on the input and updates the .ini files accordingly.

The program iterates through all .ini files located in the specified
directory and identifies lines containing the 'numberOfLaps'
parameter. It then adjusts these lines based on the user input and
writes the revised content back to the files.

"""

import os

def revise_ini_files(input_integer):
    # Validate input
    if not (0 <= input_integer <= 20):
        print("Input integer must be between 0 and 20")
        return

    # Directory containing the .ini files
    directory = "./WP/drive_c/Sierra/GPL/seasons/"
    # File extension for .ini files
    suffix = ".ini"

    # Iterate through files in the directory
    for filename in os.listdir(directory):
        if filename.endswith(suffix):
            filepath = os.path.join(directory, filename)
            lines = []

            # Read lines from the file with explicit encoding specification
            with open(filepath, "r", encoding="latin-1") as file:
                for line in file:
                    # Check if line starts with "numberOfLaps="
                    if line.strip().startswith("numberOfLaps="):
                        original_integer = int(line.split("=")[1].split(";")[0].strip())
                        if input_integer > 0:
                            # Case 1: input_integer > 0
                            revised_integer = int((input_integer + 0.15) / 0.15)
                            lines.append(f"numberOfLaps={revised_integer} ; default {original_integer}\n")
                        else:
                            # Case 2: input_integer == 0
                            default_integer = original_integer
                            if "; default" in line:
                                default_integer = int(line.split("; default")[1].strip())
                            lines.append(f"numberOfLaps={default_integer} ; default {default_integer}\n")
                    else:
                        lines.append(line)

            # Write revised lines back to the file
            with open(filepath, "w", encoding="latin-1") as file:
                file.writelines(lines)

    print("All GPL season .ini files revised successfully.")

# Clear the terminal screen
os.system('clear')
print("setRaceLaps.py\n")
print("Set the number of laps for all GPL races.  Enter 0 to")
print("set race lengths to the original default.  Enter a")
print("positive number to set the length of the novice race\n")

# Prompt user for input
input_integer = int(input("Enter an integer between 0 and 20: "))
# Call the function to revise .ini files based on user input
revise_ini_files(input_integer)
