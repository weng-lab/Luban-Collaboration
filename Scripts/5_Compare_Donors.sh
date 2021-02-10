#!/bin/bash

#Jill E. Moore
#Weng Lab
#UMass Medical School
#December 2020

donor1=$1
donor2=$2
genes=~/Lab/Reference/Human/hg38/GENCODE32/Genes.Basic.bed
workingDir=~/Lab/Luban-Collaboration/Gene-Counts
scriptDir=/data/zusers/moorej3/GitHub/Luban-Collaboration/Scripts/
cd $workingDir

paste $donor1*.HTS.counts $donor2*.HTS.counts | \
    awk '{print $1 "\t" $2 "\t" $4 "\t" $6 "\t" $8 "\t" $10 "\t" $12 "\t" \
    $14 "\t" $16 "\t" $18 "\t" $20 "\t" $22}' | \
    awk '{if ($1 ~ /ENSG/) print $0}' > $donor1.vs.$donor2.matrix.txt

Rscript $scriptDir/deseq-donor.R $donor1 $donor2
python $scriptDir/match-gene-id.py $genes $donor1".vs."$donor2".DEG-Raw.txt" > \
$donor1".vs."$donor2".DEG-Formated.txt"

head -n 100 $donor1".vs."$donor2".DEG-Formated.txt" > $donor1".vs."$donor2".DEG-Mini.txt"


