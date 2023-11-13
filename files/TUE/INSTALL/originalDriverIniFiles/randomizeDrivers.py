import sys
import random
import os

# check that file name was input as command line argument

# check that there is a command line argument
if len(sys.argv)<2:
    print("useage: python3 randomizeDrivers.py <name of driver.ini file>")
    sys.exit(0)

# check that the argument is the name of a file in the current directory

fname=sys.argv[1]
if not os.path.isfile(fname):
    print(fname+": file not found.")
    sys.exit(0)
    
# list of numbers 1 through 19
myL=list(range(1,20))
#reverse order
myL.reverse()
#take first 5 numbers in reversed list
firstL=myL[0:5]
# put the rest of the numbers in a different list
restL=myL[5:]
#randomize these numbers
random.shuffle(restL)
resultL=firstL+restL


myCmd="cat "+ fname + " "

myString="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
for i in range(1,len(resultL)+1):
        myCmd+="| sed 's/driver_" + str(i) + " /driver_" + myString[resultL[i-1]] + " /' "

for i in range(1,len(resultL)+1):
        myCmd+="| sed 's/driver_" + myString[i] + " /driver_" + str(i) + " /' "

#print(myCmd)
# myCmd+=" | grep driver"
os.system(myCmd)

#print(resultL)

# sort list to make sure no numbers missing

#resultL.sort()

#print(resultL)

