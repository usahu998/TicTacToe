#!/bin/bash

echo "Welcome to Tic-Tac-Toe game"


#FINAL_VARIABLES
MAX_BOARD_POSITION=9
PLAYER_SYMBOL=''
COMP_SYMBOL=''


#VARIABLES
whoPlays=0


#BOARD ARRAY
#!/bin/bash

echo "Welcome to Tic-Tac-Toe game"


#FINAL_VARIABLES
MAX_BOARD_POSITION=9

#VARIABLES
whoPlays=0
playerPosition=0
playerSymbol=''
computerSymbol=''

#BOARD ARRAY
declare -a boardPosition


function initializingBoard()
{
	for (( i=1; i<=$MAX_BOARD_POSITION; i++ ))
	do
		boardPosition[$i]=0
	done
}



function symbolAssignment()
{
	firstPlay=$((RANDOM%2))

	if [ $firstPlay -eq 1 ]
	then
		(( whoPlays++ ))
		playerSymbol='X'
		computerSymbol='O'
		echo "Player symobol : X | Computer symbol : O"
		echo "Player plays First"
	else
		playerSymbol='O'
		computerSymbol='X'
		echo "Player symobol : O | Computer symbol : X"
		echo "Computer Plays First"
	fi
}


function playerInput()
{
	read -p "Enter  position Number to put $playerSymbol at Empty Position " playerPosition
	if [ ${boardPosition[$playerPosition]} -eq 0 ]
	then
		boardPosition[$playerPosition]=$playerSymbol
	else
		echo "Position Occupied Please enter new Position"
		playerInput
	fi
}



function displayBoard()
{
	echo "     |     |      "
	echo "  ${boardPosition[1]}  |  ${boardPosition[2]}  |  ${boardPosition[3]}  "
	echo "_____|_____|_____"
	echo "     |     |     "
	echo "  ${boardPosition[4]}  |  ${boardPosition[5]}  |  ${boardPosition[6]}  "
	echo "_____|_____|_____"
	echo "     |     |     "
	echo "  ${boardPosition[7]}  |  ${boardPosition[8]}  |  ${boardPosition[9]}  "
	echo "     |     |   "
}

initializingBoard
displayBoard
symbolAssignment
playerInput
