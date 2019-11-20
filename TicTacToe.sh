#!/bin/bash

echo "Welcome to Tic-Tac-Toe game"


#FINAL_VARIABLES
MAX_BOARD_POSITION=9


#VARIABLES
playerPosition=0
computerPosition=0
playerSymbol=''
computerSymbol=''
nonEmptyBlockCount=1


#boolean Flags
someoneWon=false
whoPlays=false
computerWinMove=false
computerblockedMove=false


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
	echo ""
	for ((row=1; row<=MAX_BOARD_POSITION; row=$(($row+3)) ))
	do
		echo "     |     |      "
		echo "  ${boardPosition[$row]}  |  ${boardPosition[$row+1]}  |  ${boardPosition[$row+2]}  "
		echo "_____|_____|_____"
	done
	echo ""
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
	computerWinMove=false
	echo "Computer is playing"
	sleep 1
	winOrBlockMove $computerSymbol
	winOrBlockMove $playerSymbol
	checkCorners
	checkMiddle
	checkRemaining
	whoPlays=true
}


function winOrBlockMove()
{
	rowValue=1
	columnValue=3
	leftDiagonalValue=4
	rightDiagonalValue=2

	checkWinningMove $rowValue $1 $columnValue
	checkWinningMove $columnValue $1 $rowValue
	checkWinningMove $leftDiagonalValue $1 0
	checkWinningMove $rightDiagonalValue $1 0

}



function checkWinningMove()
{
	counter=1
	symbol=$2
	if [ $computerWinMove = false ]
	then
		for (( i=1; i<=3; i++ ))
		do
			if [[ ${boardPosition[$counter]} == ${boardPosition[$counter+$1+$1]} ]] && [[ ${boardPosition[$counter+$1]} == '-' ]] && [[ ${boardPosition[$counter]} == $symbol ]]
			then
				computerPosition=$(($counter+$1))
				boardPosition[$computerPosition]=$computerSymbol
				computerWinMove=true
				break
			elif [[  ${boardPosition[$counter]} == ${boardPosition[$counter+$1]} ]] && [[  ${boardPosition[$counter+$1+$1]} == '-' ]] && [[ ${boardPosition[$counter]} == $symbol ]]
			then
				computerPosition=$(($counter+$1+$1))
				boardPosition[$computerPosition]=$computerSymbol
				computerWinMove=true
				break
			elif [[ ${boardPosition[$counter+$1]} == ${boardPosition[$counter+$1+$1]} ]] && [[ ${boardPosition[$counter]} == '-' ]] && [[ ${boardPosition[$counter+$1]} == $symbol ]]
			then
				computerPosition=$counter
				boardPosition[$computerPosition]=$computerSymbol
				computerWinMove=true
				break
			fi
			counter=$(($counter+$3))
		done
	fi
}


function checkCorners
{
	 if [ $computerWinMove = false ]
   then
		for((i=1; i<=MAX_BOARD_POSITION; i=$(($i+2)) ))
		do
				if [ ${boardPosition[$i]} == '-' ]
				then
					computerPosition=$i
            	boardPosition[$computerPosition]=$computerSymbol
            	computerWinMove=true
            break
				fi
				if [ $i -eq 3 ]
				then
					i=$(($i+2))
				fi
		done
	fi
}


function checkMiddle()
{
	middle=5
	if [[ $computerWinMove = false ]] && [[ ${boardPosition[$middle]} == '-' ]]
	then
					computerPosition=$middle
               boardPosition[$computerPosition]=$computerSymbol
               computerWinMove=true
   fi

}


function checkRemaining()
{
	if [ $computerWinMove = false ]
	then
		for((i=2; i< $MAX_BOARD_POSITION; i=$(($i+2)) ))
		do
            	if [ ${boardPosition[$i]} == '-' ]
            	then
              		computerPosition=$i
               	boardPosition[$computerPosition]=$computerSymbol
               	computerWinMove=true
           		break
            	fi
		done
	fi
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
			exit
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
		if [ $nonEmptyBlockCount -eq $MAX_BOARD_POSITION ]
		then
			displayBoard
			echo "UhUho!!!! Game Is Tie"
			someoneWon=true
			computerWinMove=true
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
