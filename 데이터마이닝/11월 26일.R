
######################연관규칙###############################
#install.packages(c("arules", "arulesViz"))
library(arules)
library(arulesViz)

library(dplyr)

#자료:market
data.file <- file.choose()
data.raw <- readLines(data.file)
data.raw %>% head()

#자료 처리
data.use <- strsplit(data.raw, ",") #배열 형태가 달라짐
data.use %>% head()


#transactions
data.trans <- as(data.use, "transactions")
#as(): data를 transactions 타입으로 변형시키라고 강요함
data.trans %>% summary()

#연관규칙 생성 -apriori
data.rules <- apriori(
  data.trans,
  para=list(
    minlen=3,  #최소 품목의 수
    maxlen=20,  #최대 품목의 수
    support=0.01,   #최소 지지도
    confidence=0.5   #최소 신뢰도
  )
)
data.rules %>% summary()

#연관규칙 확인
inspect(data.rules)

library(plotly)
#연관규칙 시각화
plot(data.rules)
plot(data.rules, method = "graph")
plot(data.rules, method = "graph", engine="interactive")
#비프와 밀크를 동시에 사는 사람들이 미네랄 워터를 산다
#화살표방향으로 가는것
#동그라미 크기는 support값



#자료: united kingdom
data.file <- file.choose()
data.uk <- read.csv(data.file)
data.uk %>% dim()
data.uk %>% head()

###중복자료 제거
data.uk.uniq <- data.uk %>% unique()

##분석용 자료로 변환
Customer.Desc <- split(data.uk.uniq$Description, data.uk.uniq$CustomerID)
Customer.Desc %>% head()

####transactions
data.trans <- as(Customer.Desc,"transactions")

data.rules <- apriori(
  data.trans,
  para=list(
    minlen=3, #최소 품목의수
    maxlen=20, # 최대 품목의 수
    support=0.01, #최소 지지도
    confidence=0.005 # 최소 신뢰도
  )
)
data.rules %>% summary()

######연관규칙 확인
inspect(data.rules)

