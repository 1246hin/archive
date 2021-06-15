library(ngramr)
library(reshape)
ng=ngram(c("data science", "data mining", "big data"),
         year_start=1950)
ng
str(ng)
head(ng)
ggram(ng)

ng=ngram(c("burned", "burnt"), year_start=1800)
burn=data.frame(ng)
burn=cast(burn, Year~Phrase, value="Frequency")
burn=data.frame(row.names = burn$Year, burn[-1])
plot(rownames(burn), burn$burned, type="l", ylim=c(0, max(burn)))
lines(rownames(burn), burn$burnt, type="l", lty=2)
legend("topright", colnames(burn), lty=1:2, inset=0.02)

speed=data.frame(ngram(c("speeded", "sped"), year_start=1800))
speed=cast(speed, Year~Phrase, value="Frequency")
speed=data.frame(row.names=speed$Year, speed[-1])
plot(rownames(speed), speed$speeded, type="l", lty=1, ylim=c(0, max(speed)))
lines(rownames(speed), speed$sped, type="l", lty=2)

par(mfrow=c(1, 2))
plot(rownames(burn), burn$burned, type="l", lty=1, ylim=c(0, max(burn)))
lines(rownames(burn), burn$burnt, type="l", lty=2)
plot(rownames(speed), speed$speeded, type="l", lty=1, ylim=c(0, max(df)))
lines(rownames(speed), speed$sped, type="l", lty=2)