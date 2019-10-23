setwd("C:/DAT/JESUS/UNIVERSIDAD/MASTER CUNEF/ARBOLES gender discrimination")

gender <- read.csv("http://www.biz.uiowa.edu/faculty/jledolter/DataMining/GenderDiscrimination.csv")

head(gender, 6) # comprobamos el encabezado de gender 

## # Package rpart

library(rpart)

gender.rpart1 = rpart(Gender~ Experience + Salary,data = gender, method="class")

plotcp(gender.rpart1) # permite visualizar la eficacia de la poda futura

printcp(gender.rpart1)   #UTILIZAMOS EL CP NIVEL DE COMPLEJIDAD 0.036765 (VER TABLA)  minimo error ver ejemplo es 0.77...

summary(gender.rpart1) # ofrece un resumen del proceso y de la importancia de las variables predictoras

plot(gender.rpart1, uniform = TRUE, branch=0.3)   #BRANCH ES LA APERTURA DE LA RAMA

text(gender.rpart1, use.n = TRUE, cex = 0.75)    #CEX es el tamaño de la letra


## dado que el ?rbol es deamasiado grande e incluye variables muy poco significativas, llevaremos a cabo una poda; en general 
## optaremos por un ?rbol que minimice el error de validaci?n cruzada, dado por xerror tanto en printcp() como en summary()
## Aqu?, cp=0.036765

#estimamos un nuevo arbol, con la funcion prune podamos y creamos elm nuevo arbol

gender.rpart2 = prune(gender.rpart1, cp = 0.036765)   # es el numero q hemos sacado antes de CP  (NIVEL DE COMPLEJIDAD)

plot(gender.rpart2, uniform = TRUE, branch=0.3, compress=FALSE)

text(gender.rpart2, use.n = TRUE, cex = 0.75, all=TRUE)

install.packages("rpart.plot")

library(rpart.plot)

prp(gender.rpart2, type = 2, extra = 104, fallen.leaves = TRUE, main="Decision Tree")


## Otra opci?n es emplear el c?digo siguiente, que determina autom?ticamente el cp
gender.rpart1$cptable[which.min(gender.rpart1$cptable[,"xerror"]),"CP"]

gender.rpart3 = prune(gender.rpart1, cp = 0.01833333)

plot(gender.rpart3, uniform = TRUE)
text(gender.rpart3, use.n = TRUE, cex = 0.75)
prp(gender.rpart3, type = 2, extra = 104, fallen.leaves = TRUE, main="Decision Tree")

# Se observa claramente la difrencia derivada de los decimales

##### El paquete party

## Proporciona ?rboles de regresi?n no param?trica para respuestas nominales, ordinales, num?ricas, censuradas o multivariantes.
# El crecimiento del ?rbol se basa en en reglas estad?sticas de parada, de forma que no se hace necesaria la poda

install.packages("party")
library(party)
gender.party1 = ctree(Gender~ Experience + Salary,data = gender)

plot(gender.party1, main="?rbol de inferencia condicional para Gender Discrimination")

### El paquete rpart.plot

install.packages("rpart.plot")
library(rpart.plot)

rpart.plot(gender.rpart2)
rpart.plot(gender.rpart2,box.palette="GnBu",branch.lty=3, shadow.col="gray", nn=TRUE,
           main="?rbol de clasificaci?n para Gender Discrimination usando rpart.plot")
