#!/bin/bash

while getopts "10anflh" opt; do
	case $opt in
		a)
			echo "-a was triggered!" >&2
			;;
		1)
			echo "-1 was triggered!" >&2
			;;
		0)
			echo "-0 was triggered!" >&2
			;;
		n)
			echo "-n was triggered!" >&2
			;;
		f)
            echo "-f was triggered!" >&2
            ;;
		l)
            echo "-l was triggered!" >&2
            ;;
		h)
            echo "-h was triggered!" >&2
            ;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			;;
	esac
done
