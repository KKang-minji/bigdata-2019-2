#install.packages("caret")
library(caret)
library(dplyr)
data(mdrr)
ls()

table(mdrrDescr$nR11)
var(mdrrDescr$nR11)    #분산

nzv<- nearZeroVar(mdrrDescr, saveMetrics = TRUE) #분산이 0에 가까운 것만 뽑는 함수
class(nzv) #어떠한 형태로 저장되어있는지
str(nzv)  #nzv에 대한 설명, 그안에 들어있는 변수에 대해 요약

head(nzv) #맨위에 있는 6개만 출력

#help- 도움말
?nearZeroVar

dim(mdrrDescr) #행,열

nzv<- nearZeroVar(mdrrDescr) #0근처 분산을 가지고 있는 숫자 위치를 알려줌
nzv
filteredbescr <- mdrrDescr[,-nzv] #0근처의 분산을 가지고 있는 숫자를 제거한 데이터 출력
head(filteredbescr)
dim(filteredbescr)

