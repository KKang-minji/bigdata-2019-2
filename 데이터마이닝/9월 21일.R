#############연습문제: 우리동네 대기 정보 한남대학교 
library(caret)
library(dplyr)


data.file <- file.choose()
data.file
data.raw <- read.csv(data.file, header=T)
data.raw %>% dim()
data.raw %>% head()
data.raw %>% tail()



data.use <- data.raw[-1]
data.use %>% head()


##영근처 -분산을 가지는 변수 제거
nearZeroVar(data.use, saveMetrics = TRUE)
nzv <- nearZeroVar(data.use)   #몇번째에 있는지 알려줌
data.nzv <- data.use[-nzv]  #제거
#확인
data.nzv %>% head()
sapply(data.nzv, var) %>% round(4)
#각각의 변수가 가지고 있는 값들을 하나의 함수로 계산을 해주는 기능을 함


##상관된 예측변수의 식별: 중복 변수 제거##

data.nzv.cor <- cor(data.nzv)    #상관계수가 어떤게 높은지 보려고 만든 표
highlycor <- findCorrelation(data.nzv.cor, cutoff = 0.7)  #0.7보다 큰 부분을 알고싶은것
#0.7 이상인 부분을 찾은결과 3번째 변수가 상관관계가 높은 변수다!
data.filtered <- data.nzv[,-highlycor]   #데이터 원본인 data.nzv 넣음 #세번째 변수만 빼주면 되므로 -
highlycor #3번째 변수

#확인
data.filtered %>% head()

##중심화와 척도화 수행##
preproValues <- preProcess(data.filtered, method = c("center","scale")) #preprocess로 표준화랑 정규화 
data.scale <- predict(preproValues,data.filtered)
#확인- 평균
sapply(data.scale, mean) %>% round(4)
sapply(data.scale,sd) %>% round(4)
