##
##############5장 단순베이즈분류
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
tb<- table(iris$Species, m.pred)
tb<- table(m.pred,iris$Species)

#정확도
(50+47+47)/150
sum(diag(tb))/sum(tb)


###ex.2
#install.packages("klaR")
library(klaR)
library(dplyr)

spam <- read.csv(file.choose())
dim(spam)
head(spam)
tail(spam)
summary(spam)

spam$spam <- factor(spam$spam) #데이터 프레임$변수
#factor : 범주형 자료일때 사용(ex:남자, 여자)

set.seed(1234)
#랜덤중 일정한 규칙들로 나옴
train.ind <- sample(1: nrow(spam), ceiling(nrow(spam)*2/3), replace = FALSE) 
#샘플링
#ceiling: x보다 큰 수 중에 가장 작은 정수를 나타내주는 함수
#replace: 복원추출
nb.res<- NaiveBayes(spam ~ ., data= spam[train.ind,])
#인덱싱..?, 행에 관한 데이터들을 뽑음
#spam을 결과변수, 나머지 입력변수
data.train <- spam[train.ind,]
#샘플값 불러온것
nb.res<- NaiveBayes(spam ~ ., data= data.train)

#plot(nb.res)

data.test <- spam[-train.ind, ]

nb.pred <- predict(nb.res, data.test)
nb.pred <- predict(nb.res, spam[-train.ind,])

confusion.mat <- table(nb.pred$class, spam[-train.ind,"spam"]) 
#table은 뭐랑뭐랑 비교하는것 확률로 비교아님
#첫번째 예측 모델(세로), 두번째 실제값(가로)
#스펨 테스트데이터에서 스팸이라는 변명을 가지고잇는 데이터가져옴
confusion.mat

#정확도
sum(diag(confusion.mat))/ sum(confusion.mat)

library(e1071)
#install.packages("mlbench")
data(HouseVotes84, package = "mlbench")
#패키지에 있는 이 데이터 가져옴
head(HouseVotes84) #찬성=y 반대=N 무=NA

summary(HouseVotes84)

model <- naiveBayes(Class ~ ., data= HouseVotes84)

pred <- predict(model, HouseVotes84)
#이 모델을 이데이터 가지고 예측
tab <- table(pred, HouseVotes84$Class)
tab
#첫번째 예측 모델(세로), 두번째 실제값(가로)

table(HouseVotes84$Class)


#정확도 
sum(tab[row(tab)==col(tab)])/sum(tab)
#row(tab): 행이 같은거 
#col(tab): 열이 같은거
#tab[row(tab)==col(tab)]:row(tab), col(tab) 둘다 같은 1행1열, 2행2열 수

