#Definindo Diret�rio#
setwd("C:/Users/rafae/Desktop/Ci�ncia de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")

#Importando a base#
base_censo <- read.csv("census.csv")

#Removendo VAR n� de Obs#
base_censo$X <- NULL

#Constagem dos Registros#
table(base_censo$sex)
unique(base_censo$sex)

#Transformando VAR categ�rica em discreta#
base_censo$sex <- factor(base_censo$sex, levels = c(" Female", " Male"), labels = c(0, 1))
base_censo[is.na(base_censo$sex)]

base_censo$workclass = factor(base_censo$workclass, levels = c(' Federal-gov', ' Local-gov', ' Private', ' Self-emp-inc', ' Self-emp-not-inc', ' State-gov', ' Without-pay'), labels = c(1, 2, 3, 4, 5, 6, 7))
base_censo$education = factor(base_censo$education, levels = c(' 10th', ' 11th', ' 12th', ' 1st-4th', ' 5th-6th', ' 7th-8th', ' 9th', ' Assoc-acdm', ' Assoc-voc', ' Bachelors', ' Doctorate', ' HS-grad', ' Masters', ' Preschool', ' Prof-school', ' Some-college'), labels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16))
base_censo$marital.status = factor(base_censo$marital.status, levels = c(' Divorced', ' Married-AF-spouse', ' Married-civ-spouse', ' Married-spouse-absent', ' Never-married', ' Separated', ' Widowed'), labels = c(1, 2, 3, 4, 5, 6, 7))
base_censo$occupation = factor(base_censo$occupation, levels = c(' Adm-clerical', ' Armed-Forces', ' Craft-repair', ' Exec-managerial', ' Farming-fishing', ' Handlers-cleaners', ' Machine-op-inspct', ' Other-service', ' Priv-house-serv', ' Prof-specialty', ' Protective-serv', ' Sales', ' Tech-support', ' Transport-moving'), labels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14))
base_censo$relationship = factor(base_censo$relationship, levels = c(' Husband', ' Not-in-family', ' Other-relative', ' Own-child', ' Unmarried', ' Wife'), labels = c(1, 2, 3, 4, 5, 6))
base_censo$race = factor(base_censo$race, levels = c(' Amer-Indian-Eskimo', ' Asian-Pac-Islander', ' Black', ' Other', ' White'), labels = c(1, 2, 3, 4, 5))
base_censo$native.country = factor(base_censo$native.country, levels = c(' Cambodia', ' Canada', ' China', ' Columbia', ' Cuba', ' Dominican-Republic', ' Ecuador', ' El-Salvador', ' England', ' France', ' Germany', ' Greece', ' Guatemala', ' Haiti', ' Holand-Netherlands', ' Honduras', ' Hong', ' Hungary', ' India', ' Iran', ' Ireland', ' Italy', ' Jamaica', ' Japan', ' Laos', ' Mexico', ' Nicaragua', ' Outlying-US(Guam-USVI-etc)', ' Peru', ' Philippines', ' Poland', ' Portugal', ' Puerto-Rico', ' Scotland', ' South', ' Taiwan', ' Thailand', ' Trinadad&Tobago', ' United-States', ' Vietnam', ' Yugoslavia'), labels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41))
base_censo$income = factor(base_censo$income, levels = c(' <=50K', ' >50K'), labels = c(0, 1))

#Escalonando vari�veis discretas#
for (i in c(1,3,5,11,12,13 )) {
  base_censo[, i] <- scale(base_censo[, i])
}

#instalando pacote com fun��es para machine learning#
#install.packages("caTools")
library("caTools")

#Definindo propor��es das bases de teste e aprendizagem#
set.seed(1)
divisao <- sample.split(base_censo$income, SplitRatio = 0.85) #75% da base para aprendizagem

#Definindo base de treinamento#
base_treinamento <- subset(base_censo, divisao == TRUE )

#Definindo base de teste#
base_teste <- subset(base_censo, divisao == FALSE )

#Instalando pacote com fun��es para Naiva Bayes#
#install.packages("e1071")
library(e1071)

#Criando tabela de probabilidades - Treinamento do algoritmo#
classifica <- naiveBayes(x = base_treinamento[-15], y = base_treinamento$income)

#Tabulando dados#
print(classifica)

#Predizendo Base teste#
previsao <- predict(classifica, newdata = base_teste[-15])
print(previsao)

#Matriz confus�o#
matriz_confusao <- table(base_teste[,15], previsao)
print(matriz_confusao)

#install.packages("caret")
library("caret")

#Conferindo precis�o do algoritmo#
confusionMatrix(matriz_confusao)







