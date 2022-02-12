#7.10 이미지 플롯
dim(volcano)
head(volcano)
image(volcano)
image(volcano, xaxs = "r", yaxs="r")
image(volcano, xaxs = "r", yaxs="r", zlim = c(150,200))
#150~200사이만 그림으로 표시


image(volcano, zlim = c(150,200), xaxs="r", yaxs="r",xlab = "동서쪽", ylab="남북쪽")
image(volcano, zlim = c(0,150),add=T, col=cm.colors(15))
title(main = "이미지")


#7.11 등고선과 이미지
filled.contour(volcano)
filled.contour(volcano,color = terrain.colors)



x <- 10*1: nrow(volcano)
y <- 10*1:ncol(volcano)               
filled.contour(x, y, volcano, color = terrain.colors, 
               plot.title = title(main="등고선과 이미지", xlab="북쪽길이", ylab="서쪽길이"),
               plot.axes={axis(1,seq(100,800,by=50)); #;넣어야지 실행됨
                 axis(2,seq(100,600,by=50))},
               key.title =title(main = "높이(m)"),
               key.axes = axis(4, seq(90,200, by =10)))
               
                              
               