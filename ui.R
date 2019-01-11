# Define UI for application

shinyUI(dashboardPage(
  dashboardHeader(title = "Healthcare Cost Dashboard"),
  dashboardSidebar(
    sidebarMenu(
                h5('by Bernes Karacay', align = 'center'),
                br(),
                menuItem("Filter Data and Download", tabName = "cost", icon = icon("database")),
                menuItem("Connecticut", tabName = "ct", icon = icon("database"))
                
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
    )
  )
))