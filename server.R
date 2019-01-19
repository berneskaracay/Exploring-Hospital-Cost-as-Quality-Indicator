# Define server logic
shinyServer(function(input, output) {

    df<-eventReactive(c(input$cost_state,input$cost_procedure,input$cost_quality),ignoreInit=TRUE,{
      if (input$cost_quality != "All") { 
        mymodel %>% 
        filter(`Provider State`  == input$cost_state & `DRG Definition`  == input$cost_procedure & `Patient Survey Star Rating` == input$cost_quality )
      }else{
        mymodel %>% 
          filter(`Provider State`  == input$cost_state & `DRG Definition`  == input$cost_procedure)
      }
    })
  
    usadf<-eventReactive(c(input$cost_procedure,input$cost_quality),ignoreInit=TRUE,{
      if (input$cost_quality != "All") { 
        mymodel %>% 
          filter(`DRG Definition`  == input$cost_procedure & `Patient Survey Star Rating` == input$cost_quality )
      }else{
        mymodel %>% 
          filter(`DRG Definition`  == input$cost_procedure)
      }
    })
 ####ggplot   
    ggplotdf<-eventReactive((input$costquality_procedure),ignoreInit=TRUE,{
        mymodel %>% 
          filter(`DRG Definition`  == input$costquality_procedure,!is.na(`Patient Survey Star Rating`))
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
      filter(!is.na(`Patient Survey Star Rating`) & `DRG Definition`  == input$costquality_procedure )%>% 
      ggplot(
        aes(x = `Average Medicare Payments`, y = `Patient Survey Star Rating`)
      ) +
      geom_point(
        size = 2
      ) + 
      geom_smooth(method=lm, se=FALSE)+
      labs(y = 'Quality', x  = 'Cost in $') + 
      coord_flip() +
      theme(axis.text.x = element_text(hjust = 1), legend.position = 'none',text = element_text(size=20)) 
    
  })
  
  
  output$mean <- renderValueBox({
    
    # filter providers dataset by state and year
    
    # create a line plot from filtered state data
    valueBox(formatC(mean(usadf()$`Average Medicare Payments`, na.rm=T), digits = 0, format = "f"),
             subtitle = "USA Mean Cost of Medical Procedure")
  })
  
  output$correlation <- renderValueBox({
    
    # filter providers dataset by state and year
    
    # create a line plot from filtered state data
    valueBox(formatC(cor(ggplotdf()$`Average Medicare Payments`, ggplotdf()$`Patient Survey Star Rating`,  method = "pearson", use = "complete.obs"), digits = 3, format = "f"),
             subtitle = "USA Correlation Between Cost and Quality")
  })
  
  

  
  
  
  
  output$plot <- renderPlotly({
    data<-mymodel %>% 
      filter(`DRG Definition` == input$map_procedure)%>% group_by(state_names)%>% 
      mutate(mean1=mean(`Average Medicare Payments`, na.rm = TRUE))%>% select(state_names, mean1)%>%unique()
   
    data$state_names<-as.factor(data$state_names)

    state_names<-data[,1]
    mean1<-data[,2]
    
    
    usdata <- data.frame(state_names, mean1)
    states1 <- as.vector(states$`Provider State`)
    states2 <- as.vector(state_names$state_names)
    for (i in states1) {
      if(i %nin% states2){
        temp <- c(i,0)
        usdata <- rbind(usdata, temp)
      } 
    }
    
    
    

    #l <- list(color = toRGB("white"), width = 2)
    g <- list(
      scope = 'usa'
    )
    plot_geo(data, locationmode = 'USA-states') %>%
      add_trace(
        z = ~ mean1, locations = ~state_names, colors= 'Purples'
      ) %>%
      colorbar(title = "Mean Cost \nPer State") %>%
      layout(
        geo = g)
    
    
  })
  

})

