
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
###MEDICARE################
medicare <- read_csv("data/Medicare_Provider_Charge_Inpatient_DRGALL_FY2016.csv")
######################Cost string to cost in integer############################
medicare$`Average Total Payments`<-str_remove_all(medicare$`Average Total Payments`, "[,]")
medicare$`Average Total Payments`<-as.numeric(gsub("\\$","",medicare$`Average Total Payments`))

medicare$`Average Covered Charges`<-str_remove_all(medicare$`Average Covered Charges`, "[,]")
medicare$`Average Covered Charges`<-as.numeric(gsub("\\$","",medicare$`Average Covered Charges`))


medicare$`Average Medicare Payments`<-str_remove_all(medicare$`Average Medicare Payments`, "[,]")
medicare$`Average Medicare Payments`<-as.numeric(gsub("\\$","",medicare$`Average Medicare Payments`))

medicare_var<-c("Provider Id" ,"Provider Name","Provider State", "Provider Zip Code","Provider City","Average Medicare Payments","DRG Definition")
medicare_sub<- medicare[medicare_var]

best_options<-medicare %>% 
  group_by(`Provider State`, `DRG Definition`) %>% 
  slice(which.min(`Average Medicare Payments`))

###QUALITY################
quality <- read_csv("data/HCAHPS - Hospital.csv")
quality$`Patient Survey Star Rating`<- as.numeric(quality$`Patient Survey Star Rating`)
quality<-subset(quality,!is.na(`Patient Survey Star Rating`))
quality<-subset(quality,`HCAHPS Measure ID`=="H_STAR_RATING")

quality_var<-c("Patient Survey Star Rating","Provider ID")
quality_ranks<-quality[quality_var]


####merge quality and price###################

model_data <- merge(x=quality_ranks, y=medicare_sub, by.x=c("Provider ID"),by.y=c("Provider Id"), all.y=TRUE)
