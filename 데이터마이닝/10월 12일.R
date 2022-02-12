###실습
#install.packages("ROSE")
#install.packages("e1071")
library(ROSE)
library(e1071)



#훈련자료
data.train <- read.csv(choose.files(),header = T, 
                       stringsAsFactors = T)
#검정자료
data.test <- read.csv(choose.files(),header = T, 
                      stringsAsFactors = T)


dim(data.train)
head(data.train)
summary(data.train)

#quality를 제외한 모든 변수를 입력변수로 사용
###모형 적합
fit.glm <- glm(quality~., data = data.train, family = "binomial")
summary(fit.glm)

fit.step <- step(fit.glm)
summary(fit.step)



confint(fit.glm, parm= "alcohol")
exp(confint(fit.glm, parm= "alcohol"))

#검정자료 예측
#모형 평가(그래서 test데이터)
pred.prob <- predict(fit.glm, data.test, type = "response")
pred.glm <- ifelse(pred.prob>0.5, "Good","Bad")
pred.glm


###정오분류표
table(data.test$quality, pred.glm)

library(caret)

###confusion matrix and statistics

caret::confusionMatrix(reference=data.test$quality, data=factor(pred.glm), positive="Good")

                                                                    
###Roc curve &AUC
roc.curve(data.test$quality, pred.glm)
#test데이터를 이용해서 굿배드                       
roc.curve(data.test$quality, pred.prob, col="red", add.roc=T)    
#add.roc=T=기존 roc커브 위해 덧붙여 그리겠다


#########################################
###4강  의사결정나무 

#c4.5는 이산형일때 다진, 연속형일때 이진

