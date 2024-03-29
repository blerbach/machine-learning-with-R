#Definindo Diret�rio#
setwd("C:/Users/rafae/Desktop/Ci�ncia de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")

#Importando a Base#
base_credit <- read.csv("credit-data.csv")

#Dropando vari�vel ID Cliente#
base_credit$clientid <- NULL

############################
#Corrigindo inconsist�ncias#
############################

###Preenchendo idades negativas com a m�dia da vari�vel
base_credit$age <- ifelse(base_credit$age < 0, mean(base_credit$age[base_credit$age > 0], na.rm = TRUE), base_credit$age)

###Preenchendo missings da idade com a m�dia da vari�vel
base_credit$age <- ifelse(is.na(base_credit$age), mean(base_credit$age, na.rm = TRUE), base_credit$age)

#Conferindo novamente as estat�sticas descritivas#
summary(base_credit)

#########################
#ESCALONAMENTO DOS DADOS#
#########################

##Por padroniza��o
base_credit[,1:3] <- scale(base_credit[,1:3])

#Encode da classe#
base_credit$default <- factor(base_credit$default, levels = c(0,1))

#instalando pacote com fun��es para machine learning#
#install.packages("caTools")
library("caTools")

#Definindo propor��es das bases de teste e aprendizagem#
set.seed(1)
divisao <- sample.split(base_credit$default, SplitRatio = 0.75) #75% da base para aprendizagem

#Definindo base de treinamento#
base_treinamento <- subset(base_credit, divisao == TRUE )

#Definindo base de teste#
base_teste <- subset(base_credit, divisao == FALSE )

#Instalando pacote com fun��es para Naiva Bayes#
#install.packages("e1071")
library(e1071)

#Criando tabela de probabilidades - Treinamento do algoritmo#
classifica <- naiveBayes(x = base_treinamento[-4], y = base_treinamento$default)

#Tabulando dados#
print(classifica)

#Predizendo Base teste#
previsao <- predict(classifica, newdata = base_teste[-4])
print(previsao)

#Matriz confus�o#
matriz_confusao <- table(base_teste[,4], previsao)
print(matriz_confusao)

#install.packages("caret")
library("caret")

#Conferindo precis�o do algoritmo#
confusionMatrix(matriz_confusao)





