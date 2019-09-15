#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")

#Importando a Base#
base_credit <- read.csv("credit-data.csv")

#Dropando variável ID Cliente#
base_credit$clientid <- NULL

############################
#Corrigindo inconsistências#
############################

###Preenchendo idades negativas com a média da variável
base_credit$age <- ifelse(base_credit$age < 0, mean(base_credit$age[base_credit$age > 0], na.rm = TRUE), base_credit$age)

###Preenchendo missings da idade com a média da variável
base_credit$age <- ifelse(is.na(base_credit$age), mean(base_credit$age, na.rm = TRUE), base_credit$age)

#Conferindo novamente as estatísticas descritivas#
summary(base_credit)

#########################
#ESCALONAMENTO DOS DADOS#
#########################

##Por padronização - CN2 dispensa escalonamento pois variáveis precisao ser do tipo STRING
#base_credit[,1:3] <- scale(base_credit[,1:3])

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

#Instalando pacote com funções para Indução de regras
#install.packages("RoughSets")
library(RoughSets)

#Definindo tabelas de decisão#
dt_treinamento <- SF.asDecisionTable(dataset = base_treinamento, decision.attr = 4) #DT é equivalente ao Data Frame
dt_teste <- SF.asDecisionTable(dataset = base_teste, decision.attr = 4)

#Criando intervalos para transformação das VAR's numéricas em Strings#
intervalo <- D.discretization.RST(dt_treinamento, nOfIntervals = 4)

#Criando classes nas VAR's
dt_treinamento <- SF.applyDecTable(dt_treinamento, intervalo)
dt_teste <- SF.applyDecTable(dt_teste, intervalo)

#Criando classificador#
classificador <- RI.CN2Rules.RST(dt_treinamento, K = 5)

#Predizendo base teste#
previsao <- predict(classificador, newdata = dt_teste[-4])

#Matriz confusão#
matriz_confusao <- table(dt_teste[,4], unlist(previsao))
print(matriz_confusao)

#install.packages("caret")
library("caret")

#Conferindo precisão do algoritmo#
confusionMatrix(matriz_confusao)





