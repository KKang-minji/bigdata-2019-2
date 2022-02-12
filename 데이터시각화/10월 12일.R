#####산점도
getwd()
setwd(choose.dir())
getwd()

r <- read.csv("kh.csv")
dim(r)
head(r)

r$baby1 <- factor(r$baby, levels=c(1,2), labels = c("예","아니오"))
head(r,50)

###
plot(r$lifemoney, r$money, pch=19)
plot(money~lifemoney, data = r, pch=19)
#y축=money x축=lifemoney

###
library(ggplot2)
ggplot(data=r, aes(x= lifemoney, y=money)) +
  geom_point(shape=19, size=3, colour="red")





###점 모양
?points

### 
ggplot(data=r, aes(x= lifemoney, y=money, colour=baby1)) +
  geom_point(size=3)


###
plot(money~lifemoney, data=r, pch=19)


res <- lm(money~lifemoney, data=r) #회귀분석
res

plot(lifemoney~money, data=r)
res <- lm(lifemoney~money, data=r)
res
abline(40.3791, 0.0336, col="red")

plot(lifemoney~money, data=r)
abline(res, col="red")


####버블플롯
r$study1 <- factor(r$study, levels = c(2,3,4,5,6,7,8,9), 
                   labels = c("중학교중퇴", "중학교졸업","고등학교 중퇴","고등학교졸업","전문대","대졸","석사","박사"))

head(r)


