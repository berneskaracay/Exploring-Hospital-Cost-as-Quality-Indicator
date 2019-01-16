rm(list=ls())

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
setwd("C:/Users/karacb1/Desktop/Medicare-Inpatient-Charge")

mymodel <- readRDS("data/mymodel.rds")
#mymodel<-subset(mymodel,!is.na(mymodel$`Patient Survey Star Rating`))

#mymodel$state_names=abbr2state(mymodel$`Provider State`)
mymodel$state_names=mymodel$`Provider State`
states <- mymodel %>% 
  select(state_names) %>% 
  distinct()%>% 
  arrange(`Provider State`)

quality <- mymodel %>% 
  select(`Patient Survey Star Rating`) %>% 
  distinct()%>% 
  arrange((`Patient Survey Star Rating`))

quality <- rbind(quality, "All")

procedure <- as.data.frame(mymodel) %>% 
  select(`DRG Definition`) %>% 
  distinct()%>% 
  arrange((`DRG Definition`))



usdata<-mymodel %>% 
  filter(`DRG Definition` == "101 - SEIZURES W/O MCC")%>% group_by(state_names)%>% 
  mutate(mean1=mean(`Average Medicare Payments`, na.rm = TRUE))%>% select(state_names, mean1)%>%unique()

#usdata<-subset(usdata,state_names %nin% "DC")

#usdata$state_names<-paste0("US-",usdata$state_names)

usdata$state_names<-as.factor(usdata$state_names)
state_names<-usdata[,1]
mean1<-usdata[,2]


usdata <- data.frame(state_names, mean1)

#l <- list(color = toRGB("white"), width = 2)
g <- list(
  scope = 'usa'
)
plot_geo(usdata, locationmode = 'USA-states') %>%
  add_trace(
    z = ~ mean1, locations  = ~state_names, colors= 'Purples'
  ) %>%
  colorbar(title = "") %>%
  layout(
    geo = g)















