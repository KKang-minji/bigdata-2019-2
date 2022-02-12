library(caret)
data(mdrr)
ls()

nzv <- nearZeroVar(mdrrDescr, saveMetrics = TRUE)
#saveMetrics = TRUE  빈도 비율(freqRatio)와 유일값의 비율(percentUnique)을 얻으 수 있음
#영-분산 또는 영 근처 분산을 가지는 지 알려줌

str(nzv); nzv[nzv$nzv,][1:10,]



dim(mdrrDescr) #행,열

nzv<- nearZeroVar(mdrrDescr) #0근처 분산을 가지고 있는 숫자 위치를 알려줌
nzv
#기본적으로 nearZeroVar() 함수는 문제 되는 변수의 위치 반환

filteredDescr <- mdrrDescr[,-nzv] #-nzv : 0근처의 분산을 가지고 있는 변수를 제거한 데이터 출력
head(filteredDescr)
dim(filteredDescr) #영근처 분산 제거후 297개의 변수 남음



#cor(): 상관계수
#함수를 통해 두변수 간의 선형 관계의 강도를 알 수 있다.
#1) 표준화변수들의 공분산은 상관계수가 된다.
#2) 상관계수는 -1 ≤ ρ ≤ 1 의 범위의 값을 가진다.
#3) 상관계수 ρ가 +1에 가까울수록 강한 양의 선형관계를 가지며,
  #-1에 가까울수록 강한 음의 선형관계를 가진다.
#4) 상관계수 ρ = 0 이면 두 변수간의 선형관계는 없으며,
  #0에 가까울수록 선형관계가 약해진다.
cor(filteredbescr[1:5])


##상관된 예측변수의 식별: 중복 변수 제거
descrCor <- cor(filteredDescr)
##아래 sum()함수: 논리형 자료의 합
(highCorr <- sum(abs(descrCor[upper.tri(descrCor)])> .999))
#abs():절대값 계산
#upper.tri: 행렬을 TRUE나 FALSE로 채운다.
#상관계수가 0.999이상인 경우가 65개임


summary(descrCor[upper.tri(descrCor)])

highlyCorDescr <- findCorrelation(descrCor, cutoff = 0.75)
#findcorrelation()= 다음 절차를 통해 제거해야할 예측변수 제공
#0.75이상 절대 상관계수를 갖는 예측변수 찾음
highlyCorDescr
#제거
filteredDescr <- filteredDescr[ ,-highlyCorDescr]
###확인
library(dplyr)
descrCor2 <- cor(filteredDescr[1:5])
descrCor2[upper.tri(descrCor2)] %>% summary()



highlyCorDescr <- findCorrelation(descrCor, cutoff = 0.75)
filteredDescr<- filteredDescr[, -highlyCorDescr]
descrCor2 <- cor(filteredDescr)
summary(descrCor2[upper.tri(descrCor2)])


set.seed(200)

sample(1:10)        #랜덤하게 뽑지만 seed때문에 내 순서랑 다른 애들 순서랑 같이 랜덤이 돌아감
sample(1:100,50) #50개만 랜덤으로 뽑아냄

sample(seq(along = mdrrClass), 528/2) #seq: 일정한 구조/순차 데이터 생성
length(mdrrClass)/2 #=528/2
inTrain <- sample(seq(along=mdrrClass), length(mdrrClass)/2)
#seq(along=mdrrClass)은 모집단이라 보면됨, mdrr길이 반 되는 것 sample 돌림
#반응햇다(active), 반응되지 않앗다
inTrain

#filteredDesc: nearZeroVar제거된 데이터프레임
training <- filteredDescr[inTrain,] #sample 된 행에 해당하는 값을 training데이터로
test <- filteredDescr[-inTrain,]
trainMDRR <- mdrrClass[inTrain]
testMDRR <- mdrrClass[inTrain]


#확인
dim(training)
dim(test)
length(trainMDRR)
length(testMDRR)


############중심화와 척도화 수행###############
#preProcess(): 각 연산에 필요한 매개 변수 추정
#특정 데이터 셋으로부터 요구하는 것을 추정한 다음 이값을 재계산하지 않고 
#임의의 데이터세트에 변환적용
#실제로 데이터 전처리X

#predict.pre preProcess(): 특정 데이터 집합에 이를 적용하는 데 사용, 
#train()를 호출할때 인터페이스될수도 있음
#데이터셋(훈련용)과 다른 데이터셋(검증용)을 전처리하는데 사용

preproValues <- preProcess(training, method = c("center","scale"))
#method="range": 0과 1사이의 값으로 데이터 변환
trainTransformed <- predict(preproValues,training)

#확인
#sapply 각각의 변수가 가지고 있는 값들을 하나의 함수로 계산을 해주는 기능을 함
sapply(training,mean) %>% round(4) #평균
sapply(trainTransformed,mean) %>% round(4) 

sapply(training,sd) %>% round(4)  #표준편차
sapply(trainTransformed,sd) %>% round(4) 


##########검증자료###############trainTransformed <- predict(preproValues, test)


