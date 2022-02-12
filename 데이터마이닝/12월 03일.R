
###계층적 군집 수행
###주들 간의 유클리드 거리
d<- dist(USArrests, method = "euclidean")
d
fit <- hclust(d, method = 'average')

######군집결과의 시각화: 덴드로그램
plot(fit, hang=-1)

groups <- cutree(fit, k=6)
groups

#그룹 수
plot(fit, hang=-1)
rect.hclust(fit, k=6)

#높이 수
plot(fit, hang=-1)
rect.hclust(fit, h=6)

#그룹 4개, 색 여러개
plot(fit, hang=-1)
rect.hclust(fit, k=4, border = rainbow(4))

####예제3
#계층적 군집 수행:hclust() 함수이용
fit <- hclust(d, method = "ave")
clus6 = cutree(fit, 6)# 6개의 군집


##########################################################################
##hclust객체 fit를 phylo객체로 전환:as.phyo{ape}함수이용
#install.packages("ape")
library(ape)
#팬모양
plot(as.phylo(fit), type="fan")

#6개군집별 무지개색
#type="fan"
colors= rainbow(6)
plot(as.phylo(fit), type="fan", tip.color=colors[clus6], lavel.offset=1,
     cex=0.7)

#type="cladogram"
plot(as.phylo(fit), type="cladogram", tip.color=colors[clus6], lavel.offset=1,
     cex=0.7)

#type="unrooted"
plot(as.phylo(fit), type="unrooted", tip.color=colors[clus6], 
     cex=0.7)

?plot.phylo

###############################K-평균군집###########################
data(USArrests)

##군집의 수 결정: Nbclust{NbClust}함수 이용
#install.packages("NbClust")
library(NbClust)
nc<- NbClust(USArrests, min.nc = 2, max.nc = 15, method = "kmeans")

#k-평균 군집
fit.km <- kmeans(USArrests,6)
mode(fit.km)
names(fit.km)
fit.km$cluster

#군집별 색 넣은 플랏
plot(USArrests, col=fit.km$cluster)
layout(1)
#x=Murder, y=Assault
plot(USArrests$Murder, USArrests$Assault, col=fit.km$cluster)
points(fit.km$centers, col=1:6, pch=8, cex=1.5) #각 군집의 중심점 추가

###2차원 군집그래프
#install.packages("cluster")
library(cluster)
#fit.km <- kmeans(USArrests,6)
clusplot(USArrests, fit.km$cluster)

##2차원 군집 그래프(k=2)
fit.km <- kmeans(USArrests,2)
clusplot(USArrests, fit.km$cluster)

##군집별 각 변수의 평균을 이용한 해성
fit.km


#############################밀도기반군집######################
data(ruspini)
dim(ruspini)
summary(ruspini)
plot(ruspini)

###DBSCAN
#install.packages("fpc")
library(fpc)
ds <- dbscan(ruspini, MinPts = 5, eps = 20)
ds
#0은 어느 군집에도 속하지 못하는 점으로 경계점 가운데 2개
#seed점(core)의 수가 72
mode(ds)
names(ds)
ds$cluster

plot(ruspini, col=ds$cluster+1, pch=19)
#잡음점때문에 +1
plot(ruspini, col=ds$cluster+1, pch=ds$cluster+1)

##data=USArrests
ds <- dbscan(USArrests,MinPts = 5, eps=20)
ds
plot(USArrests,col=ds$cluster)

