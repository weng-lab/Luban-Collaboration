import sys

geneDict={}
geneNames=open(sys.argv[1])

for line in geneNames:
    line=line.rstrip().split("\t")
    geneDict[line[3].rstrip()]=line[6]

deg=open(sys.argv[2])
next(deg)
for line in deg:
    line=line.rstrip().split("\t")
    if line[0] in geneDict:
        print(line[0]+"\t"+geneDict[line[0]]+"\t"+line[2]+"\t"+line[5]+"\t"+line[6])
    else:
        print (line[0]+"\t"+"---"+"\t"+line[2]+"\t"+line[5]+"\t"+line[6])
