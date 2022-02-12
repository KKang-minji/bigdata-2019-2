#####의사결정 나무
###ex1
library(rpart)

head(iris)

c <- rpart(Species ~ ., data=iris)
c

plot(c, compress = T, margin = 0.3)
text(c, cex=1.5)

#install.packages("rpart.plot")
library(rpart.plot)

prp(c, type = 4, extra=2)


pred <- predict(c, newdata=iris, type="class")
pred

iris$Species
table(iris$Species, pred)

prp(c, type=2, extra = 4)

?prp

#install.packages("party")

library(party)

data("stagec")

head(stagec)
summary(stagec)

stagec1 <- subset(stagec, !is.na(g2))  #결측값이 포함되어 있는지 확인하는 방법
#subset 다음조건 충족하는 애들만 가져와라 subset(데이터, 조건)

summary(stagec1)

stagec2 <- subset(stagec1, !is.na(gleason))
stagec3 <- subset(stagec2, !is.na(eet))

stagec3 <- na.omit(stagec) #결측치 제거
#미씽벨류 지우기
dim(stagec)
dim(stagec3)

set.seed(1234)
#set.seed 초기값 고정시킴
sample(1:10, 5)
#랜덤값
sample(1:10, 5, replace = TRUE)

set.seed(1234)
ind <- sample(2, nrow(stagec3), replace = TRUE, prob = c(0.7,0.3))
#prob = c(뽑힐가능성,안뽑힐가능성)
ind

trainData <- stagec3[ind==1,]
testData <- stagec3[ind==2, ]

head(trainData)
summary(trainData)
tree <- ctree(ploidy ~ .,data= trainData)
#data= 앞에쓴 ploidy 데이터는 traindata에 잇다.
tree

plot(tree)

testpred <- predict(tree, newdata=testData)
testpred
table(testData$ploidy, testpred)

#훈련자료
data.train <- read.csv(choose.files(),header = T, stringsAsFactors = T)
#검정자료
data.test<- read.csv(choose.files(), header = T, stringsAsFactors = T)

#library
library(rpart)
library(rpart.plot)

head(data.train)
fit.rpart <- rpart(quality~., data=data.train)
prp(fit.rpart, type = 2, extra = 4)

rpart.plot(fit.rpart)
#색깔로 표현

###검정자료 예측
pred.rpart <- predict(fit.rpart, data.test, type = "class")
pred.rpart

###정오분류표(모형 평가하기 위해)
table(data.test$quality, pred.rpart)


library(caret)

caret::confusionMatrix(reference=data.test$quality, data=pred.rpart, positive="Good")
#Accuracy 로 비교하면 된다.

#더 정확하게 비교하려면
#install.packages("ROSE")
library(ROSE)
roc.curve(data.test$quality, pred.rpart)
#Accuracy와 (AUC)기준으로봣을때 의사결정 나무의 성능이 떨어짐 로지스틱 회귀가 더 좋음

#확률
prob.rpart <- predict(fit.rpart, data.test) 
prob.rpart <- prob.rpart[,2]
prob.rpart
#good에대한 것만 저장

roc.curve(data.test$quality, prob.rpart, add.roc = T, col="red")
#prob.rpart = good확률, add.roc = T 기존그림 위에 덧그림
