# 
# Unicode:UTF8  --- es tu amigo, (enconding mas internacional)
# si tenemos algun problema con el csv , por tildes etc  
#Reopen with encoding

library("ggplot2")  #cargamos ggplot2

mpg
mtcars

#sirve para no cargar la libreria
ggplot2::aes

#ggpolt(datos, aes= estetica)

ggplot(mpg, aes(class)) + geom_bar()
#encima del grafico exportar grafico, en varios formatos....

miFuncion<- function(calamar) {calamar +2}

miFuncion(calamar=5)  # podriamos poner miFuncion(5)  , calamar es 2, 2+5=7

ggplot(mpg, aes(class)) + geom_point()   #no sale nada


#ejercicio 2 

ggplot(mpg, aes(x=class, y=displ)) + geom_point()


#ej 3

ggplot(mpg, aes(x= cty, y=displ, size=hwy, color=class)) + geom_point()


#otro ejemplo con color (azul) en geom_point
ggplot(mpg, aes(x= cty, y=displ, size=hwy, color=class)) + geom_point(color="blue")



ggplot(mpg, aes(x= cty, size= hwy)) + 
  geom_bar(fill="grey") +
  geom_point(aes(y= displ,color= class, size= hwy))



#FACE  dividir la grafica en facetas


ggplot(mpg, aes(x= cty, y=displ))+
  geom_point()+
  facet_grid(.~year)


#estilado,, no es importante



#importante ggplot ESTADISTICAS




ggplot(mpg, aes(x= cty, y=displ)) + geom_density2d()

ggplot(mpg, aes(x= cty, y=displ)) + geom_hex()


#para guardar algo, y luego mostrarlo

base<- ggplot(mpg,aes(x=cty,y=displ))

base +
  geom_hex()

base + 
  geom_density2d()


base +
  stat_smooth()

base +
  stat_smooth(method = "lm")




## Plot.ly


mi_grafica<-ggplot(mpg, aes(x= cty, size= hwy)) + 
  geom_bar(fill="grey") +
  geom_point(aes(y= displ,color= class, size= hwy))

ggplotly(mi_grafica)
 






