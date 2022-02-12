### 데이터시각화 12주차
# 2020-11-16

library(ggmap)
library(dplyr) 

# 지도 가져오기
#                      x1       y1     x2      y2
boxLocation <- c(127.273, 36.257, 127.497, 36.453)
krMap <- get_map(boxLocation)

## 지도 표시
ggmap(krMap)

## 경도와 위도 상자 좌표 계산 함수
fn_lon_lat_box <- function(lon, lat, dist = 1) {
  h <- 0.0035*3.5*dist
  w <- 0.0035*4*dist
  # 경도와 위도로 표시할 사각형의 좌하, 우상의 좌표
  c(lon-w, lat-h, lon+w, lat+h)
}

# 경도와 위도로 표시할 중심좌표
boxLocation <- fn_lon_lat_box(127.385,36.355,8)
## 한남대학교
# boxLocation <- fn_lon_lat_box(127.421552, 36.354191, 0.8)

# 지도 다운로드
krMap <- get_map(boxLocation)

# 지도표시
ggmap(krMap)


### 소상공인
data.file <- choose.files()
data.file

View(data.raw)

data.raw <- read.csv(data.file, header= T)
data.raw %>%  head()
data.raw %>% summary()

### 점표시
data.use <- data.raw %>%  subset(상권업종소분류명=="인터넷PC방")
data.use %>% head()
data.use %>% dim()

ggplot()+ geom_point(data=data.use, aes(x=경도,y=위도, colour=시군구명))

ggmap(krMap)+ geom_point(data=data.use, aes(x=경도,y=위도, colour=시군구명))


