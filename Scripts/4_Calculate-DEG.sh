#!/bin/bash

#Jill E. Moore
#Weng Lab
#UMass Medical School
#December 2020

condition1=$1
condition2=$2
genes=~/Lab/Reference/Human/hg38/GENCODE32/Genes.Basic.bed
workingDir=~/Lab/Luban-Collaboration/Gene-Counts
scriptDir=/data/zusers/moorej3/GitHub/Luban-Collaboration/Scripts/
cd $workingDir

paste *$condition1.HTS.counts *$condition2.HTS.counts | \
    awk '{print $1 "\t" $2 "\t" $4 "\t" $6 "\t" $8 "\t" $10 "\t" $12}' | \
    awk '{if ($1 ~ /ENSG/) print $0}' > $condition1.vs.$condition2.matrix.txt

Rscript $scriptDir/deseq.R $condition1 $condition2
python $scriptDir/match-gene-id.py $genes $condition1".vs."$condition2".DEG-Raw.txt" > \
$condition1".vs."$condition2".DEG-Formated.txt"

head -n 100 $condition1".vs."$condition2".DEG-Formated.txt" > $condition1".vs."$condition2".DEG-Mini.txt"


