getwd()
setwd("C:\Anaconda\WorkfolderPython\Final_Project")
setwd("C:/Users/Luc Ravenelle/Desktop")
library(xts)
library(fpp2)
library(forecast)

KDstats <- read.csv("KD.csv", header=TRUE, stringsAsFactors = FALSE)

year = (KDstats$year)
points = (KDstats$PTS)
assists = (KDstats$AST)
### change column header ####
fieldgoal = (KDstats$eFG)
turnover = (KDstats$TOV)




train = ts(KDstats[1:7,2])
test = ts(KDstats[8:10,2])






plot = autoplot(train) + autolayer(autoplot(test))
plot

autoplot(train, series="points train") +
  autolayer(test, series = "points test")
 

