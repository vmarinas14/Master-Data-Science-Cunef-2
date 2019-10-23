#Usando el dataset economics y economics_wide (mirad ambos) de ggplot2 crea:

# 1) en un fichero llamado apartado1.R una gráfica con una línea temporal representando 
# la variable "unemploy" (tiempo = eje X)

library(ggplot2)

economics



ggplot(economics,aes(x=date, y=unemploy)) + geom_line(color="cyan")



#otros tipos de graficos....(para practicar)


ggplot(economics,aes(x=date, y=unemploy)) + geom_point()

ggplot(economics,aes(x=date, y=unemploy)) + geom_area()

ggplot(economics,aes(x=date, y=unemploy)) + geom_col()



       