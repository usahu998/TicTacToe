#!/bin/bash

echo "Welcome to Tic-Tac-Toe game"


#FINAL_VARIABLES
MAX_BOARD_POSITION=9
PLAYER_SYMBOL=''
COMP_SYMBOL=''


#VARIABLES
whoPlays=0


#BOARD ARRAY
declare -a board_Position


function initialising_Board()
{
	for (( i=1; i<=$MAX_BOARD_POSITION; i++ ))
	do
		board_Position[$i]=0
	done
}



function symbol_Assignment()
{
	firstPlay=$((RANDOM%2))

	if [ $firstPlay -eq 1 ]
	then
		PLAYER_SYMBOL='X'
		COMP_SYMBOL='O'
		echo "Player symobol : X | Computer symbol : O"
	else
		PLAYER_SYMBOL='O'
		COMP_SYMBOL='X'
		echo "Player symobol : O | Computer symbol : X"
	fi
}
