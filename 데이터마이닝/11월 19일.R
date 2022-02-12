
##############SVM(서포트 벡터 머신)#####################################
library(e1071)
data(iris)
#cost가 올라가면 마진이 작아짐
#gamma가 올라가면 표준편차 작아짐

svm.e1071 <- svm(Species ~., data= iris,
                 type= "C-classification", kernel = "radial",
                 cost = 10, gamma= 0.1)

#cost = 10, gamma= 0.1 이거에 따라 어큐러시가 달라짐
summary(svm.e1071)

plot(svm.e1071, iris, Petal.Width ~ Petal.Length, slice = list(Sepal.Width = 3,Sepal.Length = 4))

plot(svm.e1071, iris, Petal.Width ~ Petal.Length, slice = list(Sepal.Width = 2.5 ,Sepal.Length = 3))

pred <- predict(svm.e1071, iris, decision.values = TRUE)
#모형식, 새로운 데이터, decision values
pred

cm <- table(iris$Species, pred)
#데이터, 모형 예측값

sum(diag(cm))/sum(cm)

caret::confusionMatrix(reference=iris$Species, data=pred)
#positive는 분류가 두개일때만 지정
caret::confusionMatrix(cm)

tuned <- tune.svm(Species ~., data= iris, gamma= 10^(-6:-1), cost= 10^(1:2))
#모형식, 데이터 iris, gamma= 테스트하고싶은 여러개의 값
#총 12번 반복(6*2)

summary(tuned)
mode(tuned)
names(tuned)
tbpg <- tuned$best.parameters["gamma"]
tbpc <- tuned$best.parameters["cost"]

###최종모형
svm.tuned <- svm(Species ~., data= iris,
                 type= "C-classification", kernel = "radial",
                 cost = tbpc, gamma= tbpg)

pred.tuned <- predict(svm.tuned, iris)

cm <- table(iris$Species, pred.tuned)
cm

sum(diag(cm))/sum(cm)



### EX.3
#install.packages("kernlab")
library(kernlab)
#분석용 자료 생성
x <- c(1:20)
y <- c(3,4,8,4,6,9,8,12,15,26,35,40,45,54,49,59,60,62,63,68)
data <- data.frame(x,y)

plot(data, pch=16)

model <- lm(y ~ x, data)
#y를 출력변수 x 입력변수
summary(model) #intercept -10.2632가 절편 기울기는 3.9774
#(Intercept): 절편, x estimate가 기울기

abline(model, col="red")

mode(model)
names(model)
model$residuals

#에러
lm.error <- y-model$fitted.values #model$residuals
lm.mse <- mean(lm.error^2)
lm.mse
#목표변수 연속형. 연속형일때 mse로
lm.rmse <- sqrt(mean(lm.error^2))
lm.rmse <- sqrt(lm.mse)
lm.rmse


################# SVR(Support Vector Regression)
model <- svm(y ~x , data)
summary(model)

pred.y <- predict(model, data)

points(data$x, pred.y, col="red", pch=4)

error <- y - pred.y #실제 y와 예측y의 오차 
svr.rmse <- sqrt(mean(error^2))
svr.rmse
#lm.rmse와 svr.rmse 중 오차가 svr.rmse가 더 작기에 svr.rmse가 더 좋은값
