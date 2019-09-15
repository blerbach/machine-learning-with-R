#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy/2 Bases")

#Importando a Base#
base_credit <- read.csv("credit-data.csv")

#Dropando variável ID Cliente#
base_credit$clientid <- NULL

#Estatística descritiva da base#
summary(base_credit)

#Mostrando idades negativas#
base_credit[base_credit$age < 0 & !is.na(base_credit$age), ] #Mostrando no Console#
idade_invalida <- base_credit[base_credit$age < 0 & !is.na(base_credit$age), ] #Atribuindo uma base#

####################################################
#Corrigindo inconsistências - 4 maneiras diferentes#
####################################################

## Tipo 1 - Dropar toda a coluna (Recomendando apenas para grande número de inconsitências na variável)
base_credit <- base_credit$agr <- NULL

## Tipo 2 - Dropar somente observações com inconsistências
base_credit <- base_credit[base_credit$age > 0, ]

## Tipo 3 - Preencher dados manualmente

## Tipo 4 - Preencher os dados com a média da variável
mean(base_credit$age[base_credit$age > 0], na.rm = TRUE) #Observando a média com ausência de missings e negativos

###Preenchendo idades negativas com a média da variável
base_credit$age <- ifelse(base_credit$age < 0, mean(base_credit$age[base_credit$age > 0], na.rm = TRUE), base_credit$age)

###Preenchendo missings da idade com a média da variável
base_credit$age <- ifelse(is.na(base_credit$age), mean(base_credit$age, na.rm = TRUE), base_credit$age)

#Conferindo novamente as estatísticas descritivas#
summary(base_credit)

#########################
#ESCALONAMENTO DOS DADOS#
#########################

##Por padronização
base_credit[,1:3] <- scale(base_credit[,1:3])

#instalando pacote com funções para machine learning#
#install.packages("caTools")
library("caTools")

#Definindo proporções das bases de teste e aprendizagem#
set.seed(1)
divisao <- sample.split(base_credit$default, SplitRatio = 0.75) #75% da base para aprendizagem

#Definindo base de treinamento#
base_treinamento <- subset(base_credit, divisao == TRUE )

#Definindo base de teste#
base_teste <- subset(base_credit, divisao == FALSE )




