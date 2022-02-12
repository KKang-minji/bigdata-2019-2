
############3##### 6장 {caret} 패키지 소개
library(caret)
data(iris)
library(dplyr)
### 훈련용 자료와 검정용 자료
set.seed(1234)

#createDataPartition: 자동으로 데이터를 훈련 데이터와 테스트 데이터로 분할한다.
inTrain <- createDataPartition(y = iris$Species, # 반응치 자료가 필요 
                               p = 0.6, # 훈련용 데이터의 비율
                               list = FALSE) # 결과의 형식 지정 : 리스트 형식으로 할거니 ? FALSE 아니!!

inTrain
# 훈련용과 검정용 자료를 저장
training <- iris[inTrain,]
testing <- iris[-inTrain,] #제외된 애들을 테스팅에다가 넣기

dim(training)

dim(testing)

head(training)

########################## 의사결정나무 ##########################
library(rpart)
library(rpart.plot)


### 모형 적합
fit.rpart <-rpart(Species~., data=training)
prp(fit.rpart, type =4, extra = 2)

### 검정자료 예측
pred.rpart <- predict(fit.rpart, testing, type = "class")
pred.rpart
#왼쪽: 모델, 오른쪽: 데이터

### 정오분류표
caret::confusionMatrix(reference = testing$Species, data = pred.rpart)

###중요도 계산
model <- train(Species ~ ., data= training, method="rpart")
model

#변수 중요도 추정
importance <- varImp(model, scale=F)
importance
#varImp는 의사 결정 나무의 노드에서 가지가 나뉠 때의 손실 함수감소량을 
#각 변수에 더하는 방법으로 변수 중요도를 평가한다.
#scale=T: 디폴트 변수 중요도를 0~100사이의 값으로 제공 
plot(importance)

###단순베이즈분류
library(e1071)


###모형 적합
fit.naive <- naiveBayes(Species ~ . , data=training) #1=평균 , 2=표준편차
fit.naive
### 검정자료 예측
pred.naive <- predict(fit.naive, testing)
pred.naive

table(testing$Species, pred.naive)

###정오분류표
caret::confusionMatrix(reference=testing$Species,data=pred.naive)
#Accuracy 로 비교하면 된다.

###중요도 계산
#여러개
model <- train(Species ~., data=training, method="nb")
model

inportance <- varImp(model, scale=F)
plot(inportance)


#####7장 k-인접이웃분류
###ex.1
#install.packages("class")
library(class)

data("iris3")
iris3 %>% str()
#1~50개중 반 나눠서 train, test 나눔
train <- rbind(iris3[1:25,,1], iris3[1:25,,2], iris3[1:25,,3])
test <- rbind(iris3[26:50,,1], iris3[26:50,,2], iris3[26:50,,3])
cl <- factor(c(rep("s",25),rep("c",25),rep("v",25)))
class::knn(train, test, cl, k=3, prob = TRUE)
attributes(knn)

###ex.2
#install.packages("DMwR")
library(DMwR)
data(iris)
idxs <- sample(1:nrow(iris), as.integer(0.7*nrow(iris)))
#1부터 iris 행까지 중 as.integer(0.7*nrow(iris)) 개수 만큼 가져오기

trainIris<- iris[idxs,]

testIris <- iris[-idxs,]

#k=3
nn3 <- DMwR::kNN(Species~., trainIris, testIris, norm=FALSE, k=3)
#norm=FALSE: 정규화수행하지 않고 분석
table(testIris[,'Species'], nn3)

#k=5
nn5 <- kNN(Species~., trainIris, testIris, norm=TRUE, k=5)
table(testIris[,'Species'], nn5)


#virginica가 k=3는 12개 나왓는데 k=5는 11개라고 잘못나왓으므로 k=3가 더 좋은 모형

