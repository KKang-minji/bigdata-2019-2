#반응변수 연속형인 경우
data(airquality)
head(airquality)
dim(airquality)
summary(airquality)

airq <- subset(airquality,!is.na(Ozone)) 
#subset: 큰데이터 가져옴, 조건 만족하는 행만 가져옴
head(airq)  #!is.na(Ozone):오존값이 잇는것만 가져옴. na 제거한 것들 가져옴
dim(airq)
summary(airq)


library(party)
airct <- ctree(Ozone ~ ., data = airq)
airct
plot(airct)

head(predict(airct, data=airq)) #예측한 값
head(predict(airct, data=airq, type="node")) #몇번 노드에 속해잇는지 나와잇음


#연속형으로 데이터가 저장되어있을때
#MSE(Mean Square Error)
mean((airq$Ozone - predict(airct))^2)
#airq$Ozone: 실제값

############5장 단순베이즈분류
library(e1071)

data(iris)
head(iris)
dim(iris)
summary(iris)

m <- naiveBayes(Species ~ . , data=iris) #1=평균 , 2=표준편차
m

m.pred <- predict(m, iris)
m.pred

#정오분류표
tb <- table(iris$Species, m.pred)

#정확도
(50+47+47)/150
sum(diag(tb))/sum(tb)

