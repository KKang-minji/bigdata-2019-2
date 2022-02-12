##7.2 심볼(symbol) 플롯
library(dplyr)
?symbols
?par


#round: 반올림, rnorm: 정규분포, runif: 난수
x <- round(rnorm(30),2)
#랜덤으로 정규분포한 30개를 소수점 두번째자리까지 반올림
y <- round(rnorm(30),2)
z1 <- abs(round(rnorm(30),2)) #abs=절대값. 그래서 양수만 존재
z2 <- abs(round(rnorm(30),2))
z3 <- round(runif(30),2)
#난수 30개뽑아서 소수점 두번째자리까지 반올림
z4 <- round(runif(30),2)
z5 <- round(runif(30),2)

symbols(x,y,circles = abs(x), inches = 0.2, bg=1:30) #bg: 색깔
title(main = "symbols are circles")

symbols(x,y, squares = abs(x),inches = 0.2, bg=1:30) #bg: 색깔

title(main = "symbols are squares")

symbols(x,y,rectangles = cbind(abs(x), abs(y)),inches = 0.2, bg=1:30)   
#가로와 높이
title(main = "symbols are rectangles")


symbols(x,y,stars =  cbind(abs(x), abs(y),z1,z2,z3),inches = 0.2, bg=1:30)   
#세개이상의 값이 있어야 면적을 표현할 수 있음
title(main = "symbols are stars")

symbols(x,y,thermometers = cbind(abs(x), abs(y),z4), inches = 0.2, bg=1:30)   
#온도: 가로와 높이 중앙선(세개의 값 필요)
title(main = "symbols are thermometers")

symbols(x,y,boxplots = cbind(abs(x), abs(y),z3,z4,z5), inches = 0.2, bg=1:30)   
#5개의 값 아래수염위수염 사각형, 중앙
title(main = "symbols are boxplots")

layout(1)

m <- matrix(1:6, 3, 2, T)
m
layout(m) #그래프 재배치
#행렬(matrix,mat)로 분할하려는 그래프 영역의 순서와 열의 폭과 행의 높이, 
#영역 나누기/합치기를 자유롭게 조절


##7.5 모자이크 플롯
ax <- aperm(UCBAdmissions, c(2,1,3)) #첫번째와 두번째 차원 바꿈
#aperm: 배열의 차원의 순서를 교환하여 배열의 구조를 변경
ax.sex <- margin.table(ax, c(1,2)) 
#margin.table: 한계 분포
#행합계:1, 열합계:2
ax.sex

mosaicplot(ax.sex, color = T)
mosaicplot(ax.sex, color = 2:3)
mosaicplot(~Gender + Admit, data = UCBAdmissions, color=2:3)
#~Gender + Admit 변수는 UCBAdmissions 데이터 안에 있다.

###크론병 자료
df <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/robustbase/CrohnD.csv")
head(df)
tb <- table(df$sex, df$country)
mosaicplot(tb, color=2:3, main="Crohn's disease")

mosaicplot(~sex + country, data = df, color=2:3, main = "mosaicplot(sex&country)")


## 7.6 조건부 플롯
head(quakes)
plot(lat~long, data = quakes)
coplot(lat~long | depth, data= quakes)
#경도 위도에 대한산점도를 depth별로 작성
coplot(lat~long | depth, data= quakes, overlap = 0) 
#각각의 구간별로 나눠짐 #중복 없앰
coplot(lat~long | depth, data= quakes, overlap = 0,number = 12) 
#구간을 열두개가지로 나눔
?coplot

#분위수
quantile(quakes$depth, seq(0,1,0.1))
quakes$depth


## 7.8 투시도
x <- seq(-20,20, length=30)  #전체길이가 30이 되도록 동일한 간격으로 생성
y <- x
f <- function(x,y){
  r <- sqrt(x^2+y^2)
  10*sin(r)/r
}
#outer(1:3,5:7, paste)
z <- outer(x,y,f) #outer: 들어가있는 함수에 대해 연산

persp(x,y,z) 
persp(x,y,z,theta = 30, phi=30)#theta: 방위값, phi: 여위도
persp(x,y,z,theta = 30, phi=30, col = "lightgreen")
persp(x,y,z,theta = 30, phi=30, col = "lightgreen", shade = 0.75) #그림자
persp(x,y,z,theta = 30, phi=30, col = "lightgreen", shade = 0.75, ltheta = 120) 
#ltheta: 빛의 방향
persp(x,y,z,theta = 30, phi=30, col = "lightgreen", shade = 0.75, ltheta = 120, 
      ticktype = "detailed") #축길이



data(volcano)
persp(volcano, theta = 130, phi=30, col = "lightgreen", shade = 0.75, ltheta = 120)
#메트릭스 모양으로 되어있기에 바로 실행 가능
#theta = 130 방위를 돌려서 보여줄 수 있음

## 7.9 등고선
contour(volcano)

x <- 10*1:nrow(volcano) #행
y <- 10*1:ncol(volcano) #열
tcol <- terrain.colors(12)

contour(x, y, volcano, col=tcol[2], lty = "solid")  #lty:선 타입
title("등고선")

#grid()
abline(h=200*0:4, v = 200*0:4, col = "lightgray", lty=2, lwd= 0.1)
#h:가로선 y좌표,  v:세로선 x좌표


