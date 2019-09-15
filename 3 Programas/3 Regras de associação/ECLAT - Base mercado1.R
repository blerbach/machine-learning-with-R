#install.packages("arules")
library(arules)

#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")

#Importando a base#
base = read.transactions("mercado2.csv", sep = ",", rm.duplicates = TRUE)
summary(base)

itemsets = eclat(data = base, parameter = list(support = 0.003, minlen = 3))
inspect(sort(itemsets, by = "support"))


        