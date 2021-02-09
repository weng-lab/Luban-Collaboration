#Jill E. Moore
#Weng Lab
#UMass Medical School
#January 2021

import sys

vcf = open(sys.argv[1])
cutoff = int(sys.argv[2])

for line in vcf:
    if "##" not in line and "#CHROM" not in line:
        line = line.rstrip().split("\t")
        details = line[7].split(";")
        for detail in details:
            if "DP=" in detail:
                coverage = int(detail.split("=")[1])
                if coverage >= cutoff:
                    if line[-1].split(":")[0] == "0/1":
                        genotype = "HET"
                    elif line[-1].split(":")[0] == "1/1":
                        genotype = "ALT"
                    else:
                        genotype = "NA"
                    print line[0]+"\t"+line[1]+"\t"+line[3]+"\t"+line[4]+"\t"+str(coverage)+"\t"+genotype
