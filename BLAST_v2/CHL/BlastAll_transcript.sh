#!/bin/bash353434

#cd /Users/ap14958/OneDrive\ \-\ University\ of\ Bristol/Genomics\ Facility\ Bioinformatics/Project\ \#4\ Vicky\ Spencer\ \-\ Spikemoss/BLAST_v2/

for i in `ls *_transcript.fa | sed 's/.fa//'`
	do
		echo ""
		echo ">>>>>>>>>>>>>>>>>>>> $i BLAST begun <<<<<<<<<<<<<<<<<<<<<<"
		echo ""
		blastn -db ../../WGS/Spikemoss_v2/GCA_001021135.1_ASM102113v1_genomic.fna \
					-query $i\.fa \
					-out $i\_Results.out \
					-evalue 0.0005 \
					-dust yes \
					-word_size 20 \
					-outfmt "6 sseqid sseq sstart send sstrand"
		blastn -db ../../WGS/Spikemoss_v2/GCA_001021135.1_ASM102113v1_genomic.fna \
					-query $i\.fa \
					-out $i\_Summary.out \
					-evalue 0.0005 \
					-dust yes \
					-word_size 20
		if grep -q "No hits found" $i\_Summary.out; then
			echo NO HIT FOUND
		else
			echo HIT FOUND
		fi
		head -n 1 $i\_Results.out | sed 's/-//g'  > $i\_TopHit.out
		rm $i\_Results.out
		cat $i\_TopHit.out
		ACCESSION=$(head -n 1 $i\_TopHit.out | cut -f 2 -d "|")
		echo $ACCESSION
		blastdbcmd -db ../../WGS/Spikemoss_v2/GCA_001021135.1_ASM102113v1_genomic.fna -entry $ACCESSION > $i\_GenomicContig.fa
		echo ""
		echo ">>>>>>>>>>>>>>>>>>> $i BLAST Complete <<<<<<<<<<<<<<<<<<<<"
		echo ""
	done


#-word_size 25
