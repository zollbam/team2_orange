# 목표 :  응답결과에 따른 연령, 교육수준, 나이 관련성

# 25항까지는 설문항목, 26~28항까지는 연령, 교육수준, 나이

library(psychTools)
bfiDF_2nd <- bfi
str(bfiDF_2nd)
bfiDF_omit <- na.omit(bfiDF_2nd)
str(bfiDF_omit)
?bfi

# O개방성
# C성실성
# E외향성
# A우호성
# N신경증

# 성별, 교육 범주화----
bfiDF_omit$f_gender <- factor(bfiDF_omit$gender, levels = c(1, 2), labels = c('Males', 'Females'))
bfiDF_omit$f_education <- factor(bfiDF_omit$education, levels = c(1, 2, 3, 4, 5),
                                 labels = c('HS', 'finished HS',
                                            'some college', 'college graduate',
                                            'graduate degree'))
str(bfiDF_omit)
# barplot ----
# 성별, 교육, 나이 그래프
barplot(table(bfiDF_omit$f_gender))
# 성별 응답자 중 여성이 많음
barplot(table(bfiDF_omit$f_education))
# 교육수준별 응답자 중 대재가 가장 많음
barplot(table(bfiDF_omit$age))
# 연령별 응답자 중 20살이 가장 많음
barplot(table(bfiDF_omit$sum_A)) #22
barplot(table(bfiDF_omit$sum_C)) #20
barplot(table(bfiDF_omit$sum_E)) #19
barplot(table(bfiDF_omit$sum_N)) #14
barplot(table(bfiDF_omit$sum_O)) #20

# boxplot(bfiDF_omit$f_gender)
boxplot(bfiDF_omit$f_education)
boxplot(bfiDF_omit$age)

bfiDF_omit$sum_A
names(bfiDF_omit)

# 카이제곱 검정 시작----
table(bfiDF_omit$f_gender, bfiDF_omit$f_education)
#           1   2   3   4   5
# Males    82  92 306 120 135
# Females 116 158 772 226 229
# HS finished HS some college college graduate
# Males    82          92          306              120
# Females 116         158          772              226
# 
# graduate degree
# Males               135
# Females             229

chisq.test(table(bfiDF_omit$f_gender, bfiDF_omit$f_education))
# Pearson's Chi-squared test
# 
# data:  table(bfiDF_omit$f_gender, bfiDF_omit$f_education)
# X-squared = 21.573, df = 4, p-value = 0.0002437
# 성별과 교육수준은 관계가 있다.

# 각 설문항목의 합----
bfiDF_omit$sum_A <- bfiDF_omit[,1]+bfiDF_omit[,2]+bfiDF_omit[,3]+bfiDF_omit[,4]+bfiDF_omit[,5]
bfiDF_omit$sum_C <- bfiDF_omit[,6]+bfiDF_omit[,7]+bfiDF_omit[,8]+bfiDF_omit[,9]+bfiDF_omit[,10]
bfiDF_omit$sum_E <- bfiDF_omit[,11]+bfiDF_omit[,12]+bfiDF_omit[,13]+bfiDF_omit[,14]+bfiDF_omit[,15]
bfiDF_omit$sum_N <- bfiDF_omit[,16]+bfiDF_omit[,17]+bfiDF_omit[,18]+bfiDF_omit[,19]+bfiDF_omit[,20]
bfiDF_omit$sum_O <- bfiDF_omit[,21]+bfiDF_omit[,22]+bfiDF_omit[,23]+bfiDF_omit[,24]+bfiDF_omit[,25]
# 테이블 막대그래프
str(bfiDF_omit)
str(bfiDF_omit[,29:35])
c(bfiDF_omit[,31])
str(bfiDF_omit[,c(27,31:35)])
library(psych)

library(corrplot)
corr.test(bfiDF_omit[,c(27,31:35)])
# p-value=>education-sum_A 0.03,
# # A우호성
# education-sum_C => 0.01
# # C성실성
# corrplot(bfiDF_omit[c(,27,31:35)])
corData <- bfiDF_omit[,c(27,31:35)]
corMatrix <- cor(corData)
corMatrix
corrplot(corMatrix)
# 회귀분석x 범주형으로 로지스틱

lm(f_education~sum_A, data=bfiDF_omit)

# 단순선형회귀
# 종속변수 :  age
# 독립변수 :  항목?

plot(age~sum_A, data=bfiDF_omit, pch=19,
     col='steelblue')
form <- age~sum_A
model_1 <- lm(formula=form, data=bfiDF_omit)
abline(model_1, lwd=2, col='tomato')
summary(model_1)
anova(model_1)
getwd()
str(bfiDF_omit)
# 다중 선형 회귀
# education~sum_A+sum_C+sum_E+sum_N+sum_O
bfiDF_e_sum <- subset(bfiDF_omit,
                      select=c(27, 31:35))
cor(bfiDF_e_sum)
plot(bfiDF_e_sum, pch=19, col='steelblue')
form_2 = education ~ sum_A+sum_C+sum_E+sum_N+sum_O
lm(form_2, data = bfiDF_e_sum)
# 막대그래프, 박스플롯

