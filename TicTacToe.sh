#!/bin/bash

echo "Welcome to Tic-Tac-Toe game"


#FINAL_VARIABLES
MAX_BOARD_POSITION=9


#VARIABLES
playerPosition=0
playerSymbol=''
computerSymbol=''


#boolean Flags
someoneWon=false
whoPlays=false


#BOARD ARRAY
declare -a boardPosition


function initializingBoard()
{
	for (( i=1; i<=$MAX_BOARD_POSITION; i++ ))
	do
		boardPosition[$i]='-'
	done
}



function symbolAssignment()
{
	firstPlay=$((RANDOM%2))

	if [ $firstPlay -eq 1 ]
	then
		whoPlays=true
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



function playerInput()
{
	read -p "Enter  position Number to put $playerSymbol at Empty Position " playerPosition
	if [ ${boardPosition[$playerPosition]} == '-' ]
	then
		boardPosition[$playerPosition]=$playerSymbol
	else
		echo "Position Occupied Please enter new Position"
		playerInput
	fi
}


function checkHorizontalWinner()
{
	max_number_rows=3
	position=1
	loopCounter=1
	while [  $loopCounter -le 3 ]
	do
		if [[ ${boardPosition[$position]} == ${boardPosition[$position+1]} ]] && [[  ${boardPosition[$position+1]}  ==  ${boardPosition[$position+2]} ]] && [[ ${boardPosition[$position+2]} == $1 ]]
		then
			displayBoard
			echo " HURRAY!!! $1 wins "
			someoneWon=true
			break
		else
			position=$(( $position+$max_number_rows ))
		fi
		loopCounter=$(($loopCounter+1))
	done
}



function checkVerticalWinner()
{
	position=1
	loopCounter=1
	while [ $loopCounter -le 3 ]
	do
		if [[ ${boardPosition[$position]} == ${boardPosition[$position+3]} ]] && [[  ${boardPosition[$position+3]}  ==  ${boardPosition[$position+6]} ]] && [[ ${boardPosition[$position+6]} == $1 ]]
		then
			displayBoard
			echo " HURRAY!!! $1 wins "
			someoneWon=true
			break
		else
			position=$(($position+1))
		fi
		loopCounter=$(($loopCounter+1))
	done
}



function checkDiagonalWinner()
{
	position=1
	loopCounter=1
	while [ $loopCounter -le 2 ]
	do
		if [[ ${boardPosition[$position]} == ${boardPosition[$position+4]} ]] && [[  ${boardPosition[$position+4]}  ==  ${boardPosition[$position+8]} ]] && [[ ${boardPosition[$position+8]} == $1 ]]
		then
			displayBoard
			echo " HURRAY!!! $1 wins "
			someoneWon=true
			break
		elif [[ ${boardPosition[$position+2]} == ${boardPosition[$position+4]} ]] && [[  ${boardPosition[$position+4]}  ==  ${boardPosition[$position+6]} ]] && [[ ${boardPosition[$position+6]} == $1 ]]
		then
			displayBoard
			echo " HURRAY!!! $1 wins "
			someoneWon=true
			break
		fi
		loopCounter=$(($loopCounter+1))
	done
}


function checkGameTie()
{
	count=1
	while [ ${boardPosition[$count]} != '-' ]
	do
		if [ $count -eq 9 ]
		then
			displayBoard
			echo "Game Is tie"
			someoneWon=true
			break
		else
			count=$($count+1)
		fi
	done
}





#-------------------------MAIN-----------------


initializingBoard
symbolAssignment

while [ $someoneWon == false ]
do
	displayBoard
	playerInput
	checkHorizontalWinner $playerSymbol
	checkVerticalWinner $playerSymbol
	checkDiagonalWinner $playerSymbol
	checkGameTie
done
