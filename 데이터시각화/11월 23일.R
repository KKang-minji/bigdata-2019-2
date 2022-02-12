###### 다각형(polygon)
#install.packages("raster")
library(raster)
#시도: level=1, 시군구: level=2
korea <- getData('GADM', country='kor', level=1)

#자료확인
korea@data

plot(korea)

ggplot() + geom_polygon(data=korea, aes(x=long, y=lat, group=group),fill='white',
                        color='black')


airMap <- get_map(fn_lon_lat_box(128, 36, 300))
ggmap(airMap) + geom_polygon(data= korea, aes(x=long, y=lat, group=group),fill='white',
                             color='black', alpha=0.5)


library(sp)
#install.packages("rgdal")
library(rgdal)

shp.file <- file.choose()

shp <- rgdal::readOGR(shp.file)

shp@data

ggplot()+geom_polygon(data = shp, aes(x=long, y=lat, group=group), fill="white",
                                      color="black")


### 좌표 확인: UTM-K(GRS-80) 좌표계에서 WGS84 경위도 좌표계로 변환
from.crs <- "+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs"
to.crs <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
shp <- spTransform(shp, to.crs)

plot(shp)

#다각형-ggplot
ggplot()+geom_polygon(data = shp, aes(x=long, y=lat, group=group), fill="white",
                      color="black")

#ggmap
ggmap(airMap)+geom_polygon(data = shp, aes(x=long, y=lat, group=group), fill="white",
                      color="black", alpha=0.5)
#투명도:alpha=0.5


#자료 : 행정구역_시도_성별_인구수.csv
shp.df <- fortify(shp)
shp.df %>% head()

shp@data

shp@data$id <- rownames(shp@data)
shp.df.use <- left_join(shp.df, shp@data, by="id")
shp.df.use <- shp.df.use[order(shp.df.use$id, shp.df.use$order),]
shp.df.use %>% head(30)

###다각형 색상-시도
ggplot()+geom_polygon(data=shp.df.use, 
                      aes(x=long, y=lat, group=group, fill=CTP_KOR_NM), color="black")


