#install.packages("arules")
library(arules)

#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")

#Importando a base#
base = read.csv("mercado2.csv", header = FALSE)
base = read.transactions("mercado2.csv", sep = ",", rm.duplicates = TRUE)
summary(base)

itemFrequencyPlot(base,topN = 7)

regras = apriori(data = base, parameter = list(support =0.003, confidence = 0.2))
inspect(sort(regras, by = "lift")[1:20])

        