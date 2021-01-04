#!/bin/bash

#Jill E. Moore
#Weng Lab
#UMass Medical School
#December 2020

data=$1
workingDir=~/Lab/Luban-Collaboration/Clean
genome=~/Lab/Reference/Human/hg38/HISAT2/genome

cd $workingDir

echo "Mapping ..."
~/bin/hisat2-2.2.1/hisat2 -p 16 -x $genome -1 $data.1.P.fq -2 $data.2.P.fq -S $data.sam

echo "Coverting from sam to bam ..."
samtools view -bS $data.sam -o $data.unsorted.bam
echo "Sorting bam ..."
samtools sort -@ 16 -o $data.bam $data.unsorted.bam
echo "Indexing bam ..."
samtools index $data.bam

mv *sam *bam* ../Mapped
