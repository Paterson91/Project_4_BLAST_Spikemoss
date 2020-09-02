#!/bin/bash353434

#cd /Users/ap14958/OneDrive\ \-\ University\ of\ Bristol/Genomics\ Facility\ Bioinformatics/Project\ \#4\ Vicky\ Spencer\ \-\ Spikemoss/BLAST_v2/

for i in `ls *.fa | sed 's/.fa//'`
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
			rm $i\_Results.out
		else
			echo HIT FOUND
			sed -n 1p $i\_Results.out | sed 's/-//g'  > $i\_TopHit_1.out
			sed -n 2p $i\_Results.out | sed 's/-//g'  > $i\_TopHit_2.out
			sed -n 3p $i\_Results.out | sed 's/-//g'  > $i\_TopHit_3.out
			#rm $i\_Results.out
			cat $i\_TopHit_1.out
			cat $i\_TopHit_2.out
			cat $i\_TopHit_3.out
			ACCESSION1=$(head -n 1 $i\_TopHit_1.out | cut -f 2 -d "|")
			ACCESSION2=$(head -n 1 $i\_TopHit_2.out | cut -f 2 -d "|")
			ACCESSION3=$(head -n 1 $i\_TopHit_3.out | cut -f 2 -d "|")
			echo $ACCESSION1
			echo $ACCESSION2
			echo $ACCESSION3
			blastdbcmd -db ../../WGS/Spikemoss_v2/GCA_001021135.1_ASM102113v1_genomic.fna -entry $ACCESSION1 > $i\_GenomicContig_Hit1.fa
			blastdbcmd -db ../../WGS/Spikemoss_v2/GCA_001021135.1_ASM102113v1_genomic.fna -entry $ACCESSION2 > $i\_GenomicContig_Hit2.fa
			blastdbcmd -db ../../WGS/Spikemoss_v2/GCA_001021135.1_ASM102113v1_genomic.fna -entry $ACCESSION3 > $i\_GenomicContig_Hit3.fa
		fi
		echo ""
		echo ">>>>>>>>>>>>>>>>>>> $i BLAST Complete <<<<<<<<<<<<<<<<<<<<"
		echo ""
	done


#-word_size 25
