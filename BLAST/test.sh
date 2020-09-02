#!/bin/bash

input="$1"

subjectseqid=$(cut -f1 $input)
start=$(cut -f2 $input)
end=$(cut -f3 $input)
echo "Subject = $subjectseqid, Start = $start, End = $end"
if [ $start -gt $end ]
  then 
    echo "CAUTION: Reversing Coordinates"
    echo "Input = $subjectseqid $end $start"
    input=$(echo -e "$subjectseqid\t$end\t$start")
    blastdbcmd -db ../WGS/database_v2/GCA_001021135.1_ASM102113v1_genomic.fna -entry $input
  else
    echo "Input = $subjectseqid $start $end"
    input=$(echo -e "$subjectseqid\t$start\t$end")
    blastdbcmd -db ../WGS/database_v2/GCA_001021135.1_ASM102113v1_genomic.fna -entry $input
fi
