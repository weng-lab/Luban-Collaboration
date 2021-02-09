#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=12:00:00
#SBATCH --mem=50G
#SBATCH --output=/home/moorej3/Job-Logs/jobid_%A.output
#SBATCH --error=/home/moorej3/Job-Logs/jobid_%A.error
#SBATCH --partition=12hours

source ~/.bashrc

data=M29-MDA5-KD-mock-48h
bam=~/Lab/Luban-Collaboration/Mapped/$data.bam
gtf=~/Lab/Reference/Human/hg38/GENCODE32/gencode.v32.annotation.gtf
outputDir=~/Lab/Luban-Collaboration/Gene-Counts

mkdir -p /tmp/moorej3/$SLURM_JOBID
cd /tmp/moorej3/$SLURM_JOBID

python ~/bin/htseq-master/scripts/htseq-count -s no -f bam -r pos $bam $gtf > $data.HTS.counts


mv *.counts $outputDir
rm -r /tmp/moorej3/$SLURM_JOBID

