#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")
  
#Importando a base#
base = read.csv("plano-saude2.csv")

library(randomForest)
regressor = randomForest(x = base[1], y = base$custo, ntree = 10000)
summary(regressor)

previsoes = predict(regressor, newdata = base[-2])

library(miscTools)
cc = rSquared(base[["custo"]], resid = base[["custo"]] - previsoes)

library(ggplot2)
ggplot () + geom_point(aes(x = base$idade, y = base$custo), colour = 'blue') +
  geom_line(aes(base$idade, y = previsoes), colour = "red")

#Para mais registros
x_teste = seq(min(base$idade), max(base$idade), 0.1) #Sequencia 0.1 a 0.1
previsoes2 = predict(regressor, newdata = data.frame(idade = x_teste)) 

ggplot () + geom_point(aes(x = base$idade, y = base$custo), colour = 'blue') +
  geom_line(aes(x = x_teste, y = previsoes2), colour = "red")





