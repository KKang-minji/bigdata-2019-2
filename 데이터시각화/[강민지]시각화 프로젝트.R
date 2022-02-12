
library(dplyr)
library(plotly)
library(ggmap)

#대전광역시 주택현황
#에 있는 주소지를 이어붙인 후 대전주택 주소지 csv파일 만듦
df <- file.choose()
df
dt <- read.csv(df,header = T)
dt %>% head()
dt %>% tail()
summary(dt)
str(dt)
View(dt)

주소지<- paste(dt$"관할.자치구", dt$"상세주소")
주소지

data <- cbind(dt,주소지)
View(data)
write.csv(data,"대전주택 주소지.csv",row.names = TRUE)

##########################################################
######대전주택 주소지.csv
#에 있는 주소지를 이용하여 경도 위도 만듦
data.file <- file.choose()  
data <- read.csv(data.file)
data
library(dplyr)
library(ggmap)
register_google(key="AIzaSyD1HJZt6ywR4ugFTtBgosyJ8eiKEO2Hf8g ")

data

data$주소지 <- enc2utf8(data$주소지)
data$주소지 <- as.character(data$주소지)
adata_1 <- mutate_geocode(data,주소지, source="google")
write.csv(adata_1,"address_data.csv",row.names = TRUE)

View(adata_1)


#(1)
#자료 : address_data.csv
data.file.1 <- file.choose()
data.add <- read.csv(data.file.1, header = T)
data.add %>% head()
View(data.add)

#대전시 구별 주택 비교
tb <- table(data.add$관할.자치구) %>% as.data.frame()
tb

fig <- plot_ly(tb, x = ~Freq, y = ~Var1, type ="bar", color = ~Var1)
fig
#서구가 가장 주택 수가 많다.

#자료추출
data.a1 <- data.add %>% subset(공동주택.구분 =="아파트")
data.a1 %>% head()
data.a1 %>% str()

#
fig <- plot_ly(data.a1, x = ~관할.자치구, y=~세대수, type = "box", split =~관할.자치구)
fig
title(main = "세대수 비교")
#세대수를 비교해보니 서구가 세대수가 크고 작은 아파트가 폭넓게 많고
#서구가 평균적으로 세대수가 많은 아파트가 많으므로 안정적인 주택이 많다.



#자료추출
data.a2 <- data.a1 %>% subset(관할.자치구=="대전광역시 서구")
data.a2 %>% head()
data.a2 %>% str()
View(data.a1)

#
library(leaflet)
leaflet(data=data.a2) %>% addTiles() %>% 
  addMarkers(~lon, ~lat, label=~공동주택명, 
             popup=~paste(주소지, '<BR>', 주소지, sep=''), clusterOptions=markerClusterOptions()) %>% 
  setView(lng=127.381653, lat=36.3523647, zoom = 10)








