
#install.packages("plotly")
library(plotly)
library(dplyr)


### CrohnD.csv
df <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/robustbase/CrohnD.csv")
data.1 <- df[-1]
head(data.1)

#막대 그래프 -수직
tb <- table(data.1$sex) %>% as.data.frame()
tb

fig <- plot_ly(tb, x = ~Var1, y = ~Freq, type ="bar", color = ~Var1)
fig
#~은 tb데이터 안에 잇는 변수다 생각하면됨


#막대 그래프 -수평
fig <- plot_ly(tb, x = ~Freq, y =~Var1, type ="bar", color = ~Var1)
fig


#원그래프
fig <- plot_ly(tb, labels = ~Var1,values = ~Freq ,type = "pie")
fig

#히스토그램
fig <- plot_ly(data.1, x = ~BMI, type ="histogram",nbinsx =20)
fig


#분포
p <- ggplot(data.1)+
  geom_density(aes(BMI),fill="skyblue")
ggplotly(p)

#상자그림
#세로
fig <- plot_ly(data.1, x="", y = ~BMI, type = "box")
fig
#가로
fig <- plot_ly(data.1, x = ~BMI, y="", type = "box")
fig

#바이올린플랏
fig <- plot_ly(data.1, y = ~BMI, type = "violin")
fig <- plot_ly(data.1,
               y = ~BMI,
               type = "violin",
               box = list(visible =T))
fig

# 선그림
fig <- plot_ly(data.1, y= ~BMI, type="scatter", mode="line" )
fig


### 남극 얼음의 이산화탄소 햠유량 자료
df <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/DAAG/edcCO2.csv")
data.2 <- df[-1]
head(data.2)
# 선그림
fig <- plot_ly(data.2, x= ~age,y=~co2, type="scatter")
fig <- plot_ly(data.2, x= ~age,y=~co2, type="scatter", mode="lines" )
fig


#선그림-점추가
fig <- plot_ly(data.2, x= ~age, y= ~co2, type='scatter', mode='lines+markers')
fig


#범주형&범주형 - 막대그래프
#누적막대그래프
p <- ggplot(data.1)+
  geom_bar(aes(x = sex, fill =country))
p
fig <- ggplotly(p)
fig

#막대그래프
p <- ggplot(data.1)+
  geom_bar(aes(x = sex, fill =country), position = "dodge")
p
fig <- ggplotly(p)
fig

#끝까지 다채운 것
p <- ggplot(data.1)+
  geom_bar(aes(x = sex, fill =country), position = "fill")
p
fig <- ggplotly(p)
fig


#상자그림
fig <- plot_ly(data.1, x = ~treat, y=~BMI, type = "box", split =~treat)
fig

#violin plot -이동거리 by 대여스테이션
fig <- plot_ly(data.1, 
               x=~treat, y =~BMI,
               type = "violin",
               split = ~treat)
fig

#안에 박스 넣음
fig <- plot_ly(data.1, 
               x=~treat, y =~BMI,
               type = "violin",
               box = list(visible=T),
               split = ~treat)
fig



