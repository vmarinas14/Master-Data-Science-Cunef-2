#Ejercicio con craneos del Tibet

#Forma lenta, abajo forma rápida

craneos<-read.table("~/Desktop/craneos.txt", header=FALSE, sep="", na.strings="NA", dec=".", 
           strip.white=TRUE)


#Eliminamos la primera variable, pues es el orden de los individuos de la muestra

craneos=craneos[-1]
#Damos nombre a las variables
colnames(craneos) <- c("Longitud","Anchura", "Altura","Altura.Cara", "Anchura.Cara","Tipo")
#Incluimos en el directorio de trabajo las variables del data frame
attach(craneos)
#Calculamos las medias para cada uno de los tipos
m1 <- apply(craneos[Tipo==1,-6],2,mean)
m2 <- apply(craneos[Tipo==2,-6],2,mean)
l1 <- length(Tipo[Tipo==1])
l2 <- length(Tipo[Tipo==2])
#Marco de datos para cada tipo
x1 <- craneos[Tipo==1,-6]
x2 <- craneos[Tipo==2,-6]

#Estimacion de la matriz de varianzas-covarianzs
S123 <- ((l1-1)*var(x1)+(l2-1)*var(x2))/(l1+l2-2)
#Contraste de medias para comprobar si las medias son diferentes de manera significativa o no
T2 <- t(m1-m2)%*%solve(S123)%*%(m1-m2)
Fstat <- (l1*l2/(l1+l2))*(l1+l2-5-1)*T2/(l1+l2-2)*5
pvalue <- 1-pf(Fstat,5,26)
Fstat
pvalue

#Estimación del vector alfa
alfa=solve(S123)%*%(m1-m2)
z1=m1%*%alfa
z2=m2%*%alfa
z1
z2
C=(z1+z2)/2

#Clasificacion de individuos
x1=as.matrix(x1)
x2=as.matrix(x2)
proy1=x1%*%alfa
proy2=x2%*%alfa
y1=vector(mode="numeric",length(proy1));for(i in 1:length(proy1)){if (proy1[i]>C) y1[i]=1 else y1[i]=0}
sum(y1)/length(y1)
y2=vector(mode="numeric",length(proy2));for(i in 1:length(proy2)){if (proy2[i]<C) y2[i]=1 else y2[i]=0}
sum(y2)/length(y2)

# Se carga la libreria MASS
library(MASS)
# Se hace un analisis discriminante lineal
disc <- lda(Tipo ~ Longitud + Anchura + Altura + Altura.Cara
            + Anchura.Cara, data=craneos)
table(predict(disc)$class, Tipo)


