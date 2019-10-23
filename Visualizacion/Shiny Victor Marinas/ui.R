library(shiny)

#HAY QUE PONERLO SIEMPRE AUNQ NO HACE NADA, ES EL "PADRE"(shinyUI)
shinyUI(
  fluidPage(
    titlePanel("Old Faithful Geyser Data"),
    sidebarLayout(
      sidebarPanel(
        sliderInput("nbins", label= "Numero de agrupaciones",
                    min = 1, max = 100, value = 10 ) #el nombre tiene que ser supersimple, no tildes 
      ),
      mainPanel(
        plotOutput("miOutputFavorito")
      )
    )
  )
)
 
