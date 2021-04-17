#4-1
library(MASS)
var1=c("no", "no", "yes", "yes", 
       "no", "no", "yes", "yes")
var2=c("yes", "no", "yes", "no", 
       "yes", "no", "yes", "no")
var3=c("yes", "yes", "yes", "yes",
       "no", "no", "no", "no")
dat1=cbind(var1, var2, var3)
dat1=as.data.frame(dat1)
colnames(dat1)=c("residence", "arrest", "imprison")
dat1$freq=c(42, 17, 33, 53, 109, 75, 175, 359)
logit=glm(imprison~residence+arrest, data=dat1, 
          family = binomial, weights = freq)
summary(logit)

#calculating odds ratio and confidence interval
exp(cbind(coef(logit), confint(logit)))  

#-5
library(MASS)
v1=c(rep(4, 12), rep(3, 12), rep(2, 7), rep(1, 9))
v2=c(1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 
     0, 0, 1, 0, 1, 0, 1, 1, 0, 1,
     1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 
     0, 1, 1, 1, 0, 0, 0, 1, 0, 0)
v3=c(1, 9, 4, 3, 2, 0, 1, 3, 3, 7, 
     1, 2, 5, 6, 3, 1, 8, 2, 5, 5, 
     9, 3, 3, 1, 0, 4, 3, 9, 6, 4, 
     3, 8, 2, 7, 5, 4, 4, 8, 8, 9)
dat2=cbind(v1, v2, v3)
dat2=as.data.frame(dat2)
colnames(dat2)=c("mental", "social", "incident")
dat2$mental=as.factor(dat2$mental)

clogit=polr(mental~social+incident, data=dat2)
summary(clogit)

#4-7
#(1)
dat3=array(c(659,  432, 532, 269, 270, 532, 347, 552),
           dim=c(2, 2, 2),
           dimnames = list(seatbelt=c("yes", "no"),
                           bounce=c("yes", "no"),
                           survival=c("yes", "no")))
saturatedModel=loglm(~seatbelt*bounce*survival,
                     data=dat3)
step(saturatedModel, direction = "backward")
bestModel=loglm(formula = ~seatbelt + bounce + survival + seatbelt:bounce + 
                    seatbelt:survival + bounce:survival, data = dat3, evaluate = FALSE)
bestModel
print(coef(bestModel))

#(2)
var1=c("yes", "yes", "no", "no",  
       "yes", "yes", "no", "no")
var2=c("yes", "no", "yes", "no", 
       "yes", "no", "yes", "no")
var3=c("yes", "yes", "yes", "yes",
       "no", "no", "no", "no")
dat3.1=cbind(var1, var2, var3)
dat3.1=as.data.frame(dat3.1)
colnames(dat3.1)=c("seatbelt", "bounce", "survival")
dat3.1$freq=c(659, 532, 432, 269, 270, 347, 532, 552)

logit=glm(survival~seatbelt+bounce, data=dat3.1, 
          family = binomial, weights = freq)
summary(logit)

#calculating odds ratio and confidence interval
exp(cbind(coef(logit), confint(logit)))  

#4-9
#(1)
dat4=array(c(34, 29, 40, 37, 24, 6, 3,
             49, 31, 37, 32, 11, 0, 4,
             64, 61, 81, 65, 40, 15, 7, 
             135, 118, 142, 64, 37, 3, 2),
           dim = c(7, 2, 2),
           dimnames = list(time=c("0", "0~0.5",
                                  "0.5~1", "1~2",
                                  "2~4", "4~6", "6<"),
                           gender=c("male", "female"),
                           school=c("academic", "business")))
saturatedModel=loglm(~time*gender*school, data=dat4)
step(saturatedModel, direction = "backward")

bestModel=loglm(formula = ~time + gender + school + time:gender + gender:school, 
                data = dat4, evaluate = FALSE)
bestModel
print(coef(bestModel))

#(2)
dat4_1=array(c(34+29, 40+37, 24+6+3,
               49+31, 37+32, 11+0+4,
               64+61, 81+65, 40+15+7, 
               135+118, 142+64, 37+3+2), 
             dim=c(3, 2, 2), 
             dimnames = list(time=c("<0.5", "0.5~2", "2<"),
                             gender=c("male", "female"),
                             school=c("academic", "business")))
saturatedModel=loglm(~time*gender*school, data=dat4_1)
step(saturatedModel, direction = "backward")

bestModel=loglm(formula = ~time + gender + school + time:gender + gender:school, 
                data = dat4_1, evaluate = FALSE)
bestModel
print(coef(bestModel))

#5-2
#(1)
trt=c(rep(1, 3), rep(2, 3), rep(3, 3))
x=c(29, 4, 18, 17, 35, 3, 1, 15, 32)
y=c(39, 34, 36, 35, 38, 32, 38, 43, 44)        
dat5_1=as.data.frame(cbind(trt, x, y))
dat5_1$trt=as.factor(dat5_1$trt)
anova(lm(y~trt*x, data=dat5_1))

# (2)

# Type 1 SS
anova(lm(y~trt+x, data=dat5_1))

# Type 3 SS
library(car)
Anova(lm(y~trt+x, data=dat5_1), type=3)

# post-hoc test
library(emmeans)
library(tidyverse)
pwc=dat5_1 %>% emmeans_test(y~trt, covariate = x, 
                            p.adjust.method = "bonferroni")
pwc
get_emmeans(pwc)

summary(lm(y~trt+x, data=dat5_1))

# 5-7
## (1)
trt=c(rep(1, 20), rep(2, 20), rep(3, 20))
x1=c(99, 95, 99, 99, 102, 
     101, 102, 103, 102, 103, 
     102, 104, 106, 106, 107, 
     108, 109, 111, 110, 113,
     95, 97, 100, 100, 102,
     105, 102, 102, 105, 105,
     106, 109, 107, 108, 111,
     108, 111, 113, 114, 114,
     94, 95, 99, 99, 99,
     102, 99, 101, 104, 101,
     104, 107, 107, 106, 109,
     107, 109, 111, 111, 112)
x2=c(12, 11, 13, 13, 12,
     12, 12, 13, 13, 14,
     14, 13, 15, 13, 13,
     12, 13, 13, 13, 13,
     12, 12, 13, 13, 13,
     12, 13, 14, 12, 13,
     14, 13, 14, 14, 14,
     13, 13, 14, 13, 14,
     12, 12, 13, 11, 14,
     12, 13, 13, 13, 14,
     15, 13, 13, 14, 14,
     14, 14, 14, 14, 13)
y=c(58, 55, 59, 55, 60,
    57, 57, 61, 58, 59,
    62, 59, 60, 62, 60,
    62, 64, 63, 59, 63,
    58, 55, 60, 55, 60,
    58, 57, 62, 58, 61,
    63, 59, 61, 64, 61,
    63, 65, 64, 62, 60,
    59, 56, 62, 57, 61,
    60, 58, 63, 60, 63,
    65, 61, 62, 64, 61,
    65, 63, 66, 62, 64)
dat5_2=cbind(trt, x1, x2, y)
dat5_2=as.data.frame(dat5_2)
dat5_2$trt=as.factor(dat5_2$trt)
anova(lm(y~trt*x1*x2, data=dat5_2))

# (2)
# Type 1 SS
anova(lm(y~trt+x1+x2, data=dat5_2))

# Type 3 SS
library(car)
Anova(lm(y~trt+x1+x2, data=dat5_2), type=3)

# post-hoc test
library(emmeans)
library(tidyverse)
pwc=dat5_2 %>% emmeans_test(y~trt, covariate = c(x1, x2), 
                            p.adjust.method = "bonferroni")
pwc
get_emmeans(pwc)

summary(lm(y~trt+x1+x2, data=dat5_2))





