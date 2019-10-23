#Ejercicio German Credit



## Lectura de datos

credit <- read.csv("http://www.biz.uiowa.edu/faculty/jledolter/DataMining/germancredit.csv")


# Para ver los detalles del fichero germancredit.csv 
# Visualizamos las dos primeras filas

head(credit,2) 

#Sólo las variables "duration", "amount", "installment" y "age" son numéricas. 
#con el resto siendo indicadores, la asunción de normalidad es sobre ellos imposible; así pues no las consideramos aquí
# installment:  cantidad de dinero pagada por unidad de tiempo o cuota de devolución por unidad de tiempo

cred1=credit[, c("Default","duration","amount","installment","age")]

head(cred1)

summary(cred1)

#¿Siguen una distribución normal? Chequeemos los histogramas

hist(cred1$duration)
hist(cred1$amount)
hist(cred1$installment)
hist(cred1$age)


# Transformamos los datos seleccionados en un data.frame para llevara a cabo el LDA

cred1=data.frame(cred1)

#Visualizamos la matriz de dispersión múltiple de las variables métricas

library(car) #Companion to Applied Regression; 

#Functions and Datasets to Accompany J. Fox and S. Weisberg, An R Companion to Applied Regression, Second Edition, Sage, 2011.

scatterplotMatrix(cred1[2:5])

#Los datos no soportan la asunción de normalidad requerida por el LDA, de forma que habrá problemas
#con el empleo del LDA o incluso del QDA; en todo caso veamos qué ocurre si tratamos de predecir la clasificación
#empleando las funciones discriminantes

library(MASS) 

## LDA: proporciones de clase del conjunto de entrenamiento empleadas como probabilidades a priori

zlin=lda(Default~.,cred1)

# Matriz de Confusión: tabla de contingencia entre la asignación real y la asignación por LDA

table(predict(zlin)$class, cred1$Default)

# Predicción por LDA de una nueva observación:

predict(zlin,newdata=data.frame(duration=6,amount=1100,installment=4,age=67))

predict(zlin,newdata=data.frame(duration=6,amount=1100, installment=4,age=67))$class 

## QDA: las proporciones de clase del conjunto de entrenamiento se emplean como probabilidades a priori.

zqua=qda(Default~.,cred1)

# Matriz de Confusión:

table(predict(zqua)$class, cred1$Default)

# Predicciones del QDA para una nueva observación:

predict(zqua,newdata=data.frame(duration=6,amount=1100,installment=4,age=67))

predict(zqua,newdata=data.frame(duration=6,amount=1100, installment=4,age=67))$class


#El rendimiento del modelo no es muy bueno; compararemos el LDA / QDA con métodos más sofisticados como los 
# árboles de decisión o las redes neuronales.