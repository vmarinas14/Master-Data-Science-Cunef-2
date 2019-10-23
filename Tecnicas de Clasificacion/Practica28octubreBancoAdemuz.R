#Ejercicio Banco Ademuz

#Introduccion de datos

x=c(1.3,3.7,5.0,5.9,7.1,4.0,7.9,5.1,5.2,9.8,9.0,12.0,6.3,8.7,11.1,9.9)
z=c(4.1,6.9,3.0,6.5,5.4,2.7,7.6,3.8,1.0,4.2,4.8,2.0,5.2,1.1,4.1,1.6)
class=c("F","F","F","F","F","F","F","F","NF","NF","NF","NF","NF","NF","NF","NF")

#Dar forma al data.frame

datos=data.frame(x=x,z=z,class=class)
datos

#medias de las dos variables para las poblaciones I y II (Fallidos y No fallidos)

mediaF=c(mean(datos$x[1:8]),mean(datos$z[1:8]))
mediaF
mediaNF=c(mean(datos$x[9:16]),mean(datos$z[9:16]))
mediaNF
#Le damos forma de matriz a los vectores de medias anteriores

mediaF=matrix(mediaF,nrow=2)
mediaNF=matrix(mediaNF,nrow=2)

#Calculamos la matriz de varianzas-covarianzas muestrales de cada población

VarF=matrix(c(var(datos$x[1:8]),cov(datos$x[1:8],datos$z[1:8]),cov(datos$x[1:8],datos$z[1:8]),var(datos$z[1:8])), 2)
VarNF=matrix(c(var(datos$x[9:16]),cov(datos$x[9:16],datos$z[9:16]),cov(datos$x[9:16],datos$z[9:16]),var(datos$z[9:16])), 2)

#Suponemos que la matriz de varianzas-covarianzas es igual en ambas poblaciones
#Estimamos dicha matriz a partir de las matrices de varianzas-covarianzas muestrales de ambas poblaciones

Var=(8*VarF+8*VarNF)/14

#Calculamos el vector alfa

iVar=solve(Var)
alfa=iVar%*%(mediaNF-mediaF)
D1=t(alfa)%*%mediaF
D2=t(alfa)%*%mediaNF
C=(D1+D2)/2
C=c(C)

#Ahora calcularemos las puntuaciones de la funcion discriminante de Fisher para todos los individuos de la muestra

dat=as.matrix(datos[,1:2], ncol=2)
pred=dat%*%alfa
datos$pred=c(pred)
datos$clasi=ifelse(datos$pred<C,1,2)
table(datos$class,datos$clasi)

#Utilizando la función lda de MASS

library(gmodels)
library(MASS)
datos2=data.frame(x=x,z=z,class=class)
fit=lda(data=datos2, datos2$class~datos2$x+datos2$z)
fit.p=predict(fit)
fit.p=predict(fit)$class
datos2=data.frame(datos2,fit.p)
CrossTable(datos2$class,datos2$fit.p, digits=2, format="SPSS", prop.c=FALSE, prop.chisq=FALSE, prop.t=FALSE, dnn=c("Grupo real", "Grupo pronosticado"))

# Test de Wilks de igualdad de medias
fit.manova=manova(data=datos2, cbind(datos2$x,datos2$z)~datos2$class)
summary(fit.manova,test="Wilks")

