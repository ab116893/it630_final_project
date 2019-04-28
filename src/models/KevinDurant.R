getwd()
setwd("C:\Anaconda\WorkfolderPython\Final_Project")
setwd("C:/Users/Luc Ravenelle/Desktop")
library(xts)
library(fpp2)
library(forecast)

KDstats <- read.csv("duranke.csv", header=TRUE, stringsAsFactors = FALSE)

year = (KDstats$year)
points = (KDstats$PTS)
assists = (KDstats$AST)

fieldgoal = (KDstats$eFG)
turnover = (KDstats$TOV)


##### single time series #######

KD_ts = ts(KDstats[,31], frequency = 365.25, start = 2007)
KD_ts

#Unable to split into test and train
KD_train = subset(KD_ts, start = 2007, end = 2014) 
KD_test = window(goog, start = 2015, end = 2018)

autoplot(KD_ts)


###### two seperate time series ###

#Doesnt recognize that they should be combined
train = ts(KDstats[1:9,31])
test = ts(KDstats[10:12,31])
train
test

autoplot(train, series="points train") +
  autolayer(test, series = "points test")
 

