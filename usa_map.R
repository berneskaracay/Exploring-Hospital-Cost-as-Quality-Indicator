library(plyr)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(maps)
library(ggthemes)
library(mapproj)
library(gridExtra)
library(reshape2)
library(stargazer)
#library(sjPlot)
library(sjmisc)
library(sjlabelled)
library(labelled)
library(readxl)
library(shinydashboard)

library(tidyverse)
library(DT)
library(ggthemes)
library(mapproj)
library(shinydashboard)
library(openintro)
library(plotly)

mymodel <- readRDS("data/mymodel.rds")
#mymodel<-subset(mymodel,!is.na(mymodel$`Patient Survey Star Rating`))

mymodel$state_names=abbr2state(mymodel$`Provider State`)
states <- as.data.frame(mymodel) %>% 
  select(`Provider State`) %>% 
  distinct()%>% 
  arrange((`Provider State`))

quality <- mymodel %>% 
  select(`Patient Survey Star Rating`) %>% 
  distinct()%>% 
  arrange((`Patient Survey Star Rating`))

quality <- rbind(quality, "All")

procedure <- as.data.frame(mymodel) %>% 
  select(`DRG Definition`) %>% 
  distinct()%>% 
  arrange((`DRG Definition`))



data<-mymodel %>% 
  filter(`DRG Definition` == "101 - SEIZURES W/O MCC")%>% group_by(state_names)%>% 
  mutate(mean1=mean(`Average Medicare Payments`, na.rm = TRUE))%>% select(state_names, mean1)%>%unique()



l <- list(color = toRGB("white"), width = 2)
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = FALSE,
  lakecolor = toRGB('white')
)
plot_geo(data, locationmode = 'USA-states') %>%
  add_trace(
    z = ~ mean1, locations = ~state_names, zmin = 0, zmax =100000,
    colors = 'Reds'
  ) %>%
  colorbar(title = "Mean Cost \nPer State") %>%
  layout(
    geo = g)



library(plotly)
df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2011_us_ag_exports.csv")
df$hover <- with(df, paste(state, '<br>', "Beef", beef, "Dairy", dairy, "<br>",
                           "Fruits", total.fruits, "Veggies", total.veggies,
                           "<br>", "Wheat", wheat, "Corn", corn))
# give state boundaries a white border
l <- list(color = toRGB("white"), width = 2)
# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

p <- plot_geo(df, locationmode = 'USA-states') %>%
  add_trace(
    z = ~total.exports, text = ~hover, locations = ~code,
    color = ~total.exports, colors = 'Purples'
  ) %>%
  colorbar(title = "Millions USD") %>%
  layout(
    title = '2011 US Agriculture Exports by State<br>(Hover for breakdown)',
    geo = g
  )

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
p
