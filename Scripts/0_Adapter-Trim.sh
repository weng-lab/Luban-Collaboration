#!/bin/bash

#Jill E. Moore
#Weng Lab
#UMass Medical School
#December 2020

scriptDir=/home/moorej3/Projects/Luban-Collaboration/Scripts
data=$1
workingDir=~/Lab/Luban-Collaboration/Raw

cd $workingDir

#prefix=$(echo $data | awk -F "_" '{print $1}')
#i7=$(awk '{if ($1 == "'$prefix'") print $2}' i7-Index.txt)
echo ">5'-primer" > test.fa
echo "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA" >> test.fa
echo ">5'-primer-RC" >> test.fa
python $scriptDir/reverse-complement.py AGATCGGAAGAGCACACGTCTGAACTCCAGTCA >> test.fa
echo ">3'-primer" >> test.fa
echo "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" >> test.fa
echo ">3'-primer-RC" >> test.fa
python $scriptDir/reverse-complement.py AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT >> test.fa
mv test.fa $data.adaptors.fa

java -jar ~/bin/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 16 \
    $data"_R1_001.R1.fastq" $data"_R1_001.R2.fastq" $data.1.P.fq $data.1.U.fq $data.2.P.fq $data.2.U.fq \
    ILLUMINACLIP:$data.adaptors.fa:2:30:10:2:keepBothReads SLIDINGWINDOW:4:15 LEADING:3 TRAILING:3 MINLEN:36 
mv $data.1.P.fq $data.1.U.fq $data.2.P.fq $data.2.U.fq ../Clean/
