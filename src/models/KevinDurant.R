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

KD_ts = ts(KDstats[,31], frequency = 1, start = 2007)
KD_ts

######## Drift method and Naive Method #########
KD_train = window(KD_ts, start = 2007, end = 2014) 
KD_test = window(KD_ts, start = 2014, end = 2019)

Drift_KD = rwf(KD_train, h = 5, drift = TRUE)
Naive_KD = naive(KD_train, h = 5)


autoplot(KD_train, series="points train") +
  autolayer(KD_test, series = "points test") +
  autolayer(Drift_KD, PI = FALSE, series = "Drift") +
  autolayer(Naive_KD, PI = FALSE, series = "Naive")

accuracy(Drift_KD)
accuracy(Naive_KD)


######## Predict Next Year ############

Drift_KD2020 = rwf(KD_train, h = 6, drift = TRUE)
Naive_KD2020 = naive(KD_train, h = 6)


autoplot(KD_train, series="points train") +
  autolayer(KD_test, series = "points test") +
  autolayer(Drift_KD2020, PI = FALSE, series = "Drift") +
  autolayer(Naive_KD2020, PI = FALSE, series = "Naive")

accuracy(Drift_KD)
accuracy(Naive_KD)


