# Define UI for application

shinyUI(dashboardPage(
  dashboardHeader(title = "Healthcare Cost and Quality"),
  dashboardSidebar(
    sidebarMenu(
                h5('by Bernes Karacay', align = 'center'),
                br(),
                menuItem("Filter Data and Download", tabName = "cost", icon = icon("database")),
                menuItem("Cost vs Quality", tabName = "costquality", icon = icon("map-marked-alt"))
                
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
        selectInput("state",
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
          box(status = "primary",
              dataTableOutput("opioid_providers_table"), width = 12)
          )
       )
    ),
      tabItem(tabName = "costquality",
              h3("Cost vs Quality"),
              fluidRow(
                selectInput("state",
                            label = "State",
                            choices = states,
                            selected = "OR",
                            selectize = TRUE),
                box(
                  status = "primary", solidHeader = TRUE,width=40,
                  plotOutput("costquality", height = 500, width = 800)
                )
              )
      )
  )

))