library(dplyr)
library(plotly)

### Basic contour - 등고선
fig1 <- plot_ly(z=volcano, type='contour')
fig1
#type='contour' : 옆에 표

fig2 <- plot_ly(z=volcano, type='contour', colorscale='Rainbow')
fig2

fig3 <- plot_ly(z=volcano, type='contour', colorscale='Rainbow',
                contours=list(showlabels=T))
fig3
#contours=list(showlabels=T) 등고선에 값 표시

### Baisic Heatmap - 이미지 플롯
fig4 <- plot_ly(z=volcano, type='heatmap')
fig4

### subplot:플롯 된 객체를 단일 객체로 병합
fig <- subplot(fig1,fig2,fig3,fig4, nrows=2, shareX = T, shareY = T)
#shareX = T : x축을 하나로 합침
#shareY = T : Y축을 하나로 합침
fig <- fig %>% layout(showlegend=F, title="Volcano plots") 
#showlegend=F : legend를 안보이게 하겠다.
#layout: x,y축 관리 , 제목을 달수 잇다.
fig


### Basic 3D Surface plot -투시도
fig <- plot_ly(z=volcano)%>% add_surface()
fig


###소상공인시장진흥공단_상가(상권)정보_대전_202009_1.csv
data.file <- file.choose()
data.file

data.raw <-read.csv(data.file, header = T)
data.raw %>% head()


data.raw <- read.csv(data.file, header=T)
data.raw %>% head()
data.raw %>% summary()

#막대그래프
tb <- table(data.raw$상권업종대분류명) %>% as.data.frame()
tb
fig <- plot_ly(tb, x = ~Var1, y = ~Freq, type ="bar", color = ~Var1)
fig


#두개변수 가지고 막대
p <- ggplot(data.raw)+
  geom_bar(aes(x = data.raw$상권업종대분류명, fill =data.raw$상권업종중분류명))
p
fig <- ggplotly(p)
fig


