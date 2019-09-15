#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")
  
#Importando a base#
base = read.csv("plano-saude2.csv")

#Pode usar para regressão linear, polinomial..
library(e1071)
regressor = svm(formula = custo ~., data = base, type = "eps-regression", kernel = "radial") #melhor kernel
summary(regressor)

previsoes = predict(regressor, newdata = base[-2])

library(miscTools)
cc = rSquared(base[["custo"]], resid = base[["custo"]] - previsoes)

library(ggplot2)
ggplot () + geom_point(aes(x = base$idade, y = base$custo), colour = 'blue') +
  geom_line(aes(base$idade, y = previsoes), colour = "red")





