# Define UI for application

shinyUI(dashboardPage(
  dashboardHeader(title = "Healthcare Cost Dashboard"),
  dashboardSidebar(tags$blockquote("Select inputs below to filter dashboard."),
                   selectInput("quality",
                               label = "Quality",
                               choices = quality,
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
                   uiOutput("secondSelection")

),
  
  dashboardBody(
    fluidRow(
      box(title = "Healthcare provider list", status = "primary",
          dataTableOutput("opioid_providers_table"), width = 12)
    )
  ))
)