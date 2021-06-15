library(ngramr)
library(reshape)

verbs=read.delim("dat1.txt", header=T, sep="\t")
verbs$Infinitive=as.character(verbs$Infinitive)
verbs$Regular=as.character(verbs$Regular)
verbs$Irregular=as.character(verbs$Irregular)

past=data.frame(ngram(c(verbs$Regular, verbs$Irregular)))
terms=verbs$Regular
regular=data.frame()
for(i in 1:2){
    a=terms[((i*12)-11):(i*12)]
    regular=rbind(regular, data.frame(ngram(a[!is.na(a)])))
}
df1=cast(regular, Year~Phrase, value="Frequency")
df1["Total"]=rowSums(df1[-1])
write.table(df1, "regular.txt", sep="\t", quote=F, col.names=NA)

terms=verbs$Irregular
irregular=data.frame()
for(i in 1:2){
    a=terms[((i*12)-11):(i*12)]
    irregular=rbind(irregular, data.frame(ngram(a[!is.na(a)])))
}
df2=cast(irregular, Year~Phrase, value="Frequency")
df2["Total"]=rowSums(df2[-1])
write.table(df2, "irregular.txt", sep="\t", quote=F, col.names=NA)

plot(df1$Year, df1$Total, type="l", lty=1, ylim=c(0, max(df1$Total, df2$Total)))
lines(df2$Year, df2$Total, type="l", lty=2)
legend(list(x=1950, y=0.0002), c("Regular", "Irregular"),
       lty=1:2)

plot(df1$Year, apply(df1[c(-1, -length(df1))], 1, mean),
     ylim=c(0, max(apply(df1[c(-1, -length(df1))], 1, mean))),
     type="l", lty=1)
lines(df2$Year, apply(df2[c(-1, -length(df2))], 1, mean),
      type="l", lty=2)
legend(list(x=1950, y=9e-06), c("Regular", "Irregualr"),
       lty=1:2)

plot(df1$Year, cumsum(apply(df1[c(-1, -length(df1))], 1, mean)),
     ylim=c(0, max(cumsum(apply(df1[c(-1, -length(df1))], 1, mean)))),
     type="l", lty=1)
lines(df2$Year, cumsum(apply(df2[c(-1, -length(df2))], 1, mean)),
      type="l", lty=2)
legend("topleft", c("Regular", "Irregualr"),
       lty=1:2)

reg.median=apply(df1[-c(1, length(df1))], 1, median)
reg.change=diff(reg.median)/reg.median[-length(reg.median)]
plot(df1$Year[-1], reg.change, type="l", lty=1)
abline(h=0, lty=2)
abline(v=1900, lty=3)

regular=read.delim(file="regular.txt", sep="\t")
regular=regular[c(-1, -length(regular))]
irregular=read.delim(file="irregular.txt", sep="\t")
irregular=regular[c(-1, -length(irregular))]

regular=read.delim(file="dat2.txt", sep="\t")
irregular=read.delim(file="dat3.txt", sep="\t")
regular.early=data.frame(row.names=regular$Year[regular$Year<=1825],
                         regular[regular$Year<=1825, -1])
irregular.early=data.frame(row.names=irregular$Year[irregular$Year<=1825],
                         irregular[irregular$Year<=1825, -1])
early=data.frame(row.names=colnames(irregular.early), 
                 irregular=apply(irregular.early, 2, median))
early["regular"]=apply(regular.early, 2, median)
early["regularity.ratio"]=early$regular/rowSums(early)

regular.late=data.frame(row.names=regular$Year[regular$Year>=1994],
                         regular[regular$Year>=1994, -1])
irregular.late=data.frame(row.names=irregular$Year[irregular$Year<=1994],
                           irregular[irregular$Year<=1994, -1])
late=data.frame(row.names=colnames(irregular.late), 
                 irregular=apply(irregular.late, 2, median))
late["regular"]=apply(regular.late, 2, median)
late["regularity.ratio"]=late$regular/rowSums(late)

plot(early$regularity.ratio, late$regularity.ratio, 
     type="n", xlim=c(0, 1), ylim=c(0, 1))
text(early$regularity.ratio, late$regularity.ratio,
     labels=rownames(early), cex=0.9)
abline(a=0, b=1, lty=2)

regularity.trend=rownames(late)[early$regularity.ratio<late$regularity.ratio]
final.letters=substring(regularity.trend, nchar(regularity.trend)-1)

barplot(sort(table(final.letters), decreasing = T))
pie(sort(table(final.letters), decreasing=T))