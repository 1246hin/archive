library(ngramr)
library(reshape)

chagall=data.frame(ngram("Marc Chagall",
                         corpus=c("fre_2019", "eng_us_2019", "ger_2019"),
                         year_start = 1900,
                         year_end = 1950))
chagall=rbind(chagall, data.frame(ngram("Марк Шагал",
                                        corpus="rus_2019",
                                        year_start=1900,
                                        year_end=1950)))
chagall=cast(chagall, Year~Corpus, value="Frequency")
chagall=data.frame(row.names = chagall$Year, chagall[-1])
colnames(chagall)=c("American.English", "French", "German", "Russian")

plot(rownames(chagall), chagall[[1]], type="l", lty=1,
     ylim=c(0, max(chagall)), col=hcl.colors(length(chagall), 
                                             palette="dark 3")[1],
     xlab="year", ylab="relative frequency", main="chagall")
for(i in 2:length(chagall)){
    lines(rownames(chagall), chagall[[i]], type="l", lty=i,
          col=hcl.colors(length(chagall), palette = "dark 3")[i])
}
legend("topleft", gsub("[.]", " ", colnames(chagall)))
x=c(1910, 1917, 1923, 1941)
y=2e-08+seq(0, 3e-08, 1e-08)
z=c("프랑스\n유학", "러시아\n예술감독", "프랑스\n귀화", "미국\n이주")
for(i in 1:length(x)){
    arrows(x[i], y[i], x[i], 0, col="darkgray",
           angle=15, length=0.08, lty=1)
}
text(x, y+4e-09, labels=z, cex=0.7, col="purple")
rect(1910, 0, 1930, 5e-08, border=NA, col=heat.colors(1, alpha=0.05))
rect(1933, 0, 1945, 6e-08, border=NA, col=heat.colors(1, alpha=0.1))
text(c(1920, 1939), c(5e-08, 6e-08), labels = c("독일 미술 부흥기",
                                                "독일 나치 정권"), pos=3)

painters=scan(file="dat7.txt", what="", sep = "\n")
painters=data.frame(ngram(painters, corpus=c("fre_2019",
                                             "eng_us_2019",
                                             "ger_2019"),
                          year_start = 1900,
                          year_end = 1960))
german=cast(painters[painters$Corpus=="ger_2019", ], Year~Phrase, 
            value = "Frequency")
german=data.frame(row.names = german$Year, german[-1])

rsup=read.delim(file="dat8.txt", sep=",")
rsup$Russian.Name=as.character(rsup$Russian.Name)
rsup$English.Name=as.character(rsup$English.Name)
russian=data.frame(ngram(rsup$Russian.Name, corpus="rus_2019",
                         year_start = 1900,
                         year_end=1990))
russian=cast(russian, Year~Phrase, value="Frequency")
russian=data.frame(row.names = russian$Year, russian[-1])

plot(rownames(russian), russian[[1]], type="l", 
     ylim=c(0, max(russian)))
for(i in 2:length(russian)){
    lines(rownames(russian), russian[[i]], type="l")
}
legend("topleft", gsub("[.]", " ", colnames(russian)))
x=c(1927, 1936, 1940, 1988)
y=c(russian[[3]][rownames(russian)==x[1]],
    russian[[1]][rownames(russian)==x[2]],
    russian[[3]][rownames(russian)==x[3]],
    russian[[3]][rownames(russian)==x[4]])
segments(x, y, x, 0, lty=2)
text(x, y, labels=x, srt=90, cex=0.75, pos=3)

si1=read.delim(file="dat10.txt", row.names = 1, sep="\t")
si2=read.delim(file="dat11.txt", row.names = 1, sep="\t")
dens1=density(si1[[3]])
dens2=density(si2[[3]])
plot(dens1, xlim=c(min(dens1$x, dens2$x), max(dens1$x, dens2$x)),
     ylim=c(min(dens1$y, dens2$y), max(dens1$y, dens2$y)))
polygon(dens1, border=NA, col=hcl.colors(2, palette = "dark 3", alpha=0.2))
polygon(dens2, border=NA, col=hcl.colors(2, palette = "dark 3", alpha=0.2)[2])
legend("topleft", c("+black list", "-black list"), pch=15,
       pt.cex=1.5)

usa=scan(file="dat9.txt", what="", sep="\n")
us.si=si1[[3]]
names(us.si)=rownames(si1)
us.si[usa]

dotchart(us.si[sort(usa)])