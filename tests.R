setwd('/Users/Rachel/Documents/GitHub_projects/DataDive/')
DF = read.csv('./taxform_short.csv')
DF$YrsOld = 2016 - DF$FormYear
DF$tmp = DF$totcntrbgfts/DF$totrevenue


TEST = read.csv('./test.csv')
USERdata = read.csv('./test.csv')
names(USERdata) = c("yr", "totcontrib", "totrev")
USERdata$form = 2016 - USERdata$yr
USERdata$ratio = USERdata$totcontrib/USERdata$totrev


Xv=DF$YrsOld[(DF$grsincfndrsng>10)&(DF$NTEE_topcode=='S')]
Yv=DF$tmp[(DF$grsincfndrsng>10)&(DF$NTEE_topcode=='S')]
DF1 = data.frame(Xv, Yv)
names(DF1) = c("Xv", "Yv")
MEDS = aggregate(DF1$Yv, by=list(DF1$Xv), FUN=median)
names(MEDS) = c("year","med")


Combined = merge(USERdata, MEDS, by.x = c('form'), by.y = c('year'))
print(cor(Combined$ratio, Combined$med, method = "spearman"))
print(cor(Combined$ratio, Combined$med, method = "kendall"))
print(cor(Combined$ratio, Combined$med, method = "pearson"))

ks.test(Combined$ratio, Combined$med)
t.test(Combined$ratio, Combined$med, paired=TRUE)

# T1 = data.frame(Combined$form, Combined$ratio)
# T2 = data.frame(Combined$form, Combined$med)
# dtw(T1, T2, k = TRUE)$distance



