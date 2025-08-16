# MODELAGEM DA SITUAÇÃO URBANO-RURAL DO USO E COBERTURA DA TERRA POR REGRESSÃO LOGÍSTICA: O CASO DO DISTRITO FEDERAL NO CENSO BRASILEIRO 2022

## 📢 Publicação:
[![DOI](https://img.shields.io/badge/DOI-NUMERO-blue)](https://doi.org/INSIRA_SEU_DOI_AQUI)

## 📜 Resumo:
Até o Censo 2010, a situação urbano-rural era definida por limites administrativos e legislações municipais. Para o Censo 2022, o IBGE utilizou imagens orbitais de alta resolução na predefinição da situação, que foi ajustada em campo pelos pesquisadores, integrando conhecimento empírico ao sensoriamento remoto. O presente estudo teve como objetivo modelar a situação urbano-rural a partir de categorias de uso e cobertura da terra provenientes de subprodutos de sensoriamento remoto. Tendo como área de análise o Distrito Federal, foi utilizada a regressão logística com a situação urbano-rural como variável dependente e percentuais de áreas de vegetação, agropecuária e não vegetada provenientes do MapBiomas como as variáveis independentes. O modelo desenvolvido, que teve acurácia de 97,3%, mostra que o percentual de área não vegetada tem o maior peso para a tipificação de um setor como urbano. Os resultados podem ser usados para prever a situação de áreas até a realização do próximo Censo, bem como para se planejar pesquisas amostrais em regiões que apresentam mudança no uso e cobertura da terra. O texto também discute a viabilidade de se usar aspectos do ambiente para previsão, em contraponto às práticas que tradicionalmente se valem de aspectos sociais para a definição da situação urbano-rural.

## 📂 Estrutura do Repositório:
```bash
├── data/     # Dados utilizados
├── scripts/  # Scripts R
├── figs/     # Figuras
└── doc/      # Documentos
```

## ⚙️ Requisitos e Como Usar:
- Software: R (versão 4.x.x)
- Pacotes: tidyr, ggplot2, GGally, pscl, caret, pROC
- Passo a passo: 
```bash
# 1. Clonar este repositório
git clone https://github.com/daciocambraia/artigo-regressao-logistica-urbano-rural
cd repositorio

# 2. Executar o script principal
Rscript scripts/01_artigo.R
```

## ✏️ Citação:
### ABNT
PEREIRA, G. G.; CAMBRAIA-FILHO, D. J.; PAIM, D. A.; GANDARA, R. M.; BAPTISTA, G. M. M. **Modelagem da situação urbano-rural do uso e cobertura da terra por regressão logística: o caso do Distrito Federal no Censo Brasileiro de 2022**. *Caminhos da Geografia*, v. X, n. Y, p. XX-YY, 2025.

### BibTeX
```bibtex
@article{
  title = {Modelagem da situação urbano-rural do uso e cobertura da terra por regressão logística: o caso do Distrito Federal no Censo Brasileiro de 2022},
  author = {Pereira, G. G. and Cambraia-Filho, D. J.; Paim, D. A.; Gandara, R. M.; Baptista, G. M. M.},
  journal = {Caminhos da Geografia},
  year = {2025},
  volume = {},
  number = {},
  pages = {},
  doi = {},
  url = {INSIRA_O_LINK_DO_ARTIGO}
}
```

## 👥 Autores:
- **Glaucia Guimarães Pereira**
[![Email](https://img.shields.io/badge/Email-glauciagp23@gmail.com-blue?style=flat&logo=gmail)](mailto:glauciagp23@gmail.com)

- **Dácio José Cambraia Filho**
[![Email](https://img.shields.io/badge/Email-daciocambraia@hotmail.com-blue?style=flat&logo=gmail)](mailto:daciocambraia@hotmail.com)
  
- **Diego de Almeida Paim**
[![Email](https://img.shields.io/badge/Email-diego.paim@aluno.unb.br-blue?style=flat&logo=gmail)](mailto:diego.paim@aluno.unb.br)

- **Roberto Mandetta Gandara**
[![Email](https://img.shields.io/badge/Email-rgandara@gmail.com-blue?style=flat&logo=gmail)](mailto:rgandara@gmail.com)

- **Gustavo Macedo de Mello Baptista**
[![Email](https://img.shields.io/badge/Email-gmbaptista@unb.br-blue?style=flat&logo=gmail)](mailto:gmbaptista@unb.br)

## 📊 Fonte de dados:
- **Malha de Setores Censitários (2022)**
[![IBGE](https://img.shields.io/badge/Link-IBGE-blue?logo=data:image/png;base64,...)](https://www.ibge.gov.br/geociencias/organizacao-do-territorio/malhas-territoriais/26565-malhas-de-setores-censitarios-divisoes-intramunicipais.html)

- **MapBiomas Coleção 9**
[![MapBiomas](https://img.shields.io/badge/Link-MapBiomas-green?logo=leaf)](https://brasil.mapbiomas.org/)