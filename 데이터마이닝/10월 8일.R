data(iris)
head(iris)
a <- subset(iris, Species=="setosa"|Species=="versicolor")
#subset(데이터, 조건)     #species가 이 두개인 데이터만 가지고 와라
dim(a)

a$Species <- factor(a$Species) #factor세개인걸 두개로 바꿈
str(a)

b <- glm(Species~Sepal.Length, data=a, family=binomial)
#(목적변수~입력변수+입력변수+입력변수, 이데이터는 a라는 곳에 있다., 로지스틱회귀분석)
b

summary(b)
# Sepal.Length  3.28e-07가 0.05보다 작다. 그래서 회귀분석에 영향을 줌


coef(b)

beta <- coef(b)[2]
#두번째에 있는 Sepal.Length만 옴 

exp(beta)
# Sepal.Length가 1이 증가하면 성공의 가능성이 (오즈가) 170씩 증가한다.

#점추정
#구간 계산
confint(b, parm= "Sepal.Length")

exp(confint(b, parm= "Sepal.Length"))
#신뢰구간


#사후 확률
fitted(b)
#값이 높을 수록 성공에 대한 확률

new.data <- a[c(1,50,51,100),]

pred <- predict(b, new.data, type="response")
#새로운 자료에 대한 예측 할 수 있음
#predict(기존 자료, 새로운 자료)
#높을 수록 성공
ifelse(pred<0.5, "setosa", "versicolor")


cdplot(Species~Sepal.Length, data=a)

plot(a$Sepal.Length, a$Species, xlab ="Sepal.Length")

x= seq(min(a$Sepal.Length), max(a$Sepal.Length),0.1)
lines(x, 1+(1/(1+(1/exp(-27.831+5.140*x)))), type="l",col="red")
#-27.831와 5.140는 b의 Coefficients에 있는 회귀식



#예측변수 여러개인 다중 로지스틱회귀
data(mtcars)
mtcars$mpg
attach(mtcars)
#detach(mtcars)#없앨때
mpg
str(mtcars)
glm.vs <- glm(vs~mpg+am, data = mtcars, family=binomial)
glm.vs
summary(glm.vs)
#mpg 는 0.00697 ** -> 유의함
#am는 0.06009 -> 유의 하지 않다는걸 알 수있음

exp(0.6809)

step.vs <- step(glm.vs)
summary(step.vs)
#step은 AIC: 26.646값을 기준으로함


#backward는 필요없는 변수를 하나하나 제거하면서 찾음
#forward는 반대로 변수를 추가해 나가면서 찾는것


ls(glm.vs)
glm.vs$coefficients
coef(glm.vs)


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


