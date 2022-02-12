

#########예시?######
### winequality_red
# 훈련자료 winequality_red_train.csv
data.train <- read.csv(choose.files(), header=T, stringsAsFactors = T)
# 검증자료 winequality_red_test.csv
data.test <-  read.csv(choose.files(), header=T, stringsAsFactors = T)

head(data.train)

head(data.test)

library(nnet)


### 변수의 스케일 변환 - 표준화 변환
library(caret)
data.pre.pro <- caret::preProcess(data.train, method = c("center", "scale"))
data.train <- predict(data.pre.pro, data.train)
data.test <- predict(data.pre.pro, data.test)

### 모형 적합
fit.nnet <- nnet(quality ~., data= data.train, size = 10, maxit=1000)

#검정 자료 예측
pred.nnet <- predict(fit.nnet, data.test, type = "class")
pred.nnet <- factor(pred.nnet)

### 정오분류표
table(data.test$quality, pred.nnet)

###confusionMatrix
caret::confusionMatrix(reference=data.test$quality, data=pred.nnet, positive="Good")
#reference= 실제 데이터
#positive를 (good, bad)어떻게 하느냐에 따라 sensitive가 바뀜

###ROC curve & AUC
ROSE::roc.curve(data.test$quality, pred.nnet)

#확률값 
prob.nnet <- predict(fit.nnet, data.test)
prob.nnet <- prob.nnet[,1]
#### 중요도 계산(은닉층 1개,  이진분류)


#install.packages("NeuralNetTools")
library(NeuralNetTools)
library(ggplot2)
NeuralNetTools::garson(fit.nnet)+ coord_flip()

