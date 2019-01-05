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


states <- as.data.frame(mymodel) %>% 
  select(`Provider State`) %>% 
  unique()

quality <- as.data.frame(mymodel) %>% 
  select(`Patient Survey Star Rating`) %>% 
  unique()

procedure <- as.data.frame(mymodel) %>% 
  select(`DRG Definition`) %>% 
  unique()
