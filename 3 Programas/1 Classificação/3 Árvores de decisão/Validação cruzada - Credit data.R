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

# Carregando pacote
library(caret)

resultados30 = c()

#Definindo parâmetros da validação cruzada
controle_treinamento = trainControl(method = "repeatedcv", number = 10, repeats = 30)

#Sem necessidade dos testes
#Criando Modelo
modelo = train(default ~., data = base_credit, trControl = controle_treinamento, method = "rf" )

# Guardando precisão
precisao <- modelo$results$Accuracy[2]







