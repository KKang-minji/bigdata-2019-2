getwd()
wd <- choose.dir()
wd <- "C:\\Users\\user\\Desktop\\3학년 2학기\\데이터시각화\\시각화를 이용한 데이터 정보분석 데이터파일\\시각화를 이용한 데이터 정보분석 데이터파일\\6장 기본데이터 시각화"
setwd(wd)
getwd()
list.files()

r <- read.csv("kh.csv")
head(r)

r$gender1 <- factor(r$gender, level = c(1,2), labels = c("남","여"))
#labels = 표현을 글자로 하겠다. 순서 중요함. level이랑 순서가 맞아야함
r$gender1


tb <- table(r$gender1)
pie(tb)

library(ggplot2)

ggplot(r,aes(x="", y= r$money, fill=gender1)) +
  geom_bar(stat = "identity", width=1)+
  coord_polar(theta="y") + ggtitle("파이차트")
#fill=색을 어떻게 채울거냐, coord_polar()=막대그래프를 그려서 파이차트 그리는거
#theta= 파이차트를 어떤걸로 그릴거냐

###누적 막대 차트
head(r)

r$study1 <- factor(r$study, levels = c(2,3,4,5,6,7,8,9), labels = c("중학교중퇴",
           "중학교졸업","고등학교 중퇴","고등학교졸업","전문대","대졸","석사","박사"))

head(r)

tb <- table(r$gender1, r$study1)
barplot(tb)

ggplot(r, aes(x=study1))+ geom_bar(aes(fill=gender1),colour="black")+
  ggtitle("누적 막대 차트")


###라인 차트
r <- read.csv("weather.csv")
dim(r)
head(r)
summary(r)

plot(r$month, r$temporary, type="l")
#type="l" 선
plot(r$month, r$temporary, type="b")
#type=b 점,선 둘다
plot(r$month, r$temporary, type="o",pch=19)
#type="o" 점과 선 겹쳐서 / pch=19 점 색채우기,두껍게

?pch


qplot(month, temporary, data = r, geom = "line")

ggplot(r, aes(month, temporary))+geom_line()



x<- rnorm(100) #정규분포함수
boxplot(x)
r <- read.csv("kh.csv")
head(r)

r$study1 <- factor(r$study, levels = c(2,3,4,5,6,7,8,9), 
                   labels = c("중학교중퇴","중학교졸업","고등학교 중퇴","고등학교졸업","전문대","대졸","석사","박사"))
head(r)
#연속형
boxplot(r$money)
#연속형~범주형
boxplot(money~study1, data=r)



ggplot(r, aes(study1, money))+ geom_boxplot() +ggtitle("박스 플롯")

