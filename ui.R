# Define UI for application

shinyUI(dashboardPage(
  dashboardHeader(title = "Healthcare Cost and Quality"),
  dashboardSidebar(
    sidebarMenu(
                h5('by Bernes Karacay', align = 'center'),
                br(),
                menuItem("Filter Data and Download", tabName = "cost", icon = icon("database")),
                menuItem("Cost vs Quality", tabName = "costquality", icon = icon("map-marked-alt")),
                menuItem("Us Map", tabName = "mapstate", icon = icon("map-marked-alt"))
                
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "cost",
        h3("Select inputs below to filter dashboard."),
        selectInput("quality",
                    label = "Quality",
                    choices= quality,
                    selected = 4),
        selectInput("cost_state",
                    label = "State",
                    choices = states,
                    selected = "TN",
                    selectize = TRUE),
        selectInput("procedure",
                    label = "Medical Procedure",
                    choices = procedure,
                    selected = "101 - SEIZURES W/O MCC",
                    selectize = TRUE),
        uiOutput("secondSelection"),
        # First tab content
        fluidRow(
          column(width = 10,
                 valueBoxOutput("mean"))
        ),
      
        fluidRow(
          box(
              status = "primary",
              dataTableOutput("opioid_providers_table"), width = 12)
          )
       ),
 
      tabItem(tabName = "costquality",
              h3("Cost vs Quality"),
              selectInput("costquality_state",
                          label = "State",
                          choices = states,
                          selected = "TN",
                          selectize = TRUE),
              selectInput("costquality_procedure",
                          label = "Procedure",
                          choices = procedure,
                          selected = "101 - SEIZURES W/O MCC",
                          selectize = TRUE),
              fluidRow(
                column(width = 10,
                       valueBoxOutput("correlation"))
              ),
              
              fluidRow(
                box(
                  status = "primary", solidHeader = TRUE,width=40,
                  plotOutput("costquality", height = 500, width = 800)
                )
              )
      ),
      tabItem(tabName = "mapstate",
              h3("Cost vs Quality"),
              selectInput("map_procedure",
                          label = "Medical Procedure",
                          choices = procedure,
                          selected = "101 - SEIZURES W/O MCC",
                          selectize = TRUE),
              fluidRow(
                box(title ='Mean Cost per State', status = 'primary',solidHeader = T,plotlyOutput("plot", height = 600, width=800),width=10)
              )
      )
    )
  )

))