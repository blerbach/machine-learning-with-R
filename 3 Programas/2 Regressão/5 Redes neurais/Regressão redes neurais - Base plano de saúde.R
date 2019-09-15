rm(list = ls())
#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")
  
#Importando a base#
base = read.csv("plano-saude2.csv")

#Pode usar para regressão linear, polinomial..
library(h2o)
h2o.init(nthreads = -1)
regressor = h2o.deeplearning(y = "custo", training_frame = as.h2o(base), activation = "Rectifier",
                             hidden = c(100,100), epochs = 1000)
summary(regressor)

previsoes = h2o.predict(regressor, newdata = as.h2o(base[-2]))
previsoes = as.vector(previsoes)

library(miscTools)
cc = rSquared(base[["custo"]], resid = base[["custo"]] - previsoes)

library(ggplot2)
ggplot () + geom_point(aes(x = base$idade, y = base$custo), colour = 'blue') +
  geom_point(aes(base$idade, y = previsoes), colour = "red")





