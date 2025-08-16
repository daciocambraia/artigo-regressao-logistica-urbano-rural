# ----- BIBLIOTECAS ------------------------------------------------------------

library(readxl)
library(tidyr)
library(ggplot2)
library(GGally)
library(pscl)
library(caret)
library(pROC)

# ----- LEITURA DE DADOS -------------------------------------------------------

dados <- read_excel("data/setor_mapbiomas_30m.xlsx")
summary(dados)

# ----- PREPARAÇÃO DE DADOS ----------------------------------------------------

# Selecionar variáveis de interesse
dados_filtrados <- dados[, c("SITUACAO_2", "PER2_NAOVEG", "PER2_AGRO", "PER2_VEG", "PER2_FLO")]

# Converrte colunas para números
dados_filtrados <- apply(dados_filtrados, 2, as.numeric)
dados_filtrados <- data.frame(dados_filtrados)

# Converte variável resposta para fator (0 = Rural, 1 = Urbana)
dados_filtrados$SITUACAO_2 <- as.factor(dados_filtrados$SITUACAO_2)

# Renomeia variáveis
colnames(dados_filtrados)[2:5] <- c("Não Vegetada", "Agropecuária", "Vegetação", "Floresta")

# ----- ANÁLISE EXPLORATÓRIA ---------------------------------------------------

# Funções para gráficos
custom_diag <- function(data, mapping, ...) {
  ggplot(data = data, mapping = mapping) +
    geom_density(
      aes(fill = as.factor(data$SITUACAO_2)),
      color = "black",
      linewidth = 0.2
    ) +
    scale_y_continuous(limits = c(0, 10), breaks = seq(0, 10, by = 5)) +
    scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.5))
}

custom_points <- function(data, mapping, ...) {
  ggplot(data = data, mapping = mapping) +
    geom_point(size = 1) +
    scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.5)) +
    scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.5))
}

# Figura 1
fig_01 <- ggpairs(
  dados_filtrados,
  aes(color = as.factor(SITUACAO_2)),
  columns = 2:5,
  upper = list(continuous = wrap("cor", size = 4)),  
  lower = list(continuous = custom_points),
  diag = list(continuous = custom_diag),
  legend = 1
) +
  scale_color_manual(
    values = c("0" = "#ffa500", "1" = "#999999"),
    name = "",
    labels = c("0" = "Rural", "1" = "Urbana")
  ) +
  scale_fill_manual(
    values = c("0" = "#ffa500", "1" = "#999999"),
    name = "",
    labels = c("0" = "Rural", "1" = "Urbana")
  ) +
  theme_bw() +
  theme(
    legend.position = "top",
    legend.box = "horizontal",
    panel.grid = element_blank()
  )

print(fig_01)

# Salvar Figura 1
ggsave("figs/01_analise_exploratoria.png", plot = fig_01, width = 8, height = 5, dpi = 600)

# ----- MODELAGEM - REGRESSÃO LOGÍSTICA ----------------------------------------

# Seleciona variáveis do modelo
dados2 <- dados[, c("SITUACAO_2", "PER2_NAOVEG", "PER2_AGRO", "PER2_VEG")]

# Converte para numérico
dados2 <- apply(dados2, 2, as.numeric)
dados2 <- data.frame(dados2)

# Divisão em treino/teste (80/20)
set.seed(1)
tr <- round(0.8 * nrow(dados2))
treino <- sample(nrow(dados2), tr, replace = FALSE)
dados2.treino <- dados2[treino, ]
dados2.teste <- dados2[-treino, ]

# Modelagem (treino)
mod_treino <- glm(
  SITUACAO_2 ~ PER2_NAOVEG + PER2_AGRO + PER2_VEG, 
  family = binomial, 
  data = dados2.treino)

# Resumo do modelo (treino)
summary(mod_treino)

# Pseudo R2 (treino)
pR2(mod_treino)

# Equação (treino)
eq <- paste0("logit(p) = ", round(coef(mod_treino)[1], 4), " + ", 
             paste0(round(coef(mod_treino)[-1], 4), " * X", 1:length(coef(mod_treino)[-1]), collapse = " + "))
print(eq)

# ----- AVALIAÇÃO DO MODELO ----------------------------------------------------

# Probabilidade no conjunto de teste
prob_teste <- predict(mod_treino, type = "response", newdata = data.frame(
  PER2_NAOVEG = dados2.teste$PER2_NAOVEG,
  PER2_AGRO = dados2.teste$PER2_AGRO,
  PER2_VEG = dados2.teste$PER2_VEG))

# Classificação binária (threshold = 0,5)
pred_teste <- ifelse(prob_teste > 0.5, 1, 0)

# Matriz de confusão
confusionMatrix(as.factor(pred_teste), as.factor(dados2.teste$SITUACAO_2))

# Curva ROC + AUC
roc_teste <- roc(dados2.teste$SITUACAO_2, prob_teste)

cat("AUC: ", auc(roc_teste), "\n")

# Figura 2
fig_02 <- ggroc(roc_teste) +
  ggtitle("Curva ROC") +
  theme_minimal() +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "red")

plot(fig_02)

# Salvar Figura 02
ggsave("figs/02_curva_hoc_auc.png", plot = fig_02, width = 8, height = 5, dpi = 600)

# ----- VISUALIZAÇÃO DAS RELAÇÕES ------------------------------------------------

# Restrutura dos dados para gráficos
dados2.teste$SITUACAO_2 <- as.numeric(as.character(dados2.teste$SITUACAO_2))

colnames(dados2.teste)[2:4] <- c("Área Não Vegetada", "Agropecuária", "Vegetação")

dados2.teste_long <- dados2.teste %>%
  pivot_longer(cols = c('Área Não Vegetada', 'Agropecuária', 'Vegetação'),
               names_to = "Variavel",
               values_to = "Valor")

# Figura 3
fig_03 <- ggplot(dados2.teste_long, aes(x = Valor, y = SITUACAO_2, color = Variavel)) +
  geom_point(alpha = 0.1) +
  geom_smooth(method = "glm", method.args = list(family = "binomial"), size = 1.25) +
  labs(x = "Variáveis", y = "Situação - Probabilidade de ser urbana", color = "Tipo de Variável") +  # Nome da legenda
  theme_bw() +
  scale_color_manual(
    values = c("Área Não Vegetada" = "#d4271e", "Agropecuária" = "#ffefc3", "Vegetação" = "#d6bc74"),
    breaks = c("Área Não Vegetada", "Agropecuária", "Vegetação")  # Ordem que você quer na legenda
  )

plot(fig_03)

# Salvar Figura 03
ggsave("figs/03_curva_regressao.png", plot = fig_03, width = 8, height = 5, dpi = 600)