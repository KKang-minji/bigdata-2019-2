###########대화형 지도
##plotly
library(plotly)
library(dplyr)

plot_ly(type = "scattermapbox")%>%
  layout(mapbox=list(style="open-street-map",
                     center=list(lat=36.36, lon=127.38),
                     zoom=10))


#자료 : 소상공인 시장 진흥공단
store.file <- file.choose()
data.store <- read.csv(store.file, header = T)
data.store %>% head()

#자료추출
data.cafe <- data.store %>% subset(상권업종소분류명=="커피전문점/카페/다방")
data.cafe %>% head()

#점표시
fig <- plot_ly(data.cafe, lat=~위도, lon=~경도, split=~시군구명, type = "scattermapbox",
               mode="markers", hovertext=~상호명)

fig <- fig%>%layout(mapbox=list(style="open-street-map",
                     center=list(lat=36.36, lon=127.38),
                     zoom=10))
fig


fig <- plot_ly(data.cafe, lat=~위도, lon=~경도, type="densitymapbox", 
               coloraxis="coloraxis", radius=10)
#radius=10: 크기,coloraxis="coloraxis":색
fig<- fig%>% layout(mapbox=list(style="open-street-map",
                                center=list(lat=36.36, lon=127.38),
                                zoom=10),coloraxis=list(colorscale="Viridis"))
#coloraxis=list(colorscale="Viridis"): 색
fig


###선 
###자료: 차량 주행궤적
data.file <- file.choose()
data.line <- read.csv(data.file,header=T)
data.line$차량.ID <- factor(data.line$차량.ID)
head(data.line)

fig <- plot_ly(data.line, lat=~위도, lon=~경도, type="scattermapbox",
               mode="markers+lines")
fig <- fig %>% layout(mapbox=list(style="carto-positron",
                                center=list(lat=36.42, lon=127.30),
                                zoom=10))
fig


### 공항정보
url <- "https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat"
airport <- read.csv(url, header=F, stringsAsFactor=F)
airport <- airport[airport$V5!='', c('V3', 'V4', 'V5','V7','V8')]
names(airport) <- c("City", "Country", "IATA", "lantitude","longitude")
airport %>% head()

### 항공노선
url <- "https://raw.githubusercontent.com/jpatokal/openflights/master/data/routes.dat"
route <- read.csv(url, header=F, stringsAsFactors=F)
route <- route[c('V1', 'V3', 'V5')]
names(route) <- c("Airline", "Departure", "Arrival")
route %>% head()

### 대한민국 자료 추출
airport$Country %>% table()

airport%>% subset()
airport.kr <- subset(airport, Country == 'South Korea')
airport.kr
route.kr <- subset(route, Departure %in% airport.kr$IATA & Arrival %in% airport.kr$IATA)
# %in%: 왼쪽에 잇는게 오른쪽에 포함되어잇으면 뽑아짐
route.kr

####항공노선 경도와 위도 생성
#이륙공항
from <- left_join(route.kr, airport.kr,  by=c("Departure"="IATA"))
from$group <- rownames(route.kr)
from %>% head()



###착륙공항
to <- left_join(route.kr, airport.kr, by=c("Arrival"="IATA"))
to$group <- rownames(route.kr)

####이륙 + 착륙
air.line <- rbind(from[6:8], to[6:8])
air.line %>% head()

airMap <- get_map(fn_lon_lat_box(128, 36, 300))
map <- ggmap(airMap)


#공항
map + geom_point(data= airport.kr, aes(x=longitude, y= lantitude))

###항공노선
map + geom_path(data= air.line, aes(x=longitude, y= lantitude, group=group))

###자료 생성
air.line.2 <- data.frame(from[6:8], to[6:8])
air.line.2%>% head()


#공항
fig <- plot_ly(airport.kr, lat=~lantitude, lon=~longitude,
               type="scattermapbox", mode="markers", split=~City)

#항공노선
fig <- fig %>% add_trace(data=air.line, lat=~lantitude, lon=~longitude,
                         split=~group, type="scattermapbox", mode="lines")
 
#지도 설정
fig <- fig %>% layout(mapbox=list(style="carto-positron",
                                  center=list(lat=36, lon=128), zoom=5))
     
  
fig
hide_legend(fig)

#install.packages("sf")
library(sf)

###shape file
shp.file <- file.choose()
shp.df <- sf::st_read(shp.file, quiet=TRUE, options="ENCODING=CP949")
shp.df %>% head()
shp.df %>% class()

###인구자료: 행정구역 시도 성별 인구수
data.file <- file.choose()
data.pop <- read.csv(data.file)
data.pop

###join-자료 추가
shp.df.use <- left_join(shp.df, data.pop, by="CTP_KOR_NM")
shp.df.use
#인구정보 앞에 붙음

plot_ly(shp.df.use, split=~CTP_KOR_NM)

plot_ly(shp.df.use, split=~CTP_KOR_NM, color=~Total)






