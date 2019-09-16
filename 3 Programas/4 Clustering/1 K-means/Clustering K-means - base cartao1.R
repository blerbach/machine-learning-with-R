#Base nativa do R
base = iris
base2 = base[1:2]

#Aleatorizando a base
set.seed(1)

#K-means - Definindo número de centetróides
kmeans = kmeans(x = base2, centers = 3)

#Previsões
previsoes = kmeans$cluster        

#Plotando clusters
library(cluster)
clusplot(base2, previsoes, colour = TRUE)

#Conferindo 
table(base$Species, previsoes)
