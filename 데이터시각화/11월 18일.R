#install.packages("ggmap")
library(ggmap)


#####등고선과 밀도
#등고선
ggmap(krMap) + stat_density2d(data=data.use, aes(x=경도, y= 위도))

### 밀도 + 색상(1)
ggmap(krMap) +stat_density2d(data=data.use, aes(x=경도, y=위도), 
                             geom="polygon", alpha= 0.4)

### 밀도 + 색상(2)
p <- ggmap(krMap) +stat_density2d(data=data.use, 
  aes(x=경도, y=위도,fill=..level..), geom="polygon", alpha= 0.4)+
  scale_fill_gradient(low="yellow", high="red")
p

### 밀도 + 색상 +등고선
p + stat_density2d(data = data.use, aes(x= 경도, y=위도))

##### 선
#자료: 차량 주행궤적 데이터.csv
data.file <- file.choose()
data.line <-read.csv(data.file, header = T)
data.line %>% head()
data.line %>% summary()

data.line$차량.ID <- factor(data.line$차량.ID)

###선그림 -ggplot()
ggplot() +geom_line(data=data.line, aes(x=경도, y= 위도, colour=차량.ID))


###지도 다운로드
krMap <- get_map(fn_lon_lat_box(127.30,36.42,6))

###선 표시
ggmap(krMap) +geom_line(data=data.line, aes(x=경도, y= 위도, colour=차량.ID),
                        size=2)

ggmap(krMap) +geom_path(data=data.line, aes(x=경도, y= 위도, colour=차량.ID),
                        size=2)
#geom_line와 geom_path 성질 똑같음


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

####대한민국자료추출
airport$Country %>% table()
airport.kr <- subset(airport, Country == 'South Korea')
route.kr <- subset(route, Departure %in% airport.kr$IATA & Arrival %in% airport.kr$IATA )
route.kr
#airport %>% subset()

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

library(ggmap)
library(dplyr)
library(ggplot2)
#####지도다운로드
airMap <- get_map(fn_lon_lat_box(128,36,300))
map <- ggmap(airMap)

###공항
map <- map + geom_point(data=airport.kr, aes(x=longitude, y=lantitude))

####항공노선
map + geom_path(data = air.line, aes(x=longitude, y=lantitude, group=group))

###자료생성
air.line.2 <- data.frame(from[6:8], to[6:8])
air.line.2 %>% head()
#### 항공노선 추가
map + geom_curve(data=air.line.2, aes(x=longitude, y=lantitude, xend=longitude.1,
                                      yend=lantitude.1), curvature = 0.2)+coord_cartesian()



###### 다각형(polygon)
#install.packages("raster")
library(raster)
#시도: level=1, 시군구: level=2
korea <- getData('GADM', country='kor', level=1)

korea@data

plot(korea)

ggplot() + geom_polygon(data=korea, aes(x=long, y=lat, group=group),fill='white',
                       color='black')

ggmap(airMap) + geom_polygon(data= korea, aes(x=long, y=lat, group=group),fill='white',
                             color='black', alpha=0.5)


