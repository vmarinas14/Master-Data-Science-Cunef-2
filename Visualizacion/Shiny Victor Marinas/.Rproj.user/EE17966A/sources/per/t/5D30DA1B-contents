 library(shiny)
 
 shinyServer(function(input, output) {
    output$miOutputFavorito <- renderPlot({
       hist(faithful$eruptions, breaks = input$nbins)
    })
   
 })
    