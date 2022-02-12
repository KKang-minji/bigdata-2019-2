#install.packages("kknn")
library(kknn)

data(iris)
m <- dim(iris)[1]
val <- sample(1:m,size = round(m/3), replace = FALSE,
              prob = rep(1/m,m))
iris.learn <- iris[-val,]
iris.valid <- iris[val,]
dim(iris.learn)
dim(iris.valid)

iris.kknn <- kknn(Species~., iris.learn, iris.valid, distance = 1,
                  kernel = "triangular")
summary(iris.kknn)

fit <- fitted(iris.kknn)
cm <- table(iris.valid$Species, fit)

###정확도는
sum(diag(cm))/sum(cm)

caret::confusionMatrix(reference=iris.valid$Species, data=fit)
caret::confusionMatrix(cm)

fit

#예측결과 그림
fit.int<- as.integer(fit)
pairs(iris.valid[1:4],pch=fit.int, col=fit.int)
plot(iris.valid[1:4])

#######EX.4
full <- data.frame(name=c("McGwire,Mark", "Bonds,Barry",
                          "Helton,Todd", "Walker,Larry",
                          "Pujols,Albert", "Pedroia,Dustin"),
                   lag1=c(100,90,75,89,95,70),
                   lag2=c(120,80,95,79,92,90),
                   Runs=c(65,120,105,99,65,100))
full



train <- full[full$name!="Bonds,Barry",]
test <- full[full$name=="Bonds,Barry",]
k <- kknn(Runs~lag1+lag2, train = train,test=test, k=2,distance = 1)
fit <- fitted(k)
fit

mode(k)
names(k)

k$CL

k$C

k$W
99*0.75+65*0.25



