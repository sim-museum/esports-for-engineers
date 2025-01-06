"""

By default, GPL puts you in a race with the first 5 drivers in the appropriate .ini file.  You always
race against these 5 drivers, who are the fastest.  randomizeDrivers.py resorts the driver list,
puting the best 5 drivers last, and randomizing the other 14, such that you race different
opponents each time, and only face the top 5 drivers if you select to race against more than 14 computer
opponents.

Code overview:

        Command Line Argument Check: It checks whether a file name was provided as a command line argument when running the script. If no file name is provided, it prints a usage message and exits.

    File Existence Check: It checks if the provided file exists in the current directory. If the file does not exist, it prints a message indicating that the file was not found and exits.

    List Generation and Manipulation:
        It generates a list of numbers from 1 to 19.
        It reverses the order of the list.
        It separates the first 5 numbers from the rest of the list.
        It shuffles the rest of the list randomly.

    Command Construction:
        It constructs a command string to read the contents of the file specified in the command line argument and modify the driver names.
        It uses the sed command to replace occurrences of driver_X with driver_Y, where X is a sequential number and Y is an uppercase letter from 'A' to 'S'.

    Command Execution: It executes the constructed command using os.system() to display the modified contents of the file.
"""
import sys
import random
import os

def main():
    # Check that a file name was provided as a command line argument
    if len(sys.argv) < 2:
        print("Usage: python3 randomizeDrivers.py <name of driver.ini file>")
        sys.exit(1)

    # Extract the file name from command line arguments
    fname = sys.argv[1]

    # Check if the file exists in the current directory
    if not os.path.isfile(fname):
        print(f"{fname}: file not found.")
        sys.exit(1)

    # Generate a list of numbers from 1 to 19
    myL = list(range(1, 20))

    # Reverse the order of the list
    myL.reverse()

    # Take the first 5 numbers in reversed list; the top 5 drivers are assigned slots 15-19
    firstL = myL[:5]

    # Put the rest of the numbers in a different list
    restL = myL[5:]

    # Randomize the order of the remaining numbers
    random.shuffle(restL)

    # Put the randomized slower drivers first, and the top 5 drivers last
    resultL = firstL + restL

    # Construct the command to read the contents of the file and modify the driver names
    myCmd = f"cat {fname} "

    # Define a string containing uppercase letters
    myString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    # Iterate over the result list to modify driver names using sed command
    for i in range(1, len(resultL) + 1):
        myCmd += f"| sed 's/driver_{i} /driver_{myString[resultL[i - 1] - 1]} /' "

    # Iterate over the result list again to reverse the modification
    for i in range(1, len(resultL) + 1):
        myCmd += f"| sed 's/driver_{myString[i - 1]} /driver_{i} /' "

    # Execute the constructed command to display the modified contents of the file
    os.system(myCmd)

if __name__ == "__main__":
    main()

