##### ARBOLES DE DECISIÓN ########

## lOS AD son convenientes en presencia de clasificación discreta, los AR cuando hay la variable de respuesta es métrica.

## caso 1. Determinación de la probabilidad de que un asegurado dé un parte de accidente.
# Origen: base de datos pública australiana con 67.856 registros de asegurados de los que 4.264 habían dado al menos un parte.
# Ver las características del archivo en el car.txt correspondiente.

# Primera aproximación: librería rpart
# Es la más popular de CART, viene en el base de R

setwd("C:/DAT/JESUS/UNIVERSIDAD/MASTER CUNEF/ARBOLES CAR")
library(rpart)
car.df = read.csv("car.csv")
head(car.df)
summary(car.df)
car.rpart = rpart(clm ~ veh_value + veh_body + veh_age + gender + area + agecat,method="class", data = car.df) 

#donde clm, "claims", es la variable a predecir y el resto son las predictoras


printcp(car.rpart) # revisa los  resultados
plotcp(car.rpart) # visualiza los resultados de la validación cruzada
summary(car.rpart) # resumen detallado de los cortes

# como podemos ver, el procedimiento no funciona, debido al desequilibrio ("imbalance") entre los dos grupos: el grupo con
# partes representa sólo el 6.8% del total.
