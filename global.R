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
library(shinydashboard)
library(tidyverse)
library(ggplot2)

library(scales)
library(shinythemes)
library(plotly)
mymodel <- readRDS("data/mymodel.rds")
#mymodel<-subset(mymodel,!is.na(mymodel$`Patient Survey Star Rating`))

mymodel$state_names=mymodel$`Provider State`

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