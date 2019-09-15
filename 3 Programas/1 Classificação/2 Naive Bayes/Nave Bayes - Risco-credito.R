#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy")

base_credit <- read.csv("2 Bases/risco-credito.csv")

#Instalando pacote com funções para Naiva Bayes#
#install.packages("e1071")
library(e1071)

#Criando tabela de probabilidades - Treinamento do algoritmo#
classifica <- naiveBayes(x = base_credit[-5], y = base_credit$risco)

#Tabulando dados#
print(classifica)

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

#Predizendo Registro 1#
previsao <- predict(classifica, newdata = data_frame, "raw")
print(previsao)



