#######제 6장. 데이터

##6.2 점분포
getwd()
setwd(choose.dir())
getwd()
list.files()

r <- read.csv("khkh.csv")
r
head(r)
dotchart(r$lifemoney,labels=row.names(r))
#dotchart 연속형데이터

r <- read.csv("kh.csv")
r
dim(r)
head(r)
tb <- table(r$gender)
tb
barplot(tb)
barplot(tb, xlab="성별", ylab="성별수", main="성별에 따른 빈도수", ylim=c(0,300))
#ylim= 구간 넓이 지정 c(시작, 끝)
#메뉴얼활용해서 그림그리는거 시험출제



#히스토그램
r <- read.csv("kh.csv")
hist(r$money, xlab ="연봉", ylab="계급수", main="히스토그램")

hist(r$money, xlab ="연봉", ylab="계급수", main="히스토그램",freq=F) 
#freq=F을 쓰면 확률로 바뀜
lines(density(r$money)) #lines는 기존에 있는 그래프위에 선을 그려라 #density는 확률 분포 곡선

