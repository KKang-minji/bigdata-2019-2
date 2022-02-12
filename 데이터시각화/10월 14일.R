
getwd()
wd <- choose.dir()
wd <- "C:\\Users\\user\\Desktop\\3학년 2학기\\데이터시각화\\시각화를 이용한 데이터 정보분석 데이터파일\\시각화를 이용한 데이터 정보분석 데이터파일\\6장 기본데이터 시각화"
setwd(wd)
getwd()
list.files()

library("ggplot2")
r <- read.csv("kh.csv")
dim(r)
head(r)

####버블플롯
r$study1 <- factor(r$study, levels = c(2,3,4,5,6,7,8,9), 
                   labels = c("중학교중퇴", "중학교졸업","고등학교 중퇴","고등학교졸업","전문대","대졸","석사","박사"))

head(r)

ggplot(data=r, aes(x=money, y=age))+
  geom_point(aes(size=lifemoney*50), shape=21, colour="gray90", fill="green", alpha=0.5) + 
  geom_text(aes(y=as.numeric(age)-sqrt(lifemoney)/10,label=study, vjust=1, colour="gray40"))+
  scale_size_area(max_size = 15)+
  ggtitle("버블차트")
#vjust=세로 

sapply(r, class) #sapply(데이터 프레임, 함수)

?geom_text


######산점도행렬
names(r)
r1 <- r[c("age", "money", "lifemoney")]
head(r1)
plot(r1)
pairs(r1)  #산점도 행렬

#install.packages("GGally")
library(GGally)
ggpairs(r1)

plot(r)
ggpairs(r)


####################7장 

#####해바라기 산점도#####

head(r)
plot(r$money, r$lifemoney)
sunflowerplot(r$money, r$lifemoney)

x <- NULL
y <- NULL
for(i in 1:100) {
  x <- c(x,rep(ifelse(i%%10 ==0, 10, i%%10), i))
  y <- c(y, rep((i-1) %/% 10+1, i))
}
t(table(x,y))

m <- matrix(c(1,1,2,3), 2, byrow=T)  #byrow=T 행(row) 기준
m
layout(m)

sunflowerplot(x,y, ylim = c(0.5,5.2))
title(main = "해바라기 산점도")

text(x=ifelse(1:100 %% 10 == 0, 10, 1:100%%10), y=((1:100 -1)%/%10+1)-0.5, 
     as.character(1:100))

plot(x,y, pch=16)
title(main = "scatter plot by plot")

plot(jitter(x), jitter(y), pch=20)
title(main= "scatter plot by plot using jitter")

#layout(1)


x <- NULL
y <- NULL
for(i in 1:100){
  x <- c(x,rep(ifelse(i%%10==0, 10, i%%10), i))
  y <- c(y, rep((i-1) %/% 10+1, i))
}
#(1)
t(table(x,y))

m <- matrix(c(1,1,2,3), 2, byrow=T)
layout(m)
sunflowerplot(x,y,ylim=c(0.5,5.2))
title(main = '해바라기 산점도')
text(x=ifelse(1:100 %% 10 ==0, 10, 1:100%%10), 
     y=((1:100 -1)%/%10+1)-0.5, as.character(1:100))

plot(x,y,pch=16)
title(main = 'scatter plot by plot')

plot(jitter(x), jitter(y), pch=20)
title(main = 'scatter plot by plot using jitter')

layout(1)







