##############3 로지스틱 회귀

# 로지스틱 회귀분석 ★★★★★ 많이  사용됨
# (같은 회귀모형인데 반응변수가 범주형인 경우 적용)
# 설명변수의 값이 주어질 때 반응변수의 각 범주에 속할 확률이
# 얼마인지 추정 

# 이진형(0또는1 ex)성별)
# 1은 성공 0은 실패를 의미함

# 다중로지스틱(설명변수가 여러개임)


#성공의 확률은 누적 분포함수로 구할 수 있다.

#프로빗모형은 표준정규분포이용

#기준값이 0.5가 아닐때 아닌 걸 잘 설명하면 가능


##예제 1
data(iris)
head(iris)
a <- subset(iris, Species=="setosa"|Species=="versicolor")
#subset(데이터, 조건)     #species가 이 두개인 데이터만 가지고 와라
dim(a)

a$Species <- factor(a$Species) #factor세개인걸 두개로 바꿈
str(a)


#factor에서는 두번째에 있는걸 성공으로 본다.
#파이 x를 veriscolor에 포함될 확률로 생각

b <- glm(Species~Sepal.Length, data=a, family=binomial)
#(목적변수~입력변수+입력변수+입력변수, 이데이터는 a라는 곳에 있다., 로지스틱회귀분석)
b

summary(b)
# Sepal.Length  3.28e-07가 0.05보다 작다. 그래서 회귀분석에 영향을 줌

