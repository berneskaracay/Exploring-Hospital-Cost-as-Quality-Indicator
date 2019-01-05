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

mymodel <- readRDS("data/mymodel.rds")
mymodel<-subset(mymodel,!is.na(mymodel$`Patient Survey Star Rating`))


states <- as.data.frame(mymodel) %>% 
  select(`Provider State`) %>% 
  distinct()%>% 
  arrange((`Provider State`))

quality <- as.data.frame(mymodel) %>% 
  select(`Patient Survey Star Rating`) %>% 
  distinct()%>% 
  arrange((`Patient Survey Star Rating`))

procedure <- as.data.frame(mymodel) %>% 
  select(`DRG Definition`) %>% 
  distinct()%>% 
  arrange((`DRG Definition`))
