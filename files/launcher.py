#!/usr/bin/python3

"""
Program overview:

1. **Imports and Setup**: The program starts by importing necessary libraries such as `sys`, `os`, `subprocess`, `datetime`, `timedelta`, `mean` from `statistics`, and `pandas`. These libraries are used for system operations, handling dates and times, statistical calculations, and data manipulation.

2. **Function Definitions**:
    - `list_select`: This function prints a numbered list of choices and prompts the user to select an option by entering the corresponding number.
    - `menu_choice`: This function displays a menu with a title and a list of choices, then prompts the user to select an option.
    - `read_scores`: This function reads scores from a CSV file, updates the scores and timestamps, and stores them in memory.
    - `is_convertible_to_float`: This function checks if a given value can be converted to a float.

3. **Loading Files**: The program loads two CSV files: `launcherTitles.csv` and `launcherScripts.csv`, which contain information about menu titles and corresponding scripts.

4. **Reading Scores**: It reads scores from the `launcherScores.csv` file, or creates a new one if it doesn't exist. The scores are stored in a DataFrame.

5. **Menu Display and User Interaction**:
    - The program displays a main menu with options to export scores, read documentation, reset scores, or exit.
    - If the user selects to export scores, it creates a compressed archive of relevant files and provides instructions for sharing.
    - If the user selects to read documentation, it displays instructions for calculating scores.
    - If the user selects to reset scores, it deletes the scores file and game output files.
    - If the user chooses to exit, the program terminates.

6. **Submenus and User Input**:
    - For each menu option, the program displays a submenu with additional choices specific to that option.
    - If the user selects to calculate a score, it displays instructions for the calculation.
    - If the user selects to enter a score, it prompts the user to input a score between 0 and 1, then saves the score along with relevant files.
    - If the user selects to launch a program, it executes the corresponding script.

7. **Program Execution**: The program executes the selected script, changing directories if necessary, and launching the specified program.

8. **Exiting the Program**: If the user chooses to exit at any point, the program terminates gracefully.

Overall, the program serves as a launcher for various scripts and tools related to eSports for Engineers. It provides a user-friendly interface for selecting actions, managing scores, and launching programs.
"""

import sys
import os
import subprocess
from datetime import datetime, timedelta
from statistics import mean
import pandas as pd


def list_select(my_list):
    # Function to print indexed list of choices and return the number picked by the user
    my_dict = {i + 1: item for i, item in enumerate(my_list)}
    for idx, val in my_dict.items():
        print(f"[{idx}] {val}")
    input_string = ""
    while not input_string.isdigit() or not 0 < int(input_string) <= len(my_list):
        input_string = input("\nChoose number listed above:")
    return int(input_string)


def menu_choice(title_string, choice_list):
    # Function to display menu title and choices, then return user selection
    os.system("clear")
    print(f"\n{title_string}\n")
    return list_select(choice_list)


def read_scores():
    # Function to read scores from file and update scores and timestamps
    # Ignore scores from more than a week ago
    one_week_ago = datetime.now() - timedelta(7)
    temp_df = pd.to_datetime(score_df['timeStamp']) - one_week_ago

    max_row = len(temp_df) - 1
    min_row = 0
    for i in range(max_row, -1, -1):
        if temp_df[i].total_seconds() < 0:
            min_row = i + 1
            break

    for i in range(max_row, min_row - 1, -1):
        if scores[score_df['day'][i]] == -1:
            scores[score_df['day'][i]] = score_df['score'][i]
            score_times[score_df['day'][i]] = pd.to_datetime(score_df['timeStamp'][i]).strftime("%Y-%m-%d_%H-%M-%S")


def is_convertible_to_float(value):
    # Function to check if a value can be converted to float
    try:
        float(value)
        return True
    except ValueError:
        return False


# Load files
titles_df = pd.read_csv('filesForLauncher/launcherTitles.csv')
titles_list = titles_df.columns.values.tolist()
titles_list.extend(['Export Scores and game output files', 'Read Documentation', 'Reset Scores', 'Exit'])

script_df = pd.read_csv('filesForLauncher/launcherScripts.csv')

# Read scores from filesForLauncher/launcherScores.csv, or create new scores
try:
    score_df = pd.read_csv('filesForLauncher/launcherScores.csv')
except FileNotFoundError:
    score_df = pd.DataFrame(columns=['timeStamp', 'day', 'score'])

# Initialize scores and timestamps
scores = [-1] * 7  # -1 indicates score has not been set
score_times = [""] * 7  # Timestamps corresponding to scores

# Display menus
while True:
    read_scores()  # Read scores from file
    scores = [max(x, 0) for x in scores]  # Remove any remaining -1 flags
    score_today = mean(scores)  # Calculate average score for the last 7 days
    title_string = f"eSports for Engineers\n\naverage score for last 7 days: {round(score_today, 3)}"
    day_int = menu_choice(title_string, titles_list) - 1  # Main menu selection

    # Main menu options
    if day_int == 7:  # Export scores and game output files
        current_time = datetime.now()
        time_string = current_time.strftime("%Y-%m-%d_%H-%M-%S")
        dir_string = f"eSportsForEngineers-24041LTS_{round(score_today, 3)}_{time_string}"
        os.mkdir(dir_string)  # Create directory for export
        for time_str in score_times:  # Copy relevant files to export directory
            if time_str:
                cmd_string = f"cp filesForLauncher/*{time_str}*.gz {dir_string}"
                os.system(cmd_string)
        cmd_string = f"tar czf {dir_string}.tar.gz {dir_string}"  # Compress export directory
        os.system(cmd_string)
        print("\nExported\n")
        cmd_string = f"sha256sum {dir_string}.tar.gz"  # Calculate SHA256 hash of export file
        os.system(cmd_string)
        cmd_string = f"rm -rf {dir_string}"  # Remove export directory
        os.system(cmd_string)
        print("\nTo compare scores with others on the eSports for Engineers forum")
        print("at fosstodon, send a link to this exported tar file, along with ")
        print("the validation code, to https://fosstodon.org/@esports_for_engineers.\n")
        sys.exit(0)

    if day_int == 8:  # Read Documentation
        os.system("more calculatingScore.txt")
        input("press Enter to continue:")
        continue

    if day_int == 9:  # Reset Scores
        print("\n")
        os.system("rm filesForLauncher/launcherScores.csv 2>/dev/null 1>/dev/null")  # Remove scores file
        os.system("rm filesForLauncher/*.gz 2>/dev/null 1>/dev/null")  # Remove game output files
        sys.exit(0)

    if day_int == 10:  # Exit
        print("\n")
        sys.exit(0)

    day_list_with_nan = titles_df.T.iloc[day_int]
    day_list = [x for x in day_list_with_nan if pd.notna(x)]
    day_list.append("Return to Main Menu")

    # Submenu
    reading_doc = True
    day_string = titles_list[day_int][0:3]
    while reading_doc:
        title_string = f"{titles_list[day_int]}\n\nCurrentScore: {round(scores[day_int], 3)}"
        script_int = menu_choice(title_string, day_list)

        if script_int == len(day_list) - 2:  # How to Calculate Score
            os.system(f"more {day_string}/calculatingScore.txt")
            input("press Enter to continue:")
            continue

        else:
            reading_doc = False

        if script_int == len(day_list):  # Return to Main Menu
            continue

        if script_int == len(day_list) - 1:  # Enter Score
            current_path = os.getcwd()
            cmd_string = f"{current_path}/{titles_list[day_int][0:3]}"
            os.chdir(cmd_string)
            os.system("./copyRecentFilesToAfterGameReport.sh")
            os.chdir(current_path)
            dir_string = f"{titles_list[day_int][0:3]}/afterGameReport"
            cmd_string = f"ls {dir_string}"
            result = subprocess.check_output(cmd_string, shell=True)
            if not result:
                print(f"\nBefore entering a score you must put at least one file in the {dir_string} directory.")
                print("For more information, select 'Read Documentation' from the main menu.\n")
                input("press Enter to continue:")
                continue
            print(f"\nFiles from {dir_string} to be added to score database:\n")
            os.system(cmd_string)
            print("\n")
            while True:
                input_string = input("\nEnter New Score (number between 0 and 1):")
                if is_convertible_to_float(input_string) and 0.0 <= float(input_string) <= 1.0:
                    break
            current_time = datetime.now()
            time_string = current_time.strftime("%Y-%m-%d_%H-%M-%S")
            day_score_string = str(round(float(input_string), 3))
            cmd_string = f"tar czf filesForLauncher/{titles_list[day_int][0:3]}_{day_score_string}_{time_string}.tar.gz {dir_string}"
            os.system(cmd_string)
            cmd_string = f"rm {dir_string}/*"
            os.system(cmd_string)

            new_row = {'timeStamp': current_time, 'day': day_int, 'score': float(input_string)}
            score_df = score_df.append(new_row, ignore_index=True)
            score_df.to_csv('filesForLauncher/launcherScores.csv', index=None)
            scores[day_int] = float(input_string)
            score_times[day_int] = time_string
            input("Press Enter to continue")
            continue

        # Launch Program
        maybe_path_string = script_df[day_string][script_int - 1]
        print(f"\nRunning {day_string}/{maybe_path_string}\n")
        input("press Enter to continue:")

        current_path = os.getcwd()
        path_test_list = maybe_path_string.split("/")
        if len(path_test_list) == 2:
            cmd_string = f"{current_path}/{day_string}/{path_test_list[0]}"
            launch_string = f"./{path_test_list[1]}"
        else:
            cmd_string = f"{current_path}/{day_string}"
            launch_string = f"./{script_df[day_string][script_int - 1]}"
        os.chdir(cmd_string)
        os.system(f"bash {launch_string}")
        sys.exit(0)

