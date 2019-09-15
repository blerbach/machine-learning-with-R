#Definindo Diretório#
setwd("C:/Users/rafae/Desktop/Ciência de Dados/4 Material de estudos/1 Curso Machine learning - Udemy")

base_credit <- read.csv("2 Bases/risco-credito.csv")
#Removendo "moderados" da classe para redução de categorias#
base_credit <- base_credit[base_credit$risco != "moderado", ]

#Criando classificador - Funções para vários modelos de regressão #
classificador <- glm(formula = base_credit$risco ~., family = binomial(), data = base_credit )

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

#Predizendo dados#
probabilidades = predict(classificador, type = 'response', newdata = data_frame)
print(previsao)

#Estabelecendo corte#
resposta = ifelse(probabilidades > 0.5, 'baixo', 'alto')






