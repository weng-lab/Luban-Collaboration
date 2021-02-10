library(DESeq2)

args = commandArgs(trailingOnly=TRUE)

condition1 = args[1]
condition2 = args[2]

rawData=read.table(paste0(condition1,".vs.",condition2,".matrix.txt"), row.names=1)

expDesign=data.frame(rep(c("cond1","cond2","cond3","cond4","cond5"),2),c(rep("donor1",5),rep("donor2",5)))
names(expDesign) = c("condition","donor")

dds = DESeqDataSetFromMatrix(countData = rawData, colData = expDesign, design = ~ condition + donor)
dds = DESeq(dds, betaPrior=TRUE)
res = results(dds)
res = res[order(res$padj),]
write.table(res, paste0(condition1,".vs.",condition2,".DEG-Raw.txt"), sep="\t", quote=F)
