#Ejercicio vino

setwd("C:/DAT/JESUS/UNIVERSIDAD/MASTER CUNEF/DISCRIMINANTE Clasificación vino G=3")

library(car)

install.packages('rattle')

library(rattle)

data(wine, package='rattle')



head(wine)

scatterplotMatrix(wine[2:6])
scatterplotMatrix(wine[7:14])

# El objetivo que perseguimos en este ejemplo de LDA es hallar combinaciones lineales de las variables originales
# (los 13 compuestos químicos) que ofrezcan la major separación posible entre los grupos (variedades de vino) 
# Si queremos separar los vinos por varietal, debemos considerar los tres grupos que hay (G=3) y las 13 variables (p=13); como 
# sabemos, el número máximo de funciones discriminantes válidas es el menor entre G-1 y p, luego aquí tendremos 2 funciones
# discriminantes. 
# Emplearemos la función lda del package MASS

library(MASS)

wine.lda <- lda(Type ~ ., data=wine)

# Para conocer los valores de las cargas de las funciones de las funciones discriminantes, escribimos:

wine.lda

# Así, la 1ª función discriminante es una CL de las variables: -0.403*Alcohol+0.165*Malic ... -0.003*Proline
# Los valores de cada función discriminante están estandarizados (media cero y varianza unitaria) 
# La "proportion of trace" expresada al ejecutar "wine.lda" (la variable que devuelve la función lda() ) es el tanto por ciento
# de separación que consigue cada función discriminante; en este caso, 68.75% y 31.25% por cada una de ellas.


## Una histograma apilado de los valores generados
# Una forma interesante de observar los resultados del LDA es mediante un histograma apilado de los valores de la función 
# discriminante en las muestras de los distintos grupos (aquí, las variedades de vino).
# Lo podemos llevar a cabo mediante la función "ldahist()"

wine.lda.values <- predict(wine.lda)

ldahist(data = wine.lda.values$x[,1], g=wine$Type)

# La 2ª función discriminante separa asimismo entre variedades, y también podemos llevar a cabo el histograma de los valores
# de esta 2ª función:

ldahist(data = wine.lda.values$x[,2], g=wine$Type)


##Scatterplots de las funciones Discriminantes

#para representar el gráfico de dispersión de las dos mejores funciones discriminantes, con los puntos etiquetados por variedad,
# haremos lo siguiente: 

plot(wine.lda.values$x[,1],wine.lda.values$x[,2]) # Hacer el scatterplot
text(wine.lda.values$x[,1],wine.lda.values$x[,2],wine$Type,cex=0.7,pos=4,col="red") # añadir etiquetas

#A partir del gráfico de dispersión de las dos primeras funciones, podemos observar que los vinos de las 
# distintas variedades están bastante bien separadas en el gráfico. La primera función discriminante (eje x) separa muy bien las
# variedades 1 y 3, y no tanto las variedades 1 y 2 ó 2 y 3.

# La segunda función discriminante (eje y) consigue una buena separación, sin ser pefecta, de las variedades 1 y 2 ó 2 y 3,
# y muy deficiente de la 1 y la 3.
#Para conseguir una buena discriminación de las tres variedades es necesario emplear las dos funciones.

# CONTINUAR CON LAS PREDICCIONES

table(predict(wine.lda)$class, wine$Type)
predict(wine.lda,newdata=data.frame(Alcohol=13,Malic=2, Ash=2.3,Alcalinity=18, Magnesium=100, Phenols=2.3,
                                    Flavanoids=2,Nonflavanoids=0.4,Proanthocyanins=1.5,Color=4, Hue=1, Dilution=2.5, Proline=520))$class 
