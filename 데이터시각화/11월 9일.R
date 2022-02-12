
library(plotly)
library(dplyr)


### CrohnD.csv
df <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/robustbase/CrohnD.csv")
data.1 <- df[-1]
head(data.1)

#막대 그래프 -수직
tb <- table(data.1$sex) %>% as.data.frame()
tb

#산점도
fig <- plot_ly(data.1, 
               x=~weight, y =~BMI,
               type= "scatter", mode="markers")
fig
               
#산점도- 회귀선 추가
fit.value <- lm(BMI~weight, data=data.1)%>%fitted.values 
#lm: 회귀 분석, 분산의 단일 계층 분석 및 공분산 분석 수행
fig <- fig %>% add_trace(x=~weight, y = fit.value, mode="lines")%>%
  layout(showlegend=F)
#add_trace: 플롯 시각화에 트레이스 추가
fig

#버블차트-산점도+점의 크기
fig <- plot_ly(data.1, x =~height, y=~weight, type = 'scatter', mode='markers',
               marker=list(size=~BMI, color='skyblue',opactly=0.5))
fig


#버블차트 - 산점도+점의 크기+점의 색깔
fig <- plot_ly(data.1, x =~height, y=~weight, type = 'scatter', mode='markers',
               split=~sex, marker=list(size=~BMI,opactly=0.5))
#split 분리
fig

head(data.1)

###선 그림(line plot)- 연속형 변수 추가
head(airquality)

fig <- plot_ly(airquality, y = ~Ozone, type = 'scatter', mode ='lines',
               name = "Ozone")
fig <- fig %>% add_trace(airquality, y = ~Temp, type = 'scatter', mode ='lines', 
                        name = "Temp")
fig <- fig %>% add_trace(airquality, y = ~Wind, type = 'scatter', mode ='lines', 
                        name = "Wind")
fig
#add_trace: 기존에 있던 그림에 추가하겠다.

###선 그림(line plot)- 데이터 재구성
#install.packages("reshape2")
library(reshape2)

################### melt 사용 방법 중요 ########################
air.use <- airquality %>% select(Ozone, Temp, Wind) %>% melt()
air.use %>% head()
air.use %>% summary()
#원래 Ozone, Temp 데이터엿는데 데이터 변경됨
#오존과 템프 분리 , melt로 녹임

#add_trace를 쓰지않고 여러개 그림을 알아서 그림
fig <- plot_ly(air.use, y = ~value, type = 'scatter', mode='lines', split = ~variable)
fig


