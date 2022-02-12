##########################################################
           #5장. 텍스트를 이용한 정보분석#
##########################################################
library(dplyr)
library(ggplot2)

###자료파일 선택 : bigkinds_코로나19.txt
data.file <- file.choose()
data.raw <- readLines(data.file, encoding = "UTF-8") #UTF-8파일로 작성되어있다는걸 알려줌
data.raw %>% head()


###콤마(,)로 값 분리
data.split <- strsplit(data.raw, ",") #각각의 단어들을 저장


###벡터로 변환
data.vector <- data.split%>%unlist() #리스트구조를 벡터구조로 바꿔줌
data.vector%>%head()


###빈도수 기준 상위 50개 추출
word.top <- data.vector %>% table() %>% sort(T) %>% head(50)
#table 넣은거는 각각의 단어가 몇개인지 알려줌 
#sort는 정렬 T는 내림차순 정렬(많이나온 결과부터 정렬)
#head= 앞에잇는데이터 
word.top.df <- as.data.frame(word.top) 
#as는 구조를 바꿈 as.data.frame을 통해 데이터 프레임으로 구조 바꿈
names(word.top.df) <- c("word", "count")
word.top.df %>% head()


###막대그래프 -상위 30개
ggplot(word.top.df[1:30,], aes(word, count)) +
  geom_bar(stat = "identity")+ coord_flip() 
#stat = "identity"는 내가 이미 숫자를 세어놧으니(table을 통해 셈) 그거 이용해서 그려라
#coord_flip() = 가로 막대 그래프


#install.packages("wordcloud2")
library("wordcloud2")
#워드클라우드
word.top.use <- word.top.df %>% filter(count < 3000)
word.top.use %>% wordcloud2(minRotation=0, maxRotation=0)
#minRotation : 단어가 회전해야 하는 경우 텍스트가 회전해야하는 최소 회전 (라디안 값)입니다.
#maxRotation : 단어가 회전해야하는 경우 텍스트가 회전해야하는 최대 회전 (rad).
#모든 텍스트를 한 각도로 유지하는 것과 동일한 두 값을 설정하십시오.



