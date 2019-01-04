
library(Hmisc)
library(rms)
library(MASS)
library(survival)
library(plyr)
library(tidyverse)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(reshape2)

library(Hmisc)
library(rms)
library(MASS)
library(stargazer)
library(sjPlot)
library(sjmisc)
library(sjlabelled)
library(labelled)
library(foreign)
library(tree)
library(randomForest)
library(ppcor)
library(rms)
library(plotly)
require(gridExtra)
library(readxl)
library("xtable")

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


setwd("C:/Users/karacb1/Desktop/Medicare-Inpatient-Charge")
medicare <- read_csv("data/Medicare_Provider_Charge_Inpatient_DRGALL_FY2016.csv")
######################Cost string to cost in integer############################
medicare$`Average Total Payments`<-str_remove_all(medicare$`Average Total Payments`, "[,]")
medicare$`Average Total Payments`<-as.numeric(gsub("\\$","",medicare$`Average Total Payments`))

medicare$`Average Covered Charges`<-str_remove_all(medicare$`Average Covered Charges`, "[,]")
medicare$`Average Covered Charges`<-as.numeric(gsub("\\$","",medicare$`Average Covered Charges`))


medicare$`Average Medicare Payments`<-str_remove_all(medicare$`Average Medicare Payments`, "[,]")
medicare$`Average Medicare Payments`<-as.numeric(gsub("\\$","",medicare$`Average Medicare Payments`))


best_options<-medicare %>% 
  group_by(`Provider State`, `DRG Definition`) %>% 
  slice(which.min(`Average Medicare Payments`))


