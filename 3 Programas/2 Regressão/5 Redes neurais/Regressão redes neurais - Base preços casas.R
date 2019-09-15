rm(list = ls())
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
library(h2o)
h2o.init(nthreads = -1)
regressor = h2o.deeplearning(y = "price", training_frame = as.h2o(base_treinamento), activation = "Rectifier", 
                             hidden = c(100, 100), epochs = 100)

#Previsões
previsoes_treinamento = predict(regressor, newdata = as.h2o(base_treinamento[-1]))
previsoes_treinamento = as.vector(previsoes_treinamento)

library(miscTools)
cr = rSquared(base_treinamento[["price"]], resid = base_treinamento[["price"]] - previsoes_treinamento)

previsoes_teste = predict(regressor, newdata = as.h2o(base_teste[-1])) 
previsoes_teste = as.vector(previsoes_teste)
mean(abs(base_teste[["price"]] - previsoes_teste))

cr = rSquared(base_teste[["price"]], resid = base_teste[["price"]] - previsoes_teste)

