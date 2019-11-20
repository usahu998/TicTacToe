#!/bin/bash

echo "Welcome to Tic-Tac-Toe game"


#FINAL_VARIABLES
MAX_BOARD_POSITION=9

#BOARD ARRAY
declare -a board_Position


function initialising_Board()
{
	for (( i=1; i<=$MAX_BOARD_POSITION; i++ ))
	do
		board_Position[$i]=0
	done
}
