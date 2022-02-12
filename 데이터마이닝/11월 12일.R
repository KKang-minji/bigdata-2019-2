
####################8.2 신경망 모형###################################
###예제 1
#install.packages("nnet")
library(nnet)

nn.iris <-nnet(Species~., data=iris, size=2, range=0.1, decay=5e-4, maxit=200)

#decay=5e-4 : 0.0005, 이값이 크면 클수록 오버피팅 값이 작아진다
#maxit=200 : 최대 반복수 
summary(nn.iris)

###결과 시각화(1)
#install.packages("devtools")
library(devtools)
source_url('https://gist.githubusercontent.com/Peque/41a9e20d6687f2f3108d/raw/85e14f3a292e126f1454864427e3a189c2fe33f3/nnet_plot_update.r')
plot(nn.iris)
#웨이트 값이 크면 클수록 선이 두꺼움

###정오분류표
pred.nnet <- predict(nn.iris, iris, type="class")
pred.nnet <- factor(pred.nnet) #문자열을 펙터로 바꿈
pred.nnet

cm.nnet <- table(iris$Species, pred.nnet)
cm.nnet  # Confusion Matrix (행:실체값, 열: 예측값)

caret::confusionMatrix(cm.nnet) # Confusion Matrix (행:실체값, 열: 예측값)
caret::confusionMatrix(reference=iris$Species, data=pred.nnet)
#caret에서 Confusion Matrix (행:예측값, 열: 실체값)




###예제 2
data(infert, package = "datasets")
head(infert)
summary(infert)

#######인공신경망
#install.packages("neuralnet")
library(neuralnet)
net.infert <- neuralnet(case~age+parity+induced+spontaneous, data=infert,
                        hidden=2, err.fct = "ce", linear.output = FALSE, likelihood = TRUE)
net.infert

#neuralnet()함수의 수행 결과의 추가적인 정보
names(net.infert)

plot(net.infert)

net.infert$net.result
#리스트 자료형 안에 매트릭스

#무슨자료인지 물어볼때
mode(net.infert$net.result)


#활성함수
net.infert$act.fct
#시그모이드 함수는 연속형으로 봄. 확률처럼 생각

#예측값 저장
#unlist: 리스트 없애고 벡터로 만들때
prob.neural <- unlist(net.infert$net.result)
prob.neural


###예제 2- iris
#split data
train_idx <- sample(nrow(iris), 2/3 * nrow(iris))
iris.train <- iris[train_idx, ]
iris.test <- iris[-train_idx, ]

# Binary classfication (output이 두개이다 (성공과 실패이런식))
nn <- neuralnet(Species == "setosa" ~., iris.train, linear.output = FALSE, hidden = 2)
pred <- predict(nn, iris.test)
table(iris.test$Species == "setosa", pred[, 1] > 0.5)

#Multiclass classfication
nn <- neuralnet((Species == "setosa")+ (Species == "versicolor")+
                  (Species =="virginica") ~., iris.train, linear.output=FALSE, hidden=2)
plot(nn)

pred <- predict(nn, iris.test)
head(pred)
pred

#몇번째에 큰값이 위치해 있는 지 알려줌
pred.idx <- apply(pred, 1, which.max) #행방향으로 할거면 1 열방향 2
pred.idx

levels(iris.test$Species)[c(1)]
levels(iris.test$Species)[c(2)]
levels(iris.test$Species)[c(3)]
levels(iris.test$Species)[c(1,2,3)]

pred.neural <- factor(levels(iris.test$Species)[pred.idx])
pred.neural
#species에서 큰수뽑아서 벡터로

table(iris.test$Species, pred.neural)


#neuralnet 함수는 hidden을 여려개 쓸수잇음
nn <- neuralnet((Species == "setosa")+ (Species == "versicolor")+
                  (Species =="virginica") ~., iris.train, 
                linear.output=FALSE, hidden=c(4,2))
plot(nn)
pred <- predict(nn, iris.test)
pred.idx <- apply(pred, 1, which.max) #행방향으로 할거면 1 열방향 2
pred.idx
pred.neural <- factor(levels(iris.test$Species)[pred.idx])
table(iris.test$Species, pred.neural)
