#!/usr/bin/python3
#
# launcher.py organizes the many options available for the user, and provides
# a means to send recorded game sessions to others.
#
# File names are description, and contain the relevant score, either the score 
# for a particular day or the cummulative weekly score, and a time stamp.
#
# It is the user's responsibility to save the game after playing
# chess, Weiqi or Bridge, and to record each sim session.
#
# launcher.py will automatically collect all such game records that were
# saved in the default locations within two hours of recording a score in 
# launcher.py.  
#
# Optional: the user may put any additional information into the 
# afterGameReport directory, such as game screenshots from ~/Pictures or
# a text file explanation of what happened during a game session.
# 
# To participate in the eSports for Engineers community on fosstodon,
# follow 
# https://fosstodon.org/@esports_for_engineers
# and send a link to your exported tar file, along with the sha256sum
# verification code produced by launcher.py, to @esports_for_engineers
# on fosstodon.
#
# January 2021

import sys, os, subprocess

import datetime as dt
from statistics import mean
import pandas as pd

#try:
#    import pandas as pd
#except:
#    print("\nYou must install the python3 pandas module before you can run the launcher.")
#    print("In Ubuntu 20.04 LTS, the command to install this module is:\n")
#    print("sudo apt install -y python3-pandas\n")
#    print("To install this module and all other libraries needed by eSports for Engineers,")
#    print("run the supplied installation shell script as follows:\n")
#    print("./ubuntu_20_04_LTS_PackageInstall.sh\n")
#    sys.exit(1)

def listSelect(myL):
    # print indexed list of choices, return number picked by user 
    myDict= { i+1 : myL[i] for i in range (0, len(myL)) }
    for i, val in myDict.items():
        print("[%d] %s" % (i, val))
    inputString=""
    while not inputString.isdigit() or not 0 < int(inputString) <= len(myL) :
        inputString=input("\nChoose number listed above:")
    return int(inputString)

def menuChoice(titleString, choiceList):
    res=os.system("clear")
    print("\n"+titleString+"\n")
    return listSelect(choiceList)

def readScores():
# ignore scores from more than a week ago
    oneWeekAgo=dt.datetime.now()-dt.timedelta(7)
    tempDF=pd.to_datetime(scoreDF['timeStamp'])-oneWeekAgo

    maxRow=len(tempDF)-1
    minRow=0
    for i in range(maxRow,-1,-1):
        if tempDF[i].total_seconds()<0:
            minRow=i+1
            break

    for i in range(maxRow,minRow-1,-1):
        if scores[scoreDF['day'][i]]==-1:
            scores[scoreDF['day'][i]]=scoreDF['score'][i]
            scoreTimes[scoreDF['day'][i]]=pd.to_datetime(scoreDF['timeStamp'][i]).strftime("%Y-%m-%d_%H-%M-%S")

def isConvertableToFloat(value):
    try:
        float(value)
        return True
    except:
        return False

# load files
titlesDF=pd.read_csv('filesForLauncher/launcherTitles.csv')
titlesList=titlesDF.columns.values.tolist()
titlesList.append('Export Scores and game output files')
titlesList.append('Read Documentation')
titlesList.append('Reset Scores')
titlesList.append('Exit')

scriptDF=pd.read_csv('filesForLauncher/launcherScripts.csv')

# read scores from filesForLauncher/launcherScores.csv, or create new scores
# table in csv doesn't exist
try:
    scoreDF=pd.read_csv('filesForLauncher/launcherScores.csv')
except:
    scoreDF=pd.DataFrame(columns = ['timeStamp', 'day', 'score'])


# initialize 
# -1 is flag that score has not been set
scores=[-1,-1,-1,-1,-1,-1,-1]
scoreTimes=["","","","","","",""]

# display menus
while True:
    readScores()
    # remove any remaining -1 flags
    scores=[max(x,0) for x in scores]
# main menu
    scoreToday=mean(scores)
    titleString="eSports for Engineers\n\naverage score for last 7 days: "+str(round(scoreToday,3))
    dayInt=menuChoice(titleString,titlesList)-1
    if dayInt==7:
        currentTime=dt.datetime.now()
        timeString=currentTime.strftime("%Y-%m-%d_%H-%M-%S")
        dirString="eSportsForEngineers-2204LTS_"+str(round(scoreToday,3))+"_"+timeString
        cmdString="mkdir "+dirString
        res=os.system(cmdString)
        for timeString in scoreTimes:
            if len(timeString)>0:
                cmdString="cp filesForLauncher/*"+timeString+"*.gz "+dirString
                res=os.system(cmdString)
        cmdString="tar czf "+dirString+".tar.gz "+dirString
        res=os.system(cmdString)

        print("\nExported\n")
        cmdString="sha256sum "+dirString+".tar.gz"
        res=os.system(cmdString)
        cmdString="rm -rf "+dirString
        res=os.system(cmdString)
        print("\nTo compare scores with others on the eSports for Engineers forum")
        print("at fosstodon, send a link to this exported tar file, along with ")
        print("the validation code, to https://fosstodon.org/@esports_for_engineers.\n")
        sys.exit(0)
    if dayInt==8:
       res=os.system("more calculatingScore.txt")
       replyString=input("press Enter to continue:")
       continue
    if dayInt==9:
       print("\n")
       res=os.system("rm filesForLauncher/launcherScores.csv 2>/dev/null 1>/dev/null")
       res=os.system("rm filesForLauncher/*.gz 2>/dev/null 1>/dev/null")
       sys.exit(0)
    if dayInt==10:  # requesting to exit
       print("\n")
       sys.exit(0)

    dayListWithNaN=titlesDF.T.iloc[dayInt]
    dayList = [x for x in dayListWithNaN if str(x) != 'nan']
    dayList.append("Return to Main Menu")

# 2nd level menu
    readingDoc=True
    dayString=titlesList[dayInt][0:3]   
    while readingDoc:
#debug
        print(titlesList)
#debug
        titleString=titlesList[dayInt]+"\n\nCurrentScore: "+str(round(scores[dayInt],3))
        scriptInt=menuChoice(titleString,dayList)

        if scriptInt==len(dayList)-2: # user selected how to calculate score 
            cmdString="more "+dayString+"/calculatingScore.txt"
            res=os.system(cmdString)   
            replyString=input("press Enter to continue:")
            continue
        else:
            readingDoc=False

        if scriptInt==len(dayList): # user selected return to main menu
            continue

        if scriptInt==len(dayList)-1: # user selected enter score
            currentPath=os.getcwd()
            cmdString=currentPath+"/"+titlesList[dayInt][0:3]
            os.chdir(cmdString)
            res=os.system("./copyRecentFilesToAfterGameReport.sh")
            os.chdir(currentPath)
            dirString=titlesList[dayInt][0:3]+"/afterGameReport"
            cmdString="ls "+ dirString
            result=subprocess.check_output(cmdString, shell=True)
            if len(result)==0:
                print("\nBefore entering a score you must put at least one file in the "+dirString+" directory.")
                print("For more information, select 'Read Documentation' from the main menu.\n")
                replyString=input("press Enter to continue:")
                continue
            print("\nFiles from "+dirString+" to be added to score database:\n")
            res=os.system(cmdString)
            print("\n")
            inputString=""
            while not isConvertableToFloat(inputString) or not 0.0 <= float(inputString) <= 1.0:
                inputString=input("\nEnter New Score (number between 0 and 1):")
            currentTime=dt.datetime.now()
            timeString=currentTime.strftime("%Y-%m-%d_%H-%M-%S")
            dayScoreString=str(round(float(inputString),3))
            cmdString="tar czf filesForLauncher/"+titlesList[dayInt][0:3]+"_"+dayScoreString+"_"+timeString+".tar.gz "+dirString
            res=os.system(cmdString)
            cmdString="rm "+dirString+"/*"
            res=os.system(cmdString)
 
            newRow={'timeStamp':currentTime,'day':dayInt, 'score':float(inputString)}
            scoreDF=scoreDF.append(newRow, ignore_index=True)
            scoreDF.to_csv('filesForLauncher/launcherScores.csv',index=None)
            scores[dayInt]=float(inputString)
            scoreTimes[dayInt]=timeString
            inputString2=input("Press Enter to continue")
            continue


        if scriptInt==len(dayList)-2: # user selected how to calculate score 
            cmdString="more "+dayString+"/calculatingScore.txt"
            res=os.system(cmdString)   
            continue

# otherwise, launch program specified by user       
        maybePathString=scriptDF[dayString][scriptInt-1]

        print("\nRunning "+dayString+"/"+maybePathString+"\n")       
        replyString=input("press Enter to continue:")

        currentPath=os.getcwd()
        pathTestList=maybePathString.split("/")
        if len(pathTestList)==2:  # deal with THU corner case where there are 2 subdirectories
            cmdString=currentPath+"/"+dayString+"/"+pathTestList[0]
            launchString="./"+pathTestList[1]
        else:
            cmdString=currentPath+"/"+dayString
            launchString="./"+scriptDF[dayString][scriptInt-1]
        os.chdir(cmdString)
        os.system(launchString)
        sys.exit(0)
