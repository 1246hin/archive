# 6-3
library(tidyverse)
library(rstatix)
dat3=matrix(c(1, 21.3, 21.1, 22.6, 24.2, 21.1, 22.1, 31.3, 25.2,
                1, 22.1, 22.6, 25.2, 26.8, 22.6, 26.2, 30.5, 26.2,
                1, 21.6, 25.2, 25.7, 28.2, 34.1, 31.9, 27.9, 25.9,
                1, 24.7, 25.7, 26.2, 27.9, 28.2, 35.6, 26.5, 30.2,
                1, 22.6, 24.1, 23.8, 24.5, 29.2, 29.6, 30.5, 33.1,
                2, 27.3, 20.1, 20.1, 24.1, 28.9, 29.5, 26.3, 23.7,
                2, 22.6, 26.5, 30.4, 26.8, 29.2, 28.5, 25.9, 26.2,
                2, 24.2, 23.6, 24.2, 27.2, 30.2, 30.1, 33.2, 25.2,
                2, 26.7, 23.7, 25.2, 27.5, 27.6, 26.5, 31.0, 22.6,
                2, 22.3, 28.2, 28.1, 24.7, 25.6, 29.3, 29.9, 32.9
                ), nrow=10, byrow = T)
obs=c(seq(1, 10))
colnames(dat3)=c("gender", "Trt1_Hr_10", "Trt1_Hr_20", "Trt1_Hr_30",
                 "Trt1_Hr_40", "Trt2_Hr_10", "Trt2_Hr_20", "Trt2_Hr_30",
                 "Trt2_Hr_40")
dat3=as.data.frame(dat3)
dat3$obs=as.factor(obs)
dat3=dat3 %>% gather("key", "score", 2:9) %>% 
    separate(key, c("temp1", "temp2", "time"), "_") %>% 
    mutate(trt=as.factor(ifelse(temp1=="Trt1", 1, 2))) %>% 
    select(gender, obs, time, score, trt)

dat3 %>% anova_test(score~time*trt*gender+Error(obs/time*trt))

# 6-6
dat6=matrix(c(190, 212, 213, 195, 248, "N",
              187, 177, 200, 190, 206, "P",
              98, 137, 185, 215, 225, "N",
              205, 230, 172, 196, 232, "P",
              155, 145, 196, 189, 176, "N",
              165, 142, 195, 185, 170, "P",
              245, 228, 280, 274, 260, "N",
              256, 232, 252, 326, 292, "P",
              182, 205, 218, 194, 193, "N",
              197, 182, 160, 210, 185, "P",
              140, 138, 187, 195, 205, "N",
              134, 115, 150, 165, 170, "P",
              196, 185, 185, 227, 180, "N",
              196, 166, 166, 188, 205, "P",
              162, 176, 192, 230, 215, "N",
              167, 144, 176, 155, 185, "P",
              195, 232, 199, 185, 200, "N",
              98, 102, 89, 128, 130, "P",
              167, 187, 228, 192, 210, "N",
              167, 175, 122, 162, 125, "P",
              123, 165, 145, 185, 215, "N",
              123, 136, 147, 130, 135, "P",
              105, 144, 119, 168, 165, "N",
              95, 102, 154, 105, 112, "P",
              161, 177, 162, 185, 192, "N",
              181, 177, 140, 212, 230, "P",
              255, 242, 330, 284, 319, "N",
              237, 232, 245, 193, 245, "P",
              144, 195, 180, 184, 213, "N",
              144, 172, 163, 158, 188, "P",
              180, 218, 224, 165, 200, "N",
              182, 202, 254, 185, 173, "P",
              126, 145, 173, 175, 140, "N",
              165, 140, 153, 180, 155, "P",
              175, 155, 154, 164, 154, "N",
              196, 195, 204, 188, 178, "P",
              227, 218, 245, 235, 257, "N",
              175, 197, 195, 182, 193, "P"),
            nrow = 38, byrow = T)
obs=c(seq(1, 38))
colnames(dat6)=c("m0", "m1", "m2", "m3", "m4", "trt")
dat6=as.data.frame(dat6)
dat6$obs=as.factor(obs)
dat6=dat6 %>% gather("key", "score", 1:5) %>% 
    separate(key, c("temp", "month"), sep="m") %>% 
    select(trt, obs, month, score)
dat6$score=as.numeric(dat6$score)
dat6$month=as.factor(dat6$month)
dat6 %>% anova_test(score~month*trt+Error(obs/month))

# 7-2
dat2=matrix(c(rep(c(1, 1), 82), rep(c(1, 0), 0),
              rep(c(2, 1), 30), rep(c(2, 0), 8),
              rep(c(3, 1), 27), rep(c(3, 0), 8),
              rep(c(4, 1), 22), rep(c(4, 0), 7),
              rep(c(5, 1), 26), rep(c(5, 0), 7),
              rep(c(6, 1), 25), rep(c(6, 0), 28),
              rep(c(7, 1), 20), rep(c(7, 0), 31),
              rep(c(8, 1), 11), rep(c(8, 0), 32),
              rep(c(9, 1), 14), rep(c(9, 0), 24),
              rep(c(10, 1), 13), rep(c(10, 0), 27),
              rep(c(11, 1), 5), rep(c(11, 0), 22),
              rep(c(12, 1), 5), rep(c(12, 0), 23),
              rep(c(13, 1), 5), rep(c(13, 0), 18),
              rep(c(14, 1), 2), rep(c(14, 0), 9),
              rep(c(15, 1), 3), rep(c(15, 0), 7),
              rep(c(16, 1), 3), rep(c(16, 0), 11)),
            ncol=2, byrow = T)
colnames(dat2)=c("time", "censor")
dat2=as.data.frame(dat2)
lifeTab=lifeTable(dataSet = dat2, timeColumn = "time", censColumn = "censor")
lifeTab
plot(lifeTab[["Output"]][["S"]], type="b")


# 7-3
library(survival)
library(survminer)
dat3=matrix(c(2, 1, 4, 1, 5, 1, 10, 1, 10, 0, 12, 1,
              12, 0, 14, 1, 14, 1, 15, 1, 16, 1, 18, 1, 
              19, 1, 23, 1, 25, 1, 26, 0, 17, 1, 30, 0,
              31, 1, 34, 1, 35, 1, 37, 0, 38, 1, 39, 1,
              42, 0, 43, 0, 46, 1, 47, 0, 49, 1, 50, 1,
              53, 0, 54, 0), ncol=2, byrow = T)
colnames(dat3)=c("time", "censor")
dat3=as.data.frame(dat3)
fit=survfit(Surv(time=dat3$time, event = dat3$censor)~1)
fit
summary(fit)
ggsurvplot(fit, data=dat3)

# 7-4
library(survMisc)
time=c(1, 2, 5, 5, 5, 7, 9, 11, 11, 13, 13, 16, 20, 
       21, 22, 22, 31, 33, 37, 43, 1, 3, 4, 4, 5, 7,
       7, 9, 9, 14, 17, 19, 27, 30, 41)
censor=c(rep(1, 14), 0, 1, 0, 0, 0, 1, rep(1, 9), 0, 
         1, 0, 0, 0, 0)    
group=c(rep(1, 20), rep(2, 15))    
dat4=cbind(time, censor, group)
dat4=as.data.frame(dat4)
logRank=survdiff(Surv(time, censor)~group, data = dat4)    
fit=survfit(Surv(time, censor)~group, data=dat4)    
summary(fit)    
ggsurvplot(fit, data=dat4)    
comp(ten(fit))

# 7-6
dat6=matrix(c(18, 1, 0, 0, 8, 1, 1, 0,
              9, 1, 0, 1, 2, 1, 1, 1,
              28, 0, 0, 0, 26, 0, 1, 0,
              31, 1, 0, 1, 10, 1, 1, 1,
              39, 0, 0, 1, 4, 1, 1, 0,
              19, 0, 0, 1, 3, 1, 1, 0,
              45, 0, 0, 1, 4, 1, 1, 0,
              6, 1, 0, 1, 18, 1, 1, 1,
              8, 1, 0, 1, 8, 1, 1, 1,
              15, 1, 0, 1, 3, 1, 1, 1, 
              23, 1, 0, 0, 14, 1, 1, 1, 
              28, 0, 0, 0, 3, 1, 1, 0,
              7, 1, 0, 1, 13, 1, 1, 1,
              12, 1, 1, 0, 13, 1, 1, 1, 
              9, 1, 1, 0, 35, 0, 1, 0), ncol = 4, byrow = T)
colnames(dat6)=c("time", "censor", "age", "coagulation")
dat6=as.data.frame(dat6)
cox=coxph(Surv(time, censor)~age+coagulation, data=dat6)
summary(cox)

# 8-3
# (1)
n_e=8; m_e=75.38; sd_e=4.09;
n_c=8; m_c=69.12; sd_c=4.09;
S=sd_e;
delta1=(m_e-m_c)/S;
delta2=4*(n_e+n_c-3)/(4*(n_e+n_c)-9)*delta1;
sig2_d=(n_e+n_c)/(n_e*n_c)+delta2**2/(2*(n_e+n_c));
alpha=0.05;
delta_l=delta2-qnorm(1-alpha/2)*sqrt(sig2_d);
delta_u=delta2+qnorm(1-alpha/2)*sqrt(sig2_d);  
c(delta_l, delta_u)

# (2)
n_e=8; m_e=75.38; sd_e=4.09;
n_c=8; m_c=69.12; sd_c=4.09;
S=sd_e;
delta1=(m_e-m_c)/S;
delta2=4*(n_e+n_c-3)/(4*(n_e+n_c)-9)*delta1;
sig2_d=(n_e+n_c)/(n_e*n_c)+delta2**2/(2*(n_e+n_c));
alpha=0.05;a=sqrt(4+2*n_e/n_c+2*n_c/n_e);
hd=sqrt(2)*log(delta2/a+sqrt(delta2**2/a**2+1));
eta_l=hd-qnorm(1-alpha/2)/sqrt(n_e+n_c);
eta_u=hd+qnorm(1-alpha/2)/sqrt(n_e+n_c);
delta_l=sqrt(8)*sinh(eta_l/sqrt(2));
delta_u=sqrt(8)*sinh(eta_u/sqrt(2));
c(delta_l, delta_u)

# 8-4
library(tidyverse)
dat4=matrix(c(70, 71, -0.33,
       60, 59, 0.07,
       77, 114, -0.30,
       118, 136, 0.35,
       32, 62, 0.70,
       10, 10, 0.85,
       45, 45, 0.40,
       30, 30, 0.48,
       40, 40, 0.37,
       61, 64, -0.06), ncol=3, byrow=T)
dat4=as.data.frame(dat4)
colnames(dat4)=c("n_e", "n_c", "d")
dat4 %>% mutate(sig2_d=(n_e+n_c)/(n_e*n_c)+d^2/(2*(n_e+n_c)),
                dplus_l=1/sig2_d, dplus_u=d*dplus_l,
                sum1=sum(dplus_l), sum2=sum(dplus_u),
                dplus=sum2/sum1,
                sig2_dp=1/sum1) %>% 
    summarise(delta_l=dplus-qnorm(1-0.05/2)*sqrt(sig2_dp),
              delta_u=dplus+qnorm(1-0.05/2)*sqrt(sig2_dp),
              sig2_d=sig2_d)

# 8-7
dat7=matrix(c(20, 0.41,
              30, 0.53,
              27, 0.51,
              42, 0.43,
              49, 0.37,
              12, 0.39,
              17, 0.45,
              35, 0.40,
              38, 0.36,
              40, 0.52), ncol=2, byrow = T)
dat7=as.data.frame(dat7)
colnames(dat7)=c("n_e", "r")
dat7 %>% mutate(z=(1/2)*log((1+r)/(1-r)),
                 zplus_1=(2*n_e-3)*z,
                 sum1=sum(zplus_1),
                 sum2=sum(n_e),
                 zplus=sum1/(2*sum2-3*10),
                 rplus=(exp(2*zplus)-1)/(exp(2*zplus)+1),
                 delta=(2*rplus)/sqrt(1-rplus*rplus),
                 ksi_l=zplus-qnorm(1-0.05/2)/sqrt(2*sum2-3*10),
                 ksi_u=zplus+qnorm(1-0.05/2)/sqrt(2*sum2-3*10), 
                 rho_l=(exp(2*ksi_l)-1)/(exp(2*ksi_l)+1),
                 rho_u=(exp(2*ksi_u)-1)/(exp(2*ksi_u)+1)) %>% 
    summarise(delta_l=(2*rho_l)/sqrt(1-rho_l*rho_l), 
              delta_u=(2*rho_u)/sqrt(1-rho_u*rho_u)) %>% 
    head(1)

# 1
library(meta)
data("Fleiss93")

meta1=metabin(event.e, n.e, event.c, n.c, studlab = paste(study, year),
        sm="OR", method = "inverse", data=Fleiss93)
meta1
forest(meta1, comb.fixed=F, leftcols="studlab", rightcol=F)

meta2=metabin(event.e, n.e, event.c, n.c, studlab = paste(study, year),
        sm="OR", method = "MH", data=Fleiss93)
meta2
forest(meta2, comb.fixed=F, leftcols="studlab", rightcol=F)

meta3=metabin(event.e, n.e, event.c, n.c, studlab = paste(study, year),
              sm="OR", method = "Peto", data=Fleiss93)
meta3
forest(meta3, comb.fixed=F, leftcols="studlab", rightcol=F)

# 2
par(mar=c(1,1,1,1))
funnel(meta1)
meta1TF=trimfill(meta1)
meta1TF
funnel(meta1TF)
