library(DESeq2)

args = commandArgs(trailingOnly=TRUE)

condition1 = args[1]
condition2 = args[2]

rawData=read.table(paste0(condition1,".vs.",condition2,".matrix.txt"), row.names=1)

expDesign=data.frame(rep(c("M27","M28","M29"),2),c("cond1","cond1","cond1","cond2","cond2","cod2"))
names(expDesign) = c("donor", "condition")

dds = DESeqDataSetFromMatrix(countData = rawData, colData = expDesign, design = ~ donor + condition)
dds = DESeq(dds, betaPrior=TRUE)
res = results(dds)
res = res[order(res$padj),]
write.table(res, paste0(condition1,".vs.",condition2,".DEG.txt"), sep="\t", quote=F)
