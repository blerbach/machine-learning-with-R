#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy")

base_credit <- read.csv("2 Bases/risco-credito.csv")

#Instalando pacote com funções para Árvore de decições#
#install.packages("rpart")
library(rpart)

#Criando classificador#
classificador <- rpart(formula = risco ~ ., data = base_credit, control = rpart.control(minbucket = 1)) #Formula = classe, atributos históricos - rpart = dispensa poda (apenas para bases pequenas)
print(classificador)

#Plotando a árvore#
plot(classificador)
text(classificador)

#Instalando pacote para melhor formatação da árvore#
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












