getwd()
setwd("C:/Users/Luc Ravenelle/Desktop/it630_final_project/data/raw")
library(xts)
library(fpp2)
library(forecast)

##########################################################################################
####                                    READ ME                                       ####
####                                                                                  ####
#### Run which CSv file you would like to find stat predictions and forecast accuracy ####
####                          for each player specified                               ####
####                                                                                  ####
####                duranke.csv -> Career stats for Kevin Durant                      ####
####                curryst.csv -> Career stats for Steph Curry                       ####
####                hardeja.csv -> career stats for James Harden                      ####
##########################################################################################


stats <- read.csv("duranke.csv", header=TRUE, stringsAsFactors = FALSE)
stats <- read.csv("curryst.csv", header=TRUE, stringsAsFactors = FALSE)
stats <- read.csv("hardeja.csv", header=TRUE, stringsAsFactors = FALSE)


points = (stats$PTS)
assists = (stats$AST)
fieldgoal = (stats$eFG)
turnover = (stats$TOV)


######################################## PTS #############################################

##### single time series #######

ts = ts(points, frequency = 1, start = 2009)

######### Split into Train and Test ###########

train = window(ts, start = 2009, end = 2015) 
test = window(ts, start = 2015, end = 2018)

######## Drift method and Naive Method #########

Drift = rwf(train, h = 3, drift = TRUE)
Naive = naive(train, h = 3)


autoplot(train, series="Training Set") +
  autolayer(test, series = "Test Set") +
  autolayer(Drift, PI = FALSE, series = "Drift Forecast") +
  autolayer(Naive, PI = FALSE, series = "Naive Forecast") +
  xlab("Year") + ylab("Points per Game") + 
  ggtitle("Points per Game AVG Year by Year") + 
  guides(colour = guide_legend(title="Forecast"))

# accuracy #
accuracy(Drift)
accuracy(Naive)


######## Predict Next Year ############

Drift_2020 = rwf(train, h = 4, drift = TRUE)
Naive_2020 = naive(train, h = 4)



autoplot(train, series="Training Set") +
  autolayer(test, series = "Test Set") +
  autolayer(Drift_2020, PI = FALSE, series = "Drift Forecast") +
  autolayer(Naive_2020, PI = FALSE, series = "Naive Forecast") +
  xlab("Year") + ylab("Points per Game") + 
  ggtitle("Points per Game AVG Year by Year") + 
  guides(colour = guide_legend(title="Forecast"))

# accuracy #
accuracy(Drift_2020)
accuracy(Naive_2020)

# The MAPE is not less than 10% of the mean of f(x) #


########################################## AST ###########################################

##### single time series #######

tsAST = ts(assists, frequency = 1, start = 2009)

######### Split into Train and Test ###########

trainAST = window(tsAST, start = 2009, end = 2015) 
testAST = window(tsAST, start = 2015, end = 2018)

######## Drift method and Naive Method #########

DriftAST = rwf(trainAST, h = 3, drift = TRUE)
NaiveAST = naive(trainAST, h = 3)


autoplot(trainAST, series="Training Set") +
  autolayer(testAST, series = "Test Set") +
  autolayer(DriftAST, PI = FALSE, series = "Drift Forecast") +
  autolayer(NaiveAST, PI = FALSE, series = "Naive Forecast") +
  xlab("Year") + ylab("Assists per Game") + 
  ggtitle("Assists per Game AVG Year by Year") + 
  guides(colour = guide_legend(title="Forecast"))

# accuracy #
accuracy(DriftAST)
accuracy(NaiveAST)

######## Predict Next Year ############

DriftAST_2020 = rwf(trainAST, h = 4, drift = TRUE)
NaiveAST_2020 = naive(trainAST, h = 4)



autoplot(trainAST, series="Training Set") +
  autolayer(testAST, series = "Test Set") +
  autolayer(DriftAST_2020, PI = FALSE, series = "Drift Forecast") +
  autolayer(NaiveAST_2020, PI = FALSE, series = "Naive Forecast") +
  xlab("Year") + ylab("Assists per Game") + 
  ggtitle("Assists per Game AVG Year by Year") + 
  guides(colour = guide_legend(title="Forecast"))

# accuracy #
accuracy(DriftAST_2020)
accuracy(NaiveAST_2020)

# The MAPE is not less than 10% of the mean of f(x) #

######################################## eFG% ############################################

##### single time series #######

tsFG = ts(fieldgoal, frequency = 1, start = 2009)

######### Split into Train and Test ###########

trainFG = window(tsFG, start = 2009, end = 2015) 
testFG = window(tsFG, start = 2015, end = 2018)

######## Drift method and Naive Method #########

DriftFG = rwf(trainFG, h = 3, drift = TRUE)
NaiveFG = naive(trainFG, h = 3)


autoplot(trainFG, series="Training Set") +
  autolayer(testFG, series = "Test Set") +
  autolayer(DriftFG, PI = FALSE, series = "Drift Forecast") +
  autolayer(NaiveFG, PI = FALSE, series = "Naive Forecast") +
  xlab("Year") + ylab("Adjusted Field Goal Percentage") + 
  ggtitle("Adjusted Field Goal Percentage Year by Year") + 
  guides(colour = guide_legend(title="Forecast"))

# accuracy #
accuracy(DriftFG)
accuracy(NaiveFG)

######## Predict Next Year ############

DriftFG_2020 = rwf(trainFG, h = 4, drift = TRUE)
NaiveFG_2020 = naive(trainFG, h = 4)



autoplot(trainFG, series="Training Set") +
  autolayer(testFG, series = "Test Set") +
  autolayer(DriftFG_2020, PI = FALSE, series = "Drift Forecast") +
  autolayer(NaiveFG_2020, PI = FALSE, series = "Naive Forecast") +
  xlab("Year") + ylab("Adjusted Field Goal Percentage") + 
  ggtitle("Adjusted Field Goal Percentage Year by Year") + 
  guides(colour = guide_legend(title="Forecast"))

# accuracy #
accuracy(DriftFG_2020)
accuracy(NaiveFG_2020)

# The MAPE is not less than 10% of the mean of f(x) #

#################################### TOV ##################################################

##### single time series #######

tsTOV = ts(turnover, frequency = 1, start = 2009)

######### Split into Train and Test ###########

trainTOV = window(tsTOV, start = 2009, end = 2015) 
testTOV = window(tsTOV, start = 2015, end = 2018)

######## Drift method and Naive Method #########

DriftTOV = rwf(trainTOV, h = 3, drift = TRUE)
NaiveTOV = naive(trainTOV, h = 3)


autoplot(trainTOV, series="Training Set") +
  autolayer(testTOV, series = "Test Set") +
  autolayer(DriftTOV, PI = FALSE, series = "Drift Forecast") +
  autolayer(NaiveTOV, PI = FALSE, series = "Naive Forecast") +
  xlab("Year") + ylab("Turnovers per Game") + 
  ggtitle("Turnover AVG by Game Year by Year") + 
  guides(colour = guide_legend(title="Forecast"))

# accuracy #
accuracy(Drift)
accuracy(Naive)

######## Predict Next Year ############

DriftTOV_2020 = rwf(trainTOV, h = 4, drift = TRUE)
NaiveTOV_2020 = naive(trainTOV, h = 4)



autoplot(trainTOV, series="Training Set") +
  autolayer(testTOV, series = "Test Set") +
  autolayer(DriftTOV_2020, PI = FALSE, series = "Drift Forecast") +
  autolayer(NaiveTOV_2020, PI = FALSE, series = "Naive Forecast") +
  xlab("Year") + ylab("Turnovers per Game") + 
  ggtitle("Turnover AVG by Game Year by Year") + 
  guides(colour = guide_legend(title="Forecast"))

# accuracy #
accuracy(DriftTOV_2020)
accuracy(NaiveTOV_2020)

# The MAPE is not less than 10% of the mean of f(x) #

