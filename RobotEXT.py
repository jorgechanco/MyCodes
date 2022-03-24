##Version: Python equivalent of the PowerShell code
##Author: Jorge Chanco
##Date Created: 24/03/2022
##Description: Solution for IOOF code test requirement -ROBOT EXTENSION requirement
##Input is from a folder the tester can access. This require an update
##to point to tester's test folder.
##Resulting output is displayed on the powershell prompt.

#---------------------
# define functions
#---------------------
def MoveWEST():
    global x
    x-=1

def MoveEAST():
    global x
    x+=1

def MoveNORTH():
    global y
    y+=1

def MoveSOUTH():
    global y
    y1-=1

def FaceLEFT():
    global f
    match f:
        case 'WEST': f='SOUTH'
        case 'EAST': f='NORTH'
        case 'NORTH':f='WEST'
        case 'SOUTH':f='EAST'

def FaceRIGHT():
    global f
    match f:
        case 'WEST': f='NORTH'
        case 'EAST': f='SOUTH'
        case 'NORTH':f='EAST'
        case 'SOUTH':f='WEST'
#---------------------
#Initialisation
#---------------------
iRobot=-1
aRobot=[]

#---------------------
#Main 
#---------------------
with open('/users/jorgechanco/test.txt', 'r') as f:             ##update to input file location
    for line in f:

        tmp= (line.replace(',',' ')).split()

        if tmp[0] == 'PLACE':
            x=int(tmp[1])
            y=int(tmp[2])
            f=tmp[3].upper()
            iRobot+=1
            aRobot.append(str(x)+','+str(x)+','+str(y)+','+f)

        match tmp[0]:
            case 'PLACE':
                Flag=1
                if (x>=0 and x<=5) and (y>=0 and y<=5):         ##validate coordinates are inside table
                       Flag=0

            case 'MOVE':
                if Flag==0:
                    match f:
                        case 'WEST':
                            MoveWEST()
                        case 'EAST':
                            MoveEAST()
                        case 'NORTH':
                            MoveNORTH()
                        case 'SOUTH':
                            MoveSOUTH()
                    aRobot[iRobot] = (str(x)+','+str(x)+','+str(y)+','+f)

            case 'LEFT':
                if Flag==0:
                    FaceLEFT()
                    aRobot[iRobot] = (str(x)+','+str(x)+','+str(y)+','+f)
                    

            case 'RIGHT':
                if Flag==0:
                    FaceRIGHT()
                    aRobot[iRobot] = (str(x)+','+str(x)+','+str(y)+','+f)

            case 'REPORT':
                if Flag==0:
                    print('Output: ',str(x)+','+str(y)+','+f+','+str(iRobot+1)+','+str(len(aRobot)))

            case 'ROBOT':
                if Flag==0:
                    iRobot=int(tmp[1]) -1
                    tmp = (aRobot[iRobot].replace(',',' ')).split()
                    x=int(tmp[1])
                    y=int(tmp[2])
                    f=tmp[3]
