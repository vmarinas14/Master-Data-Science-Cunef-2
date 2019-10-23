library(shiny)
library(ggplot2)
shinyServer(function(input, output) {
  output$texto1 <- renderText({
    paste0("Este es el grafico de :", input$variableX," x ",input$variableY)
  })
  output$grafica <- renderPlot({
    ggplot(mpg, aes_string(x= input$variableX, y=input$variableY)) +
      geom_point()
  })
 
  
})
 