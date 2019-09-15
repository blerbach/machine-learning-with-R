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

#Carregando classificadores
rfFinal = readRDS("rfFinal.rds")
rnaFinal = readRDS("rnaFinal.rds")

#Previsões
previsaorf = predict(rfFinal, newdata = base_credit[-4])
previsaorna = predict(rnaFinal, newdata = as.h2o(base_credit[-4]))



