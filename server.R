# Define server logic
shinyServer(function(input, output) {

    df<-eventReactive(c(input$state,input$procedure,input$quality),ignoreInit=TRUE,{
      if (input$quality != "All") { 
        mymodel %>% 
        filter(`Provider State`  == input$state & `DRG Definition`  == input$procedure & `Patient Survey Star Rating` == input$quality )
      }else{
        mymodel %>% 
          filter(`Provider State`  == input$state & `DRG Definition`  == input$procedure)
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
  
  

})

