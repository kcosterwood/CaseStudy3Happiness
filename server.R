
function(input, output, session) {
 
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    happy[, c(input$xcol, input$ycol)]

  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  output$plot1 <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
    
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })
  # Discover Data
  
 
  # Regression
  
  selectedData2 <- reactive({
    happy_w[, c(input$xcol2, input$ycol2)]
  })
  recipe_formula <- reactive({
  req(input$xcol2)
  happy_w %>%
    recipe() %>%
   update_role(!!!input$xcol2, new_role = "outcome") %>%
   update_role(!!!input$ycol2, new_role = "predictor") %>%
    prep() %>% 
     formula()
  })
  
   lm_reg <- reactive(
    lm(recipe_formula(),data=happy_w)
  )
  
  output$RegOut = renderPrint({
   summary(lm_reg())
  })
  

  output$plot2 <- renderPlot({
     # Create regression line
    output$regline <- renderPlotly({
      ggplotly({
        ggplot(data = happy_w, aes_string(x = input$xcol2, y = input$ycol2)) +
          geom_point()+theme_minimal() +
          geom_smooth(method='lm')+theme_minimal()
      })
    })
    # Create regression plots
    output$regplots <- renderPlot({
      x <- happy_w %>% pull(input$xcol2)
      y <- happy_w %>% pull(input$ycol2)
      par(mfrow=c(2,2))
      plot(lm(y ~ x, data = happy_w))
      
    })
    
  })
    

  
  #Region color explore
  selectedData3 <- reactive({
    happy_w[, c(input$xcol3, input$ycol3)]
  })
  
  output$plot3 <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3","#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999", "#0096FF"))
    
     par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData3(),
        col = factor(happy2$"Regional indicator"),
       pch = 20, cex = 3)
    legend("topleft", legend = regions,
          fill = c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3","#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999", "#0096FF"),
         border = "black")
    
  })
}




  