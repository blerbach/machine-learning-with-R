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
regressor = lm(formula = price ~ ., data = base_treinamento)
summary(regressor)

#Previsões
previsoes = predict(regressor, newdata = base_teste[-1])

#Verificando erro
mean(abs(base_teste[["price"]] - previsoes))

library(miscTools)
cr = rSquared(base_teste[["price"]], resid = base_teste[["price"]] - previsoes)


