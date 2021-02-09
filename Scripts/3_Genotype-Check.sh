#!/bin/bash

#Jill E. Moore
#Weng Lab
#UMass Medical School
#January 2021

#SBATCH --nodes=1
#SBATCH --time=4:00:00
#SBATCH --mem=50G
#SBATCH --output=/home/moorej3/Job-Logs/jobid_%A.output
#SBATCH --error=/home/moorej3/Job-Logs/jobid_%A.error
#SBATCH --partition=4hours

source ~/.bashrc

data=M29-MDA5-KD-mock-48h
bam=~/Lab/Luban-Collaboration/Mapped/$data.bam
reference=~/Lab/Reference/Human/hg38/hg38.fa
outputDir=~/Lab/Luban-Collaboration/Genotypes

mkdir -p /tmp/moorej3/$SLURM_JOBID
cd /tmp/moorej3/$SLURM_JOBID

~/bin/samtools-1.6/samtools view -hb $bam chr12:50000000-55000000 > mini.bam
~/bin/samtools-1.6/samtools index mini.bam

~/bin/bcftools-1.8/bcftools mpileup -Ou -f $reference mini.bam \
    | ~/bin/bcftools-1.8/bcftools call -vmO z -o $data.vcf.gz

gunzip $data.vcf.gz

python ~/Projects/Luban-Collaboration/Scripts/filter-vcf.py $data.vcf 10 \
    > $data.Genotype-Summary.txt

mv $data.vcf $data.Genotype-Summary.txt $outputDir/

rm -r /tmp/moorej3/$SLURM_JOBID
