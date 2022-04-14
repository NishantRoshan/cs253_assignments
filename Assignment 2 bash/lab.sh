#!/bin/bash

if (( $# != 2 )) 
then
        echo "You need to enter two file names, one for the input file other for the output file."
        exit 
fi
input_file=$1     
output_file=$2
if [ ! -f $input_file ]; then
   echo "File $input_file does not exist."
   exit
else
   awk 'BEGIN{FS=","}
   {print $1,$2,$3,$5,$6,$7,$10,$11}' $input_file > $output_file
fi

awk 'BEGIN{FS=","}{
if ($3 =="Bachelor'\''s")
	print $1
}' $input_file >> $output_file

awk -F ',' '{number[$6]++}{accumulate[$6]=accumulate[$6]+$7} END{for (j in number) print j,":" ,accumulate[j]/number[j]}' <(tail -n +2 $1) >> $2

sort -t, -nr --key=16 $input_file | awk -F "\"*,\"*" '{print $1} NR==5{exit}' >>$output_file