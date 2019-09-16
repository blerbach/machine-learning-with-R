#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")
base = read.csv("credit-card-clients.csv", header = TRUE)

#Criando dívida acumulada
base$BILL_tot = base$BILL_AMT1 + base$BILL_AMT2 + base$BILL_AMT3 + base$BILL_AMT4 + base$BILL_AMT5 + base$BILL_AMT6

#Criando novo dataset resumido
x = data.frame(limite = base$LIMIT_BAL, gasto = base$BILL_tot,  genero = base$SEX, 
               educacao = base$EDUCATION, civil = base$MARRIAGE, idade = base$AGE)

#Escalonando data frame
x = scale(x)

#Aleatorizando a base
set.seed(1)

#Definindo número de clusters por WCSS
wcss = vector()
for (i in 1:10) {
  kmeans = kmeans(x = x, centers = i)
  wcss[i] = sum(kmeans$withinss)
}

plot(1:10, wcss, type = "b", xlab = "Clusters", ylab = "WCSS")
#Escolhendo 5, pois cotovelo 

#Aleatorizando a base
set.seed(1)

#K-means - Definindo número de centetróides
kmeans = kmeans(x = x, centers = 4)

#Previsões
previsoes = kmeans$cluster        

#Plotando clusters
pairs(x, col = c(1:4)[previsoes])
