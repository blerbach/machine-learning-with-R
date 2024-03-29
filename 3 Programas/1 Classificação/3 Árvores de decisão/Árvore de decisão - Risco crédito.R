#Definindo Diret�rio#
setwd("C:/Users/rafae/Desktop/Ci�ncia de Dados/4 Material de estudos/1 Curso Machine learning - Udemy")

base_credit <- read.csv("2 Bases/risco-credito.csv")

#Instalando pacote com fun��es para �rvore de deci��es#
#install.packages("rpart")
library(rpart)

#Criando classificador#
classificador <- rpart(formula = risco ~ ., data = base_credit, control = rpart.control(minbucket = 1)) #Formula = classe, atributos hist�ricos - rpart = dispensa poda (apenas para bases pequenas)
print(classificador)

#Plotando a �rvore#
plot(classificador)
text(classificador)

#Instalando pacote para melhor formata��o da �rvore#
#install.packages("rpart.plot")
library(rpart.plot)

rpart.plot(classificador)

#Classificando Registros - Teste#
#Registro 1 - historia: boa, divida: alta, garantias: nenhuma, renda: acima_35
#Registro 2 - historia: ruim, divida: alta, garantias: adequada, renda: 0_15

#Criando vetores#
historia <- c("boa", "ruim" )
divida <- c("alta", "alta")
garantias <- c("nenhuma", "adequada")
renda <- c("acima_35", "0_15")

#Criando matriz#
data_frame <- data.frame(historia, divida, garantias, renda)

#Predizendo dados#
previsao <- predict(classificador, newdata = data_frame)
print(previsao)












