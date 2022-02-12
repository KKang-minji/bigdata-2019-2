#4.19
x <- 1:5
y <- rep(2,5) #2라는 값 5개
x+y
x-y
x*y
x/y
x^y

#4.20
x <- 1:3
z <- rep(3,5)
x+z  
# x + z : 두 객체의 길이가 서로 배수관계에 있지 않습니다
#길이가 맞지 않으면 계산 되지 않음


#4.21
x <- 1:10
y <- rep(5,10)
z <- x<y
z
x<=y #크거나 같은가 T,F
x==y #같은가 T,F




#논리값 연산- and(&), or(|)
x>5 & y<2
x>5 | y<2


#4.22 NA
x <- c(1,2,3,NA,5)
is.na(x) # 결측값이 포함되어 있는지 확인하는 방법 

#4.23
x<- -10:10
x
x[3]
x[11]
x[1:3]
x[c(1,3,5)]
# -를 넣으면 그 차례의 값을 제거
x[-2]
x[-c(1,3,5)]
x[c(-1,-3,-5)]


x <- c(1,2,3,NA,5)
x[is.na(x)]
x[!is.na(x)]  # ! = 논리값을 바꿔줌
#NA에 값을 저장
x[is.na(x)] <- 4
x

#4.24 filter
x <- 1:10
x[x>5]

#4.25
x <- array(1:12,dim=c(3,4)) #dim= 행렬
x
x <- matrix(1:12, 3, 4) #matrix( data, nrow(행), ncol(열), byrow = FALSE)
x
x <- matrix(2,4,5)
x
x <- matrix(1:6, 2, 3,byrow=T) 
#byrow: 기본적으로 열(column)을 기준으로 숫자가 들어감 (FALSE) 
        #TRUE로 지정할 시 행(row) 기준으로 숫자가 들어간다.
x

#4.26
x <- 1:5
y <- 6:10
cbind(x,y) #열
rbind(x,y) #행

#4.27
A <- matrix(1:12,3,4)
B <- matrix(1:12,3,4)
A+B
A-B
A*B
A/B

A*3
A^2

#4.28

#4.29
x <- matrix(1:12,3,4)
x
colnames(x) <- c('a','b','c','d')
x
rownames(x) <- c('e','f','g')
x

#행과 열의 개수
dim(x) #dataframe의 길이를 관측할 때 사용, 행과 열의 개수를 모두 출력
nrow(x) #행 개수
ncol(x) #열 개수


#3)리스트(list)
#4.30
x <- c(3,"a",T)
x

#4.30
H <- list(kor="홍",eng= "GD", age=45, married=T,
          no.child=2, child.age=c(15,12))

H

#indexing
H$age
H$married
str(H) #데이터 구조, 변수 개수, 변수 명, 관찰치 개수, 관찰치의 미리보기


#4.32
H[1:2]

#4.34
x <- c(10,20,30)
y <- c("A301","A302","A303")
z <- data.frame(score=x, ID=y) #dataframe으로 표만들면 행으로 지정됨
z

#4.36
x <- 1:10
class(x) #데이터의 속성만 표시 
x <- "a"
class(x) #"character"= 수와 텍스트 결합된 경우 #"integer"= 정수
x <- matrix(0,3,3)
class(x)
x <- list(3, "a", T)
class(x)
class(z)
typeof(z)
x <- matrix(0,3,3)
class(x)
typeof(x) #typeo= 변수의 타입을 알려줌 "double"


#factor
x <- c('a','b','c','b','b')
x
y <- factor(x) #factor은 레벨을 가진다는 것.
y
as.integer(y) #자료형 변환 







