#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")

#Chamando programa com funções#
source("C:/Users/rafae/Desktop/Ciência de Dados/3 Programas/R/Functions.R", encoding = 'UTF-8')

#Importando a Base#
base_credit <- read.csv("credit-data.csv")

#Dropando variável ID Cliente#
base_credit$clientid <- NULL

#Estatística descritiva da base#
summary(base_credit)

#############################
#Corrigindo inconsistências #
#############################

###Preenchendo idades negativas e missings com a média da variável
base_credit$age <- pre_proces(a = base_credit$age)

#########################
#ESCALONAMENTO DOS DADOS#
#########################

##Por padronização
base_credit[,1:3] <- scale(base_credit[,1:3])

#Encode da classe#
base_credit$default <- factor(base_credit$default, levels = c(0,1))

#instalando pacote com funções para machine learning#
#install.packages("caTools")
library("caTools")

#Definindo proporções das bases de teste e aprendizagem#
set.seed(1)
divisao <- sample.split(base_credit$default, SplitRatio = 0.75) #75% da base para aprendizagem

#Definindo base de treinamento#
base_treinamento <- subset(base_credit, divisao == TRUE )

#Definindo base de teste#
base_teste <- subset(base_credit, divisao == FALSE )

#instalando pacote com funções para machine learning#
#install.packages("e1071")
library("e1071")

#Criando classificador#
classificador <- svm(formula = default ~., data = base_treinamento, type = "C-classification",
                     kernel = "radial", cost = 10000) #melhor classificador foi o radial
#Predizendo dados#
previsao <- predict(classificador, newdata = base_teste[-4])

#Matriz confusão#
matriz_confusao <- table(base_teste[,4], previsao)
print(matriz_confusao)

#install.packages("caret")
library("caret")

#Conferindo precisão do algoritmo#
confusionMatrix(matriz_confusao)



