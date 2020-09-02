#!/bin/bash

cd /Users/ap14958/OneDrive\ -\ University\ of\ Bristol/Genomics\ Facility\ Bioinformatics/Project\ #4\ Vicky\ Spencer\ -\ Spikemoss/BLAST

for i in `ls SmoTCP*fa | sed 's/.fa//'`
	do
		echo ""
		echo ">>>>>>>>>>>>>>>>>>>> $i BLAST begun <<<<<<<<<<<<<<<<<<<<<<"
		echo ""
		tblastn -db ../WGS/GCA_001021135.1_ASM102113v1_genomic.fna \
					-query $i\.fa \
					-out $i\_Summary.out
		if cat $i\_Summary.out | grep -q "No hits found"; then
			echo NO HIT FOUND
		else
			echo HIT FOUND
		fi
		tblastn -db ../WGS/GCA_001021135.1_ASM102113v1_genomic.fna \
					-query $i\.fa \
					-out $i\_SubjectSeq.fa \
					-outfmt "6 stitle sseq"
		echo ""
		echo ">>>>>>>>>>>>>>>>>>> $i BLAST Complete <<<<<<<<<<<<<<<<<<<<"
		echo ""
	done

#Try altering following options;
#	-dust no # Turns off masking (Short sequences)
# -evalue 1000 #Chances statistic of retrieval. The higher the less stringent.
# -word_size 4 #Number of characters to start with
