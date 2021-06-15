library(ngramr)
library(reshape)

Dickens=data.frame(ngram(c("Charles Dickens", "Merry Christmas"),
                         year_start=1800))
Dickens=cast(Dickens, Year~Phrase, value="Frequency")
Dickens=data.frame(row.names=Dickens$Year, Dickens[-1])

plot(rownames(Dickens), Dickens$Charles.Dickens, type="l", 
     lty=1)
lines(rownames(Dickens), Dickens$Merry.Christmas, type="l",
      lty=2)
legend("topright", colnames(Dickens), lty = 1:2)
arrows(1812, 6.0e-07, 1812, 0, angle=25, length=0.2, lty=1)
arrows(1870, 6.0e-07, 1870, Dickens$Charles.Dickens[row.names(Dickens)=="1870"],
       angle=25, length=0.2, lty=3)
text(c(1812, 1870), c(7.0e-07, 5.0e-07), 
     labels=paste(c("Dickens"), c("Birth", "Death"), sep="\n"),
     cex=0.8)

fame=read.delim("dat4.txt", header=T, sep="\t")
fame$Name=as.character(fame$Name)
df=data.frame()
for(n in 1:nrow(fame)){
    ng=data.frame(ngram(fame$Name[n], 
                        year_start=fame$Birth.Year[n],
                        year_end=fame$Birth.Year[n]+99))
    ng=data.frame(Age=0:99, ng[-c(1, length(ng))])
    df=rbind(df, ng)
}
df=cast(df, Age~Phrase, value="Frequency")

par(mfrow=c(1, 2))
par(mar=c(4, 4, 1, 1))
plot(df$Age, apply(df[-c(1, length(df))], 1, median), 
     type="l", lty=1)
plot(df$Age, cumsum(apply(df[-c(1, length(df))], 1, median)),
     type="l", lty=1)

table(fame$Birth.Year)
head(cut(fame$Birth.Year, breaks=seq(1800, 1920, 20),
         labels=paste0(seq(1801, 1901, 20), "~", seq(1820, 1920, 20))), 10)
birth=table(cut(fame$Birth.Year, breaks=seq(1800, 1920, 20),
                labels=paste0(seq(1801, 1901, 20), "~", seq(1820, 1920, 20))))
prop.table(birth)*100
birth=round(prop.table(birth)*100, 2)
pie(birth, labels=paste(names(birth), paste0(birth, "%"), sep = " "),
    col=terrain.colors(length(birth), alpha = 0.6))

occupation=round(sort(prop.table(table(fame$Occupation)), decreasing = T)*100, 2)

par(mfrow=c(1, 2))
barplot(occupation, cex.names=0.6, cex.axis = 0.9,
        col=rainbow(length(occupation), alpha=0.4))
barplot(occupation, las=2, col=topo.colors(length(occupation), alpha = 0.4))
mid=barplot(occupation)
barplot(occupation, las=2)
text(mid, occupation/2, labels=paste0(occupation, "%"),
     font=1)

pol=read.delim("dat5.txt", sep="\t", quote=NULL, row.names = 1)
nonpol=read.delim("dat6.txt", sep="\t", quote=NULL, row.names = 1)
par(mar=c(5, 4, 4, 4)+0.3)
plot(rownames(pol), apply(pol, 1, median), type="l", lty=1,
     xlab="age", ylab="politician median frequency",
     main="politician vs non-politician")
par(new=T)
plot(rownames(nonpol), apply(nonpol, 1, median), type="l",
     lty=2, axes=F, xlab="", ylab="")
axis(side=4, at=pretty(c(0, max(apply(nonpol, 1, median))), 4))
mtext("non-politician median frequency", side=4, line=3)
legend("topleft", c("politician", "non-politician"), lty=1:2,
       inset=0.02, cex=0.8)

plot(rownames(pol), apply(pol, 1, median), type="l", lty=1,
     axes=F, xlab="", ylab="")
axis(side=1, at=c(0, 30, 40, 50, 70, 100))
axis(side=2, at=quantile(apply(pol, 1, median)),
     labels=paste0(seq(0, 100, 25), "%"),
     cex.axis=0.8, col.axis="red")
