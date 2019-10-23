# 4) en apartado4.R evita el overplotting del anterior ejercicio usando transparencia

faithful

ggplot(faithful, aes(x=eruptions, y=waiting)) +
  geom_point(aes(colour="waiting",alpha = 0.2))
