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


KD_ts = ts(KDstats[,31], frequency = 365.25, start = 2007)
KD_ts

autoplot(KD_ts)


train = ts(KDstats[1:9,31])
test = ts(KDstats[10:12,31])
train





plot = autoplot(train) + autolayer(autoplot(test))
plot

autoplot(train, series="points train") +
  autolayer(test, series = "points test")
 

