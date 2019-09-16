#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")

#CrIando vetores e data frame
idade = c(20, 27, 21, 37, 46, 53, 55, 47, 52, 32, 39, 41, 39, 48, 48)
salario = c(1000, 1200, 2900, 1850, 900, 950, 2000, 2100, 3000, 5900, 4100, 5100, 7000, 5000, 6500)

plot(idade, salario)

base = data.frame(idade, salario)

#Escalonando data frame
base = scale(base)

#Aleatorizando a base
set.seed(1)

#K-means - Definindo número de centetróides
kmeans = kmeans(x = base, centers = 3)

#Centróides
centroides = kmeans$centers

#Previsões
previsoes = kmeans$cluster        

#Plotando clusters
library(cluster)
clusplot(base, previsoes, xlab = "Salario", ylab = "Idade", main = "Agrupamento salário", 
         lines = 0, shade = TRUE, colour = TRUE, labels = 2)
