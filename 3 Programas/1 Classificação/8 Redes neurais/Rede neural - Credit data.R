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
divisao <- sample.split(base_credit, SplitRatio = 0.75) #75% da base para aprendizagem

#Definindo base de treinamento#
base_treinamento <- subset(base_credit, divisao == TRUE )
base_treinamento$default <- as.numeric(as.factor(base_treinamento$default)) -1

#Definindo base de teste#
base_teste <- subset(base_credit, divisao == FALSE )
base_teste$default <- as.numeric(as.factor(base_teste$default)) -1

#install.packages("h2o")
library(h2o)
h2o.init(nthreads = -1)

#Classificador
classificador <- h2o.deeplearning(y = "default", 
                                  training_frame = as.h2o(base_treinamento), #convertendo base para tipo h2o
                                  activation = "Rectifier", #definindo qual função de ativação
                                  hidden = c(500), # Uma camada oculta com 500 neurônios
                                  epochs = 1000) # Quantas vezes será feito o ajuste de pesos
                                  
#Previsão
previsao = h2o.predict(classificador, newdata = as.h2o(base_teste[-4]))
previsao <- (previsao > 0.5) #Categorizando
previsao <- as.vector(previsao) #Transformando em vetor


#Análise de resíduos
matriz_confusao <- table(base_teste[, 4], previsao)
library(caret)
confusionMatrix(matriz_confusao)




