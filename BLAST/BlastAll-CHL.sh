#!/bin/bash

cd /Users/ap14958/OneDrive\ -\ University\ of\ Bristol/Genomics\ Facility\ Bioinformatics/Project\ #4\ Vicky\ Spencer\ -\ Spikemoss/BLAST

for i in `ls CHL*fa | sed 's/.fa//'`
	do
		echo ""
		echo ">>>>>>>>>>>>>>>>>>>> $i BLAST begun <<<<<<<<<<<<<<<<<<<<<<"
		echo ""
		blastn -db ../WGS/GCA_001021135.1_ASM102113v1_genomic.fna \
					-query $i\.fa \
					-out $i\_Summary.out \
					-evalue 100000 \
					-dust no \
					-word_size 25
		if cat $i\_Summary.out | grep -q "No hits found"; then
			echo NO HIT FOUND
		else
			echo HIT FOUND
		fi
		blastn -db ../WGS/GCA_001021135.1_ASM102113v1_genomic.fna \
					-query $i\.fa \
					-out $i\_SubjectSeq.fa \
					-evalue 100000 \
					-dust no \
					-word_size 25 \
					-outfmt "6 sseq"
		echo ""
		echo ">>>>>>>>>>>>>>>>>>> $i BLAST Complete <<<<<<<<<<<<<<<<<<<<"
		echo ""
	done

#Try altering following options;
#	-dust no # Turns off masking (Short sequences)
# -evalue 1000 #Chances statistic of retrieval. The higher the less stringent.
# -word_size 4 #Number of characters to start with
