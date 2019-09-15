#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")
  
#Importando a base#
base = read.csv("house-prices.csv")

library("caTools")

#Definindo propor??es das bases de teste e aprendizagem#
set.seed(1)
divisao <- sample.split(base$price, SplitRatio = 0.70)

#Definindo base de treinamento#
base_treinamento <- subset(base, divisao == TRUE )

#Definindo base de teste#
base_teste <- subset(base, divisao == FALSE )

#Regressor
regressor = lm(formula = price ~ sqft_living, data = base_treinamento)
summary(regressor)

#Previsões
previsoes_treino = predict(regressor, newdata = base_treinamento[6])


#Plotando gráfico de dispersão
library(ggplot2)
#Previsões como pontos
ggplot() + geom_point(aes(x = base_treinamento$sqft_living, y = base_treinamento$price), colour = "blue") +
  geom_point(aes(x = base_treinamento$sqft_living, y = previsoes_treino), colour = "red") 

#Previsões como reta
ggplot() + geom_point(aes(x = base_treinamento$sqft_living, y = base_treinamento$price), colour = "blue") +
  geom_line(aes(x = base_treinamento$sqft_living, y = previsoes_treino), colour = "red") 

#Testando modelo
previsoes_teste = predict(regressor, newdata = base_teste[6])

#Verificando erro
resultado = abs(base_teste[3] - previsoes_teste)
mean(resultado[["price"]])

#Pacote para análise residual
#install.packages("miscTools")
library(miscTools)
cr = rSquared(base_teste[["price"]], resid = base_teste[["price"]] - previsoes_teste)






