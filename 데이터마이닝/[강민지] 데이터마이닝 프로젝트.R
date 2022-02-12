library(dplyr)
library(caret)
library(class)
library(party)
library(ROSE)
library(e1071)

data.file <- file.choose()
data.file
df <- read.csv(data.file)
df

head(df)
str(df)
summary(df)

#id 변수제거 
data <- df %>% select(-id)
data
#diagnosis변수 인자 변수로 변환
data$구분 <- factor(ifelse(data$diagnosis=='B','양성','악성'))
data$구분
data.rej <- data[,-1]

data.rej %>% str()

#createDataPartition: 자동으로 데이터를 훈련 데이터와 테스트 데이터로 분할한다.
inTrain <- createDataPartition(y = data$구분, # 반응치 자료가 필요 
                               p = 0.6,       # 훈련용 데이터의 비율
                               list = FALSE)  # 결과의 형식 지정 : 리스트 형식으로 할거니 ? FALSE 아니!!


set.seed(1234)

inTrain <- createDataPartition(y = data$구분,
                               p = 0.6,       
                               list = FALSE)  

# 훈련용과 검정용 자료를 저장
intrain <- data.rej[inTrain,]
intest <- data.rej[-inTrain,]

head(intrain)
summary(intrain)

###########################의사결정나무

#data= 앞에쓴 ploidy 데이터는 traindata에 잇다.

tree <- ctree(구분 ~ .,data= intrain)


plot(tree)

testpred <- predict(tree, newdata=intest)

table(intest$구분, testpred)

caret::confusionMatrix(reference=intest$구분, 
                       data=testpred, positive="양성")

roc.curve(intest$구분, testpred)

# 1에 가까울수록 정확한거
testpred %>% str()
############################# SVM #################################################

svm.1 <- svm(구분~., data=intrain, type="C-classification", 
               kernel="radial", cost=10,gamma=0.1)
summary(svm.1)

pred.1 <- predict(svm.1, intest, decision.values = TRUE)
table(pred.1, intest$구분)

#조율
tuned <- tune.svm(구분~., data=intrain, 
                    gamma = 10^(-6:-1), cost = 10^(1:2))
summary(tuned)

#최적의 모수 SVM
svm.2 <- svm(구분~., data=intrain, type="C-classification", 
               kernel="radial", cost=10,gamma=0.001)
summary(svm.2)

pred.2 <- predict(svm.2, intest, decision.values = TRUE)
table(pred.2, intest$구분)

roc.2 <- roc.curve(intest$구분, pred.2)

#AUC 비교
roc.curve(intest$구분, pred.2, add.roc = T, col="red")

(79+137)/(79+137+5+5) 
(77+142)/(77+142+7)
(78+134)/(78+134+6+8)
