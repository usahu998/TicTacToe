#!/bin/bash

echo "Welcome to Tic-Tac-Toe game"


#FINAL_VARIABLES
MAX_BOARD_POSITION=9


#VARIABLES
playerPosition=0
playerSymbol=''
computerSymbol=''
nonEmptyBlockCount=1

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
	whoPlays=false
}


function computerInput()
{
	echo "Computer is Playing"
	sleep 1
	computerPosition=$((RANDOM%9+1))
	if [ ${boardPosition[$computerPosition]} == '-' ]
	then
		boardPosition[$computerPosition]=$computerSymbol
	else
		echo "Computer played Wrong move "
		computerInput
	fi
	whoPlays=true
}




function checkHorizontalVerticalWon()
{
	position=1
	loopCounter=1
	while [  $loopCounter -le 3 ]
	do
		if [[ ${boardPosition[$position]} == ${boardPosition[$position+$3]} ]] && [[  ${boardPosition[$position+$3]}  ==  ${boardPosition[$position+$3+$3]} ]] && [[ ${boardPosition[$position+$3+$3]} == $1 ]]
		then
			displayBoard
			echo " HURRAY!!! $1 wins "
			someoneWon=true
			break
		else
			position=$(( $position+$2 ))
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
			echo " Hurray!!! $1 wins "
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
	while [ ${boardPosition[$nonEmptyBlockCount]} != '-' ]
	do
		if [ $nonEmptyBlockCount -eq 9 ]
		then
			displayBoard
			echo "UhUho!!!! Game Is Tie"
			someoneWon=true
			break
		else
			nonEmptyBlockCount=$(($nonEmptyBlockCount+1))
		fi
	done
}



function checkWon()
{
	symbol=$1
	rowValue=1
	columnValue=3

	checkHorizontalVerticalWon $symbol $columnValue  $rowValue
 	checkHorizontalVerticalWon $symbol $rowValue $columnValue
	checkDiagonalWinner $symbol
}



#-------------------------MAIN-----------------


initializingBoard
symbolAssignment

while [ $someoneWon == false ]
do
	displayBoard
	if [ $whoPlays == true ]
	then
		playerInput
		checkWon $playerSymbol
		checkGameTie
	else
		computerInput
		checkWon $computerSymbol
		checkGameTie
	fi

done
