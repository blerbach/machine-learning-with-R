#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")
  
#Importando a base#
base = read.csv("plano-saude2.csv")

##Para comparar##

#Regressão linear simples
regressor_lin = lm(formula = custo ~ idade, data = base)
summary(regressor_lin)
cc1 = summary(regressor_lin)$r.squared

#Predizendo um valor
idade = c(40)
df = data.frame(idade)
previsão_lin = predict(regressor_lin, newdata = df)

#Plotando
library(ggplot2)
ggplot() + geom_point(aes(x = base$idade, y = base$custo), colour = "blue") +
  geom_line(aes(x = base$idade, y = predict(regressor_lin, newdata = base[-2])), colour = "red")

#Regressão polinomial 
base2 = base
base2$idade2 = base2$idade^2
base2$idade3 = base2$idade^3

regressor_poli = lm(formula = custo ~ ., data = base2)
summary(regressor_poli)
cc2 = summary(regressor_poli)$r.squared

#Predizendo um valor
idade = c(40)
idade2 = c(40^2)
idade3 = c(40^3)

df2 = data.frame(idade, idade2, idade3)
previsão_poli = predict(regressor_poli, newdata = df2)

#Plotando
library(ggplot2)
ggplot() + geom_point(aes(x = base$idade, y = base$custo), colour = "blue") +
  geom_line(aes(x = base$idade, y = predict(regressor_poli, newdata = base2[-2])), colour = "red")




