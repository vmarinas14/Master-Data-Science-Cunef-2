library(shiny)

#HAY QUE PONERLO SIEMPRE AUNQ NO HACE NADA, ES EL "PADRE"(shinyUI)
shinyUI(
  fluidPage(
    titlePanel("Marina´s S.L.U"),
    sidebarLayout(
      sidebarPanel(
        selectInput("variableX", label = h3("Elige la variable X"),
                    choices = list("Tamaño Motor" = "displ",
                                   "Cilindrada" = "cyl",
                                   "Consumo en autopista" = "hwy",
                                   "Consumo en ciudad" = "cty"),
                    selected = "displ"),
        selectInput("variableY", label = h3("Elige la variable Y"),
                    choices = list("Tamaño Motor" = "displ",
                                   "Cilindrada" = "cyl",
                                   "Consumo en autopista" = "hwy",
                                   "Consumo en ciudad" = "cty"),
                    selected = "displ")
      ),
      mainPanel(
        textOutput("texto1"),
        plotOutput("grafica")
      )
    )
  )
)

 