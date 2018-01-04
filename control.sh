#!/bin/bash
# A menu driven shell script sample template 

printf "\nWelcome to the utility\n"
printf "##############################################################\n"
figlet -f slant "Zeeshan [:#]"
printf "\n\n"
printf "##############################################################\n\n"

cd $WORKINGDIR
DATAFOLDER=inputdata
# Record the start time of processing
START=$(date +%s.%N)

#$numCores=$(nproc)
#$coresInuse= $(nproc)/2
#printf ("You have %d number of cores in your system and this program will use half of cores.")
#$numCores=$(( numCores*coresP))
printf "\n\n"
printf "#####################sra Conversion to fastq#####################\n\n"
#convert the SRA file to fastq

#ls $DATAFOLDER/*sra |while read id; 
#do fastq-dump --split-files --O $DATAFOLDER/ $id;
#rm -rf $id
#done

printf "Completed\n"
printf "#####################Building Index File#####################\n\n"
# mapping read to h19 reference genome


reference=$DATAFOLDER/genome.fa
#mkdir $DATAFOLDER/hisat_index
IDX=$DATAFOLDER/hisat_index/hisat_index
# Build a hisat2 index for the genome.
#time hisat2-build $reference $IDX/hisat_index
#printf "Completed\n"

# Record the start time of pipeline processing

#printf "#####################Run hisat2#####################\n\n"
#Run the hisat program
#START2=$(date +%s.%N)
HISATOUTDR=hisatoutput
#mkdir $DATAFOLDER/$HISATOUTDR
#time hisat2 -p 12 -x $IDX -1 $DATAFOLDER/WT_R1.fastq -2 $DATAFOLDER/WT_R2.fastq -S $DATAFOLDER/$HISATOUTDR/WT_23.sam 2>control_1.log
#time hisat2 -p 12 -x $IDX -1 $DATAFOLDER/upf1-5_upf3-1_R1.fastq -2 $DATAFOLDER/upf1-5_upf3-1_R2.fastq -S $DATAFOLDER/upf1-5_upf3-1_23.sam 2>control_2.log
#time hisat2 -p 5 -x $IDX -U _____fileName.fastq -S siSUZ12_1.sam 2>siSUZ12_1.log
#time hisat2 -p 5 -x $IDX -U _____fileName.fastq -S siSUZ12_2.sam 2>siSUZ12_2.log



# convert sam files to bam files
ls $DATAFOLDER/$HISATOUTDR/*sam |while read id;
do (nohup samtools sort -n -@2 -o ${id%%.*}.Nsort.bam $id > output.txt 2>&1);
done

# using htseq-counts to quantify the gene experssion level
#ls *.Nsort.bam |while read id;
#do (nohup samtools view $id | nohup htseq-count -f sam -s no -i gene_name - ~/reference/gtf/gencode/gencode.v25lift37.annotation.gtf 1>${id%%.*}.geneCounts 2>${id%%.*}.HTseq.log&);
#done
#END2=$(date +%s.%N)
#DIFFERENCE2=$(echo "$END2 - $START2" | bc)
#echo "Time to execute the pipeline was $DIFFERENCE2"

#END=$(date +%s.%N)
#DIFFERENCE=$(echo "$END - $START" | bc)
#echo "Time to execute the script was $DIFFERENCE"

set +x