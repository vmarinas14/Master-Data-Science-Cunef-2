# 2) en un fichero llamado apartado2.R una gráfica con todas las variables 
# con líneas de distintos colores a lo largo del tiempo (tiempo = eje X)

library(ggplot2)

economics

economics_long



ggplot(economics,aes(x=date))+
  geom_line(aes(y=pce, color="pce"))+
  geom_line(aes(y=pop, color= "pop"))+
  geom_line(aes(y=psavert, color="psavert" ))+
  geom_line(aes(y=uempmed, color="uempmed"))+
  geom_line(aes(y=unemploy, color ="unemploy"))




ggplot(economics_long,aes(x = date, y = value01))+ geom_line(aes(color=variable))

  
  


