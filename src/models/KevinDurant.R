getwd()
setwd("C:\Anaconda\WorkfolderPython\Final_Project")
setwd("C:/Users/Luc Ravenelle/Desktop")
library(xts)
library(fpp2)
library(forecast)

stats <- read.csv("duranke.csv", header=TRUE, stringsAsFactors = FALSE)

year = (stats$year)
points = (stats$PTS)
assists = (stats$AST)

fieldgoal = (stats$eFG)
turnover = (stats$TOV)

year <- readline("What is the year you want to start from?")  


##### single time series #######

ts = ts(stats[,31], frequency = 1, start = year)
ts

######## Drift method and Naive Method #########
train = window(ts, start = 2007, end = 2014) 
test = window(ts, start = 2014, end = 2019)

Drift = rwf(train, h = 5, drift = TRUE)
Naive = naive(train, h = 5)


autoplot(train, series="points train") +
  autolayer(test, series = "points test") +
  autolayer(Drift, PI = FALSE, series = "Drift") +
  autolayer(Naive, PI = FALSE, series = "Naive")

accuracy(Drift)
accuracy(Naive)


######## Predict Next Year ############

Drift_2020 = rwf(train, h = 6, drift = TRUE)
Naive_2020 = naive(train, h = 6)


autoplot(train, series="points train") +
  autolayer(test, series = "points test") +
  autolayer(Drift_KD2020, PI = FALSE, series = "Drift") +
  autolayer(Naive_KD2020, PI = FALSE, series = "Naive")

accuracy(Drift_KD)
accuracy(Naive_KD)


