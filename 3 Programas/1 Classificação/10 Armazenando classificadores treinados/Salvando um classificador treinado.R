#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")

#Chamando programa com funções#
source("C:/Users/rafae/Desktop/Ciência de Dados/3 Programas/R/Functions.R", encoding = 'UTF-8')

#Importando a Base#
base_credit <- read.csv("credit-data.csv")

#Dropando variável ID Cliente#
base_credit$clientid <- NULL

#Estatística descritiva da base#
summary(base_credit)

#############################
#Corrigindo inconsistências #
#############################

###Preenchendo idades negativas e missings com a média da variável
base_credit$age <- pre_proces(a = base_credit$age)

#########################
#ESCALONAMENTO DOS DADOS#
#########################

##Por padronização
base_credit[,1:3] <- scale(base_credit[,1:3])

#Encode da classe#
base_credit$default <- factor(base_credit$default, levels = c(0,1))

#Classificador Random forest
library(randomForest)
classificadorrandomforest = randomForest(x = base_credit[-4], y = base_credit$default, ntree = 30, mtry = 2)

#Classificador Rede Neural
library(h2o)
h2o.init(nthreads = -1)
classificadorredeneural = h2o.deeplearning(y = "default", training_frame = as.h2o(base_credit),
                                           activation = "Rectifier",
                                           hidden = c(100),
                                           epochs = c(100))

#Salvando classificadores treinados
saveRDS(classificadorrandomforest, "rfFinal.rds")
saveRDS(classificadorredeneural,"rnaFinal.rds")








