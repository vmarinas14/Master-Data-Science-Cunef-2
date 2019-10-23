setwd("C:/DAT/JESUS/UNIVERSIDAD/MASTER CUNEF/ARBOLES BREAST CANCER")
# Wisconsin Breast Cancer dataset
# La base de datos contiene 699 casos donde 458 (65.5%) son benignos y 241 (34.5%) malignos.

library(party)
library(partykit)

# Preparamos la base de datos

loc <- "http://archive.ics.uci.edu/ml/machine-learning-databases/"

ds <- "breast-cancer-wisconsin/breast-cancer-wisconsin.data"

url <- paste(loc, ds, sep="")

# Denominamos breast al data frame original

breast <- read.table(url, sep=",", header=FALSE, na.strings="?")

# Asignamos nombres a las variables

names(breast) <- c("ID", "clumpThickness", "sizeUniformity",
                   "shapeUniformity", "maginalAdhesion",
                   "singleEpithelialCellSize", "bareNuclei",
                   "blandChromatin", "normalNucleoli", "mitosis", "class")

# Creamos un nuevo data frame df, eliminando la variable ID

df <- breast[-1]

summary(df)   # vemos los NA y si es factor o son numeros

# Transformamos la variable class en un factor, cuyos valores son 
# 2=benigno y 4=maligno

df$class <- factor(df$class, levels=c(2,4),
                   labels=c("benigno", "maligno"))

# Semilla aleatoria

set.seed(1234)

# Definimos una muestra aleatoria de aprendizaje del arbol

train <- sample(nrow(df), 0.7*nrow(df))    #calcula valores aleatorios

# Data frame para la muestra de aprendizaje y otro para la muestra de validaci?n

df.train <- df[train,]

df.validate <- df[-train,]

# Vemos la distribucion de ambas muestras y comprobamos que est?n balanceadas

table(df.train$class)

table(df.validate$class)

# Cargamos la libreria rpart

library(rpart)

# Estimamos el arbol

arbol <- rpart(class ~ ., data=df.train, method="class",
               parms=list(split="information"))

print(arbol)

summary(arbol)

# Tabla de complejidad param?trica

arbol$cptable

# Representamos gr?ficamente la curva cp

plotcp(arbol)

# Podamos el arbol a partir del p?rametro de complejidad

arbol.podado <- prune(arbol, cp=.01764706)

# Cargamos la librer?a para representar graficamente el ?rbol

library(rpart.plot)

prp(arbol.podado, type = 2, extra = 104,
    fallen.leaves = TRUE, main="Decision Tree")

#?prp para ver las distintas opciones de la representaci?n gr?fica del arbol
#type=2 explicita la etiquetas de divisi?n debajo de cada nodo
#extra=104 incluye las probabilidades de cada clase junto con el porcentaje de casos en cada nodo
#fallen.leaves=TRUE dibuja los nodos terminales en la parte inferior del arbol

# Prediccion con la muestra de validaci?n

arbol.pred <- predict(arbol.podado, df.validate, type="class")

arbol.perf <- table(df.validate$class, arbol.pred,
                    dnn=c("Actual", "Predicted"))

arbol.perf

install.packages("partykit")

library(partykit)

plot(as.party(arbol.podado))

# ARBOLES BASADOS EN LA INFERENCIA. CONDITIONAL INFERENCE TREE

install.packages("party")

library(party)

fit.ctree <- ctree(class~., data=df.train)

plot(fit.ctree, main="Conditional Inference Tree")

ctree.pred <- predict(fit.ctree, df.validate, type="response")

ctree.perf <- table(df.validate$class, ctree.pred,
                    dnn=c("Actual", "Predicted"))

ctree.perf
