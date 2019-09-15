#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")

#Importando a base#
base_plano = read.csv("plano-saude.csv")

#Correlação entre as variáveis
cor(base_plano$idade, base_plano$custo)

#Plotando gráfico de dispersão
library(ggplot2)
ggplot(data = base_plano, aes(x = idade, y = custo)) + geom_point()

#Gerando regressor
regressor = lm(formula = custo ~ idade, data = base_plano)
summary(regressor)

#Vizualizando os parâmetros
b0 = regressor$coefficients[1]
b1 = regressor$coefficients[2]
correla = summary(regressor)$adj.r.squared

#Realizado previsões
previsoes = predict(regressor, newdata = base_plano[-2])

#Previsões como pontos
ggplot() + geom_point(aes(x = base_plano$idade, y = base_plano$custo), colour = "blue") + geom_point(aes(x = base_plano$idade, y = previsoes), colour = "red") 

#Previsões como reta
ggplot() + geom_point(aes(x = base_plano$idade, y = base_plano$custo), colour = "blue") +
  geom_line(aes(x = base_plano$idade, y = previsoes), colour = "red") +
  ggtitle("Idade X custo") + xlab("Idade") + ylab("Custo")

#Previsão de um novo registro
idade = c(40)
df = data.frame(idade)
previsao1 = predict(regressor, newdata = df)
 
