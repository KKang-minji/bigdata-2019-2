### 데이터시각화 14주차
# 2020-11-30

library(dplyr)
library(leaflet)

### 자료 소사공인진흥공단
store.file <- file.choose()
data.store <- read.csv(store.file, header = T)
data.store %>% head()

### 자료 추출- 커피전문점
data.cafe <- data.store %>%  subset(상권업종소분류명=="커피전문점/카페/다방")
data.cafe %>% head()

### 점 표시
leaflet(data=data.cafe) %>% addTiles() %>% 
  addCircleMarkers(lng=~경도, lat=~위도)
#addTiles(): 디폴트맵인 오픈 스트리트 맵이 그려짐

### 지도: cartoDB.Position
leaflet(data=data.cafe) %>% addProviderTiles(providers$CartoDB.Positron) %>% 
  addCircleMarkers(lng=~경도, lat=~위도, stroke=FALSE, fillOpacity=0.5)
#addProviderTiles: 다른곳에서 지원하는 지도 이미지 얹을 수 있음


# 줌되는 마커지도 
### 정보표시
leaflet(data=data.cafe) %>% addTiles() %>% 
  addMarkers(~경도,~위도, label=~상호명, 
             popup=~paste(상호명, '<BR>', 도로명주소, sep=''), clusterOptions=markerClusterOptions()) %>% 
  setView(lng=127.381653, lat=36.3523647, zoom = 10)

