#선형회귀
data.file <- "https://vincentarelbundock.github.io/Rdatasets/csv/Ecdat/Icecream.csv"
data.raw <- read.csv(data.file, header = T)
head(data.raw)
dim(data.raw)


data.use <- data.raw[-1]
head(data.use)
dim(data.use)

# model 2
res <- lm(cons~temp+income, data = data.use)
res.summ <- summary(res)   #Adjusted R-squared:   0.68 (수정계수)
res.summ

###실제값
y_i <- data.use$cons

str(res)
names(res.summ)
names(res)

y_i_hat <- res$fitted.values
y_i_hat

#residuals (장차)
#오차
resid <- y_i - y_i_hat 
resid <- res$residuals
#둘이 동일한 값

#평균절대오차 (알아서 단위통일 시켜짐)
abs(resid)   #절대값 씌움 
sum(abs(resid))   #절대값 씌운거 더해줌
MAE <- sum(abs(resid))/30 #평균 절대 오차 
#평균제곱오차
resid^2
sum(resid^2)
MSE <- sum(resid^2)/30

#루트씌운 평균제곱오차 (단위 통일 시키기 위해)
RMSE <- sqrt(MSE)
RMSE

#정분류율은 큰 값이 나올수록 가장 정확한 것
#위에 붙으면 붙을수록 좋은모형
#ROC곡선에서 곡선 아래에 있는 면적이 넓을수록 좋은 것 = AUC 값이 큰 것
