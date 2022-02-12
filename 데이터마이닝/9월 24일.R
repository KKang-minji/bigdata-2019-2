#install.packages("earth")
library(earth)
data("etitanic")
summary(etitanic)
str(etitanic)

mat <- model.matrix(survived~., data = etitanic)
mat #가변수 만듦

#dummyVars()함수 이용
dummy.1 <- dummyVars(survived ~ ., data = etitanic)
head(model.matrix(survived~. , data = etitanic)) #범주수 - 1개 만큼 가변수 만들어짐

df <- predict(dummy.1, newdata = etitanic)
head(df) #범주수만큼 가변수 만들어짐
#선형종속적으로 생각하면 이거 그냥 쓰면 안됨. 제거된 걸로 사용해야함

#ex. 7
#install.packages("RANN")
library(RANN)

data(airquality)
summary(airquality)

imp.1 <- preProcess(airquality, method = c("knnImpute"))
imp.2 <- predict(imp.1, airquality)

summary(imp.2)



#2.3 모형평가
#선형회귀
data.file <- "https://vincentarelbundock.github.io/Rdatasets/csv/Ecdat/Icecream.csv"
data.raw <- read.csv(data.file, header = T)
head(data.raw)
dim(data.raw)


data.use <- data.raw[-1]
head(data.use)

#산점도 행렬
plot(data.use)
# model 1
res <- lm(cons~temp, data = data.use)   #회귀 정보(절편, 기울기)
res.summ <- summary(res)    #Adjusted R-squared:  0.5874 (수정계수)
res.summ

res <- lm(cons~income, data = data.use)
res.summ <- summary(res)
res.summ

# model 2
res <- lm(cons~temp+income, data = data.use)
res.summ <- summary(res)   #Adjusted R-squared:   0.68 (수정계수)
res.summ

#model 3
res <- lm(cons~., data = data.use) #~뒤에 쓴 . 은 나머지 다 라는 뜻
res.summ <- summary(res)     #Adjusted R-squared:  0.6866 
res.summ

#수정결정계수를 기준으로 했을때 큰게 좋은거-> 여러개변수를 할수록 더큼

#AIC
res.step <- step(res)
res.step.summ <- summary(res.step)
res.step.summ

#AIC기준으로 하니까 model 2로 됨. 알아서 제거해서 좋은거로 뽑아줌

