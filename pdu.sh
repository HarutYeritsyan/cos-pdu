#!/bin/bash

usage(){
	echo "-1: Encender" >&2
	echo "-0: Apagar" >&2
	echo "-a: Todas las salidas" >&2
	echo "-n x: La salida x [1-8]" >&2
	echo "-f x: Desde la salida x [1-8]" >&2
	echo "–l y: Hasta la salida y [1-8]" >&2
	echo "-h: Este texto de ayuda" >&2
}

swap_first_last_output_number(){
	AUX_OUTPUT_NUMBER=$FIRST_OUTPUT_NUMBER
	FIRST_OUTPUT_NUMBER=$LAST_OUTPUT_NUMBER
	LAST_OUTPUT_NUMBER=$AUX_OUTPUT_NUMBER
}

get_executable_command(){
	local OUTPUT_NUMBER=$1
	echo "practica\ncos\n1\n$OUTPUT_NUMBER\n$COMMAND\nyes\n\n\033\0334\n"
}

MIN_OUTPUT_NUMBER=1
MAX_OUTPUT_NUMBER=8

FIRST_OUTPUT_NUMBER=$MIN_OUTPUT_NUMBER
LAST_OUTPUT_NUMBER=$MAX_OUTPUT_NUMBER

while getopts "10an:f:l:h" opt; do
	case $opt in
		1)
			COMMAND=1
			;;
		0)
			COMMAND=0
			;;
		a)
			FIRST_OUTPUT_NUMBER=$MIN_OUTPUT_NUMBER
			LAST_OUTPUT_NUMBER=$MAX_OUTPUT_NUMBER
			;;
		n)
			if [ $OPTARG -ge $MIN_OUTPUT_NUMBER ] && [ $OPTARG -le $MAX_OUTPUT_NUMBER ]; then
				FIRST_OUTPUT_NUMBER=$OPTARG
				LAST_OUTPUT_NUMBER=$OPTARG
			else
				ERROR="x fuera de rango"
			fi
			;;
		f)
			if [ $OPTARG -ge $MIN_OUTPUT_NUMBER ]; then
				FIRST_OUTPUT_NUMBER=$OPTARG
			else
				FIRST_OUTPUT_NUMBER=$MIN_OUTPUT_NUMBER
			fi
            ;;
		l)
			if [ $OPTARG -le $MAX_OUTPUT_NUMBER ]; then
				LAST_OUTPUT_NUMBER=$OPTARG
			else
				LAST_OUTPUT_NUMBER=$MAX_OUTPUT_NUMBER
			fi
            ;;
		h)
            $(usage)
			exit 0
            ;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			$(usage)
			exit 0
			;;
	esac
done

if [ -z "$COMMAND" ]; then
	ERROR="Falta operación"
fi

if [ -n "$ERROR" ]; then
	echo -e "Error: $ERROR\n"
	$(usage)
	exit 0
fi

if [ "$COMMAND" = "1" ]; then
	echo "Encender"
else
	echo "Apagar"
fi

if [ $FIRST_OUTPUT_NUMBER -eq $LAST_OUTPUT_NUMBER ]; then
	echo "$FIRST_OUTPUT_NUMBER"
elif [ $FIRST_OUTPUT_NUMBER -gt $LAST_OUTPUT_NUMBER ]; then
	$(swap_first_last_output_number)
	echo "$FIRST_OUTPUT_NUMBER - $LAST_OUTPUT_NUMBER"
else
	echo "$FIRST_OUTPUT_NUMBER - $LAST_OUTPUT_NUMBER"
fi

for OUTPUT_NUMBER in $(seq $FIRST_OUTPUT_NUMBER $LAST_OUTPUT_NUMBER)
do
	get_executable_command "$OUTPUT_NUMBER"
done
