### 훈련자료
data.train <- read.csv("http://youngho.iwinv.net/data/heart_failure_clinical_records_train.csv")
data.train$DEATH_EVENT <- factor(data.train$DEATH_EVENT)
### 검정자료
data.test <- read.csv("http://youngho.iwinv.net/data/heart_failure_clinical_records_test.csv")
data.test$DEATH_EVENT <- factor(data.test$DEATH_EVENT)

library(caret)

#로지스틱회귀
model.glm <- glm(DEATH_EVENT~., data = data.train, family = "binomial")
model.glm.summ <- model.glm %>% summary()
model.glm.summ

model.glm.step <- model.glm %>%step(trace=F)
summary(model.glm.step) =model.glm.step %>% summary()

#검정자료 예측
#모형 평가(그래서 test데이터)
model.glm.prob <- predict(model.glm.step, data.test, type = "response")
=model.glm.prob <-model.glm.step %>% predict(data.test, type = "response")

model.glm.pred <- ifelse(model.glm.prob > 0.5, 1, 0) %>% factor()

caret::confusionMatrix(reference=data.test$DEATH_EVENT, data=model.glm.pred, positive="1")
caret::confusionMatrix(reference=data.test$DEATH_EVENT, data=factor(model.glm.pred), positive="1")
###Roc curve &AUC
library(ROSE)
library(ROSE)
library(e1071)
ROSE::roc.curve(data.test$DEATH_EVENT, model.glm.pred)
ROSE::roc.curve(data.test$DEATH_EVENT, model.glm.pred, col="red", add.roc=T)  



library(rpart)
library(rpart.plot)

model.rpart <- rpart(DEATH_EVENT~., data=data.train)
prp(model.rpart, type = 4, extra = 2)

###검정자료 예측
model.rpart.prob <- model.rpart %>% predict(data.test) %>% subset(select = 2, drop=T)
model.rpart.pred <- model.rpart %>% predict(data.test, type = "class")

caret::confusionMatrix(reference=data.test$DEATH_EVENT, data=model.rpart.pred, positive="1")

ROSE::roc.curve(data.test$DEATH_EVENT, model.rpart.pred)
ROSE::roc.curve(data.test$DEATH_EVENT, model.rpart.prob, col="red", add.roc=T)  



