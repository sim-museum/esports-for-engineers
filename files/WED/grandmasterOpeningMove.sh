#!/usr/bin/python3

import sys, random, os

def isConvertableToFloat(value):
    try:
        float(value)
        return True
    except:
        return False


if len(sys.argv) < 2:
  res=os.system("clear")
  print("Use this script to select random opening moves so you get a variety of games")
  print("and do not have to memorize openings:")
  print("\nRun ./scid.sh, then select File/Open and open the grandmaster games database.")
  print("Then display the scid tree window.")
  print("This will show a list of moves played from this position by grandmasters, with")
  print("a percentage next to each move indicating the probability of that move")
  print("in the grandmaster database.  To select a move at random, run this ")
  print("script with the probabilities as command line arguments.")
  print("\nExample:")
  print("If in the starting position, the scid tree window move probabilities for")
  print("White's first move are")
  print("1: e4 44.7%")
  print("2: d4 37.3%")
  print("3: c4 8.6%")
  print("4: Nf3 8.5%\n")
  print("To choose between these moves, issue this command:")
  print("grandmasterOpeningMove 44.7 37.3 8.6 8.5\n")
  print("\nContinue to select grandmaster moves randomly in this way until a position")
  print("arises which is not in the database.  Now it's your turn to choose your subsequent moves!")
  sys.exit(0)

# nArgs = len(sys.argv)-1
#print (len(sys.argv))
randPercent=random.randint(0,100)
#print("rand percent is ", str(randPercent))

numCount=0
runningTotal=0

for i in range(1, len(sys.argv)):
	inputString=sys.argv[i]
	if not isConvertableToFloat(inputString):
		print("Error: "+inputString+"is not a number.  For help, run script with no arguments.")
		sys.exit(1)
	inputNum=float(inputString)
	if not 0.0 <= inputNum <= 100.0:
		print("Error: "+inputString+" is not a percentage between 0 and 100.  For help, run script with no arguments")
		sys.exit(1)
	numCount+=1
	runningTotal+=inputNum
	if runningTotal>randPercent:
                print("Choose scid tree window move number "+str(numCount))
                sys.exit(0)

print("Choose scid tree window move number "+str(len(sys.argv)-1))
