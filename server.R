# Define server logic
shinyServer(function(input, output) {

    df<-eventReactive(c(input$cost_state,input$procedure,input$quality),ignoreInit=TRUE,{
      if (input$quality != "All") { 
        mymodel %>% 
        filter(`Provider State`  == input$cost_state & `DRG Definition`  == input$procedure & `Patient Survey Star Rating` == input$quality )
      }else{
        mymodel %>% 
          filter(`Provider State`  == input$cost_state & `DRG Definition`  == input$procedure)
      }
    })
  

  
  output$secondSelection <- renderUI({
    max_value<-max(df()$`Average Medicare Payments`,na.rm=TRUE)
    min_value<-min(df()$`Average Medicare Payments`,na.rm=TRUE)
    sliderInput("range","Cost Range",
                min = min_value,
                max = max_value,
                value = c(min,max))
  })

  output$opioid_providers_table <- renderDataTable({
    providers_table_data <- df()%>% 
      filter(`Average Medicare Payments`>=input$range[1] & `Average Medicare Payments`<=input$range[2])%>%
      select( `Provider Name`,`Provider State`,`Provider City`, `DRG Definition`, `Patient Survey Star Rating`, `Average Medicare Payments`       
      ) %>% 
      arrange(desc(`Provider Name`))
  }, rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip', 
                                                              buttons = list('copy', 'print', list(
                                                                extend = 'collection',
                                                                buttons = c('csv', 'excel', 'pdf'),
                                                                text = 'Download'
                                                              ))))
  
  
  
  output$costquality <- renderPlot({
    
    # create plot from filtered data
    mymodel %>% 
      filter(`Provider State`  == input$costquality_state & !is.na(`Patient Survey Star Rating`))%>% 
      ggplot(
        aes(x = `Average Medicare Payments`, y = `Patient Survey Star Rating`)
      ) +
      geom_point(
        size = 1
      ) +
      labs(y = 'Quality', x  = element_blank()) + 
      coord_flip() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = 'none', axis.title.x = element_blank()) 
    
  })
  
  
  output$mean <- renderValueBox({
    
    # filter providers dataset by state and year
    state_data <-  mymodel %>% 
      filter(`Provider State`  == input$costquality_state & !is.na(`Patient Survey Star Rating`))%>% 
    
    # create a line plot from filtered state data
    valueBox(formatC(mean(state_data$`Average Medicare Payments`), digits = 1, format = "f"),
             subtitle = "Mean cost of Medical Procedure")
  })
  

})

