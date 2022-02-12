

#데이터 관리와 코딩
################################
x <- 3 #c(3,4,5)
x


###code 4.2
x <- c(1, 2.1, 3.2, 5)
v <- c(TRUE, FALSE, F, T)
v


x[2] #두번째있는 값
idx <-c(2,4) 
x[idx] #두번째, 네번째에 있는 값
x[c(2,4)]


#code 4.14
fruit <- c(5,3,2)
names(fruit) <- c("apple","orange","peach")
names(fruit)
fruit

fruit[2]
fruit[c("apple","peach")]


#4.15
a <- c(1,2,3)
b <- c(5,6)
x <- c(a,4,b)

#4.16
a <- c(1,2,3)
a[5] <- 5 # 5번째에 5집어넣기
a

x
#4.17
append(x, 55, after=5) # append(벡터, values=추가할 값, after=추가될 위치)
append(x, -55, after=0)



#4.18
x <- seq(1, 10, 0.7) #1부터 0.7간격으로 10개
x <- 1:10
x <- -1:10
x <- -1:-10
x <- seq(from=0, to=1, by=0.1) #0에서 1까지 0.1 간격
y <- seq(from=0, to=2, length=11) #0에서 2까지 일정한 간격으로 11한개 추출
z <- 1:10
3:-3
rep(2,10) #2라는 값을 10개


