
######################군집분석1######################################

data(USArrests)
View(USArrests)

### 계층적 순집 수행
# 주들 간의 유클리드 거리
d <- dist(data.test, method='euclidean')
#dist(): 거리행렬 제공하는 함수
#method(): 다양한 방식으로 거리를 정의할 수 있다.
fit <- hclust(d, method='average')
#hclust: 계층적 군집분석 수행
#method: 병합 방법 지정


# 군집 결과의 시각화: 덴드로그램
plot(fit, hang=-1)
groups <- cutree(fit, k=6)
groups
#cutree(): 계층적 군집의 결과를 이용하여 
#높이(h)나 그룹수(K)를 옵션으로 지정하여 원하는 수의 그룹으로 나눌 수 있다.

plot(fit, hang=-1) #글자 위치 지정(정리)

#함수 이용하여 그룹 사각형으로 구분
rect.hclust(fit, k=6)
#cutree()함수그룹과 동일하게 표시되었음
