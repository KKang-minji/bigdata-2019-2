library(dplyr)
library(plotly)
library(ggmap)
data.use <- read.csv("http://youngho.iwinv.net/data/local_trip_2019_2.csv", header=T,
                     fileEncoding="UTF-8", stringsAsFactors=T)
head(data.use)

#1)
tb <- table(data.use$age) %>% as.data.frame()
tb
fig <- plot_ly(tb, x = ~Var1, y = ~Freq, type ="bar", color = ~Var1)
fig


#2)
p <- ggplot(data.use)+
  geom_bar(aes(x = age, fill =sex), position = "fill")
p
fig <- ggplotly(p)
fig




#3)
fig <- plot_ly(data.use, x = ~age, y=~expense_tour, type = "box", split =~age)
fig

### 대전광역시 관내 초·중·고의 학교 위치
data.school <- read.csv("http://youngho.iwinv.net/data/daejeon_school.csv", header=T,
                        fileEncoding="UTF-8")
data.school %>% head()

#4) 구분
# 지도 다운로드
krMap <- get_map(boxLocation)
plot_ly(type = "scattermapbox")%>%
  layout(mapbox=list(style="open-street-map",
                     center=list(lat=36.36, lon=127.38),
                     zoom=10))
#시군구별 점 색깔다름
fig <- plot_ly(data.school, lat=~위도, lon=~경도, split=~구분, type = "scattermapbox",
               mode="markers", hovertext=~학교명)

fig <- fig%>%layout(mapbox=list(style="open-street-map",
                                center=list(lat=36.36, lon=127.38),
                                zoom=10))
fig




#5) 
### 대전광역시 행정동 자료
data.map <- read.csv("http://youngho.iwinv.net/data/daejeon_level3.csv", header=T,
                     fileEncoding="UTF-8")
data.map %>% head()
### 대전광역시 병원의 수
data.hospital <- read.table("http://youngho.iwinv.net/data/daejeon_hospital.txt", header=T,
                            fileEncoding="UTF-8", sep="\t")
data.hospital %>% head()

#lon latgroup으ㅗㄹ 다각형
#두개자료 합쳐서 
#자료 추가-join
map.hospital <- left_join(data.map, data.hospital, by="dong")
map.hospital


ggplot()+geom_polygon(data=map.hospital, 
                      aes(x=long, y=lat, group=group, fill=의료_병원수), color="black")+ scale_fill_gradient(low="yellow",high="red")










