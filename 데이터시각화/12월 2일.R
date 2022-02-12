###다각형
library(dplyr)
#install.packages("leaflet")
library(leaflet)

library(sp)
library(rgdal)

#자료 shapefile
shp.file <- file.choose()

shp <- rgdal::readOGR(shp.file)

shp@data

### 좌표 확인: UTM-K(GRS-80) 좌표계에서 WGS84 경위도 좌표계로 변환
from.crs <- "+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs"
to.crs <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
shp <- spTransform(shp, to.crs)

#다각형
leaflet(shp) %>%addPolygons()

#다각형
leaflet(shp) %>% addTiles() %>% addPolygons(color="red", weight=1, opacity=1,
                                            fillOpacity=0.5)

#인구자료: 행정구역 시도성별 인구수
data.file <- file.choose()
data.pop <- read.csv(data.file)

#자료 추가-join
shp@data <- left_join(shp@data, data.pop, by="CTP_KOR_NM")
shp@data

#다각형 색상-시도
pal.fac <- colorFactor("YlOrRd", shp$CTP_KOR_NM)

leaflet(shp)%>% addTiles()%>% 
  addPolygons(fillColor=~pal.fac(CTP_KOR_NM), 
              weight=1, opacity=1, fillOpacity=0.5, color="#444444")


###다각형 색상- 인구수
pal.num <- colorNumeric(rainbow(7), shp$Total)

leaflet(shp)%>% addTiles()%>% 
  addPolygons(fillColor=~pal.num(Total), 
              weight=1, opacity=1, fillOpacity=0.5, color="#444444") %>%
  addLegend("topright", pal=pal.num, values=~Total)
# 범례: addLegend("topright", pal=pal.num, values=~Total)
#pal=pal.num: 무슨기준으로 만들었는지
#values=~Total: shape파일에 잇는 total이라는 것 기준으로



##############오픈데이터##################
#install.packages("xml2")
library(xml2)

#####함수
fn_xml2df <- function(xml, tag.name) {
  ### library
  library(dplyr);library(xml2)
  ### find tag
  xml.item.list <- xml %>% xml_find_all(paste0('//',tag.name))
  xml.item.n <- xml.item.list %>% length()
  #### tag name
  max.index <- xml.item.list %>% xml_length() %>% which.max()
  tag.names <- xml.item.list[max.index] %>% xml_children() %>% xml_name()
  ### return data.frame
  xml.df <- matrix(NA, xml.item.n, length(tag.names)) %>% as.data.frame()
  names(xml.df) <- tag.names
  ### insert values
  for(i in 1:xml.item.n){
    xml.item.child <- xml.item.list[i] %>% xml_children()
    item.names <- xml.item.child %>% xml_name()
    item.values <- xml.item.child %>% xml_text()
    for(j in 1:length(item.names)){
      tag.name <- item.names[j]
      xml.df[[tag.name]][i] <- item.values[j]
    }
  }
  xml.df
}

#자료- 대전 동구 아파트 
xml.file <- file.choose()
xml.raw <- read_xml(xml.file)
xml.raw

xml.df <- fn_xml2df(xml.raw, "item")
xml.df %>% head()
xml.df %>% dim()
xml.df %>% summary()

###자료형 수정
xml.df$거래금액 <- gsub(",","", xml.df$거래금액) %>% as.numeric()
xml.df$층 <- xml.df$층 %>% as.numeric()
xml.df$전용면적 <- xml.df$전용면적 %>% as.numeric()%>% round()
xml.df %>% head()
xml.df %>% summary()


table(xml.df$단지)

library(ggplot2)
#거래금액&전용면적
ggp <- ggplot(xml.df)+ geom_point(aes(x=전용면적, y= 거래금액, color=단지))
ggp

#거래금액&전영먄적&층
ggp <- ggplot(xml.df)+ geom_point(aes(x=전용면적, y= 거래금액, color=단지, size=층),alpha=0.5)
ggp

#plotly
library(plotly)
ggplotly(ggp)




