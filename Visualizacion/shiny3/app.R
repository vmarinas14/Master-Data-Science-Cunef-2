#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("50 leereles"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("size", label = "Tamaño muestral", min = 5, max = 500, value = 42 ),
            selectInput("distribucion", label = "Distribucion",
                        choices = list("Gaussiana" = "norm", "Uniforme" = "unif"),
                        selected = "norm"),
            actionButton("pintar",label = "Cobrar 50 leereles")

        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        input$pintar
        rdistribucion <- ifelse(isolate(input$distribucion) == "norm", rnorm,runif)
        
        hist(rdistribucion(isolate(input$size))) 
      
    })
}
 
# Run the application 
shinyApp(ui = ui, server = server)
