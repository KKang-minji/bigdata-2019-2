
############################SVM,SVR##############################
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
summary(model)
#(Intercept): 절편

abline(model, col="red")

mode(model)
names(model)
model$residuals

#에러
lm.error <- y-model$fitted.values #model$residuals
lm.mse <- mean(lm.error^2)
lm.mse
#목표변수 연속형. 연속형일때 mse로
lm.rmse <- sqrt(lm.mse)
lm.rmse


### SVR
model <- svm(y ~x , data)
summary(model)

pred.y <- predict(model, data)

points(data$x, pred.y, col="red", pch=4)

error <- y - pred.y
svr.rmse <- sqrt(mean(error^2))
svr.rmse

#튜닝하지않은 기본값
#lm.rmse와 svr.rmse 중 오차가 svr.rmse가 더 작기에 svr.rmse가 더 좋은값

#######################################################################
##############################tune#####################################
library(e1071)
tuneResult <- tune(svm, y ~ x, data=data, 
                   ranges=list(epsilon=seq(0,1,0.1), cost=2^(2:9)))

tuneResult
#색이 짙을 수록 RMSE가 0에 가까움 그래서 더 나은 모형임
#epsilon이 작을 때 좋음  #입실론이 0일때 좋다.

plot(tuneResult)

#최소의 오차를 갖는 모형
tuneResult <-  tune(svm, y ~ x, data=data, 
                    ranges=list(epsilon=seq(0,0.2,0.01), cost=2^(2:9)))

print(tuneResult)

plot(tuneResult)

mode(tuneResult)
names(tuneResult)

#최적의 모형을 가지고 예측수행
tunedModel <- tuneResult$best.model
tunedModel

tpred.y <- predict(tunedModel, data)
tpred.y

error <- data$y - tpred.y
mean(error^2) #MSE
tsvmRMSE <- sqrt(mean(error^2))
tsvmRMSE
#튜닝한 값, 모형의 성능이 크게 개선됨
# svr.rmse와 비교했을 때 tsvmRSME가 더 작으므로 tsvmRMSE가 더 정확하다

plot(data, pch=16)
points(data$x, pred.y, col="red", pch=4, type = "b") # 빨간색은 튜닝 전
points(data$x, tpred.y, col="blue", pch=4, type = "b")
# 파란색은 튜닝 후 # 이게 더 정확하다

# 목표변수가 범주 두개면 AUC 세개면 Accuracy를 통해 모형 평가
# 연속형일땐 MSE RMSE를 통해 평가


