# Define server logic
shinyServer(function(input, output) {

  output$opioid_providers_table <- renderDataTable({
    providers_table_data <- mymodel %>% 
      filter(`Provider State`  == input$state & `DRG Definition`  == input$procedure & `Patient Survey Star Rating` == input$quality) %>% 
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