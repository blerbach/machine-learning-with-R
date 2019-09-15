#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")
  
#Importando a base#
base = read.csv("house-prices.csv")
base$id = NULL
base$date = NULL
base$sqft_living15 = NULL
base$sqft_lot15 = NULL
base$sqft_basement = NULL

library("caTools")
#Definindo proporções das bases de teste e aprendizagem
set.seed(1)
divisao <- sample.split(base$price, SplitRatio = 0.70)

#Definindo base de treinamento#
base_treinamento <- subset(base, divisao == TRUE )

#Definindo base de teste#
base_teste <- subset(base, divisao == FALSE )

#Regressor
library(randomForest)
regressor = randomForest(x = base_treinamento[2:16], y = base_treinamento$price, ntree = 100)
summary(regressor)

#Previsões
previsoes_treinamento = predict(regressor, newdata = base_treinamento[-1])

library(miscTools)
cr = rSquared(base_treinamento[["price"]], resid = base_treinamento[["price"]] - previsoes_treinamento)

previsoes_teste = predict(regressor, newdata = base_teste[-1])
mean(abs(base_teste[["price"]] - previsoes_teste))

cr = rSquared(base_teste[["price"]], resid = base_teste[["price"]] - previsoes_teste)

