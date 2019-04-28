rm(list = ls())
library(fpp2)


Question_2 = ts(c(10,13,11,7,12,15,13,10,16,20,18,15), start = c(2015,1), frequency = 4)
autoplot(Question_2)


#Question 1

Question_2 = ts(c(10,13,11,7,12,15,13,10,16,20,18,15), start = c(2015,1), frequency = 4)
autoplot(Question_2)


#naive
naive(Question_2, 4)
autoplot(naive(Question_2, 4))

#snaive
snaive(Question_2, 4)
autoplot(snaive(Question_2, 4))

#average
meanf(Question_2, 4)
autoplot(meanf(Question_2, 4))

#drift
rwf(Question_2, 4, drift = TRUE)
autoplot(rwf(Question_2, 4, drift = TRUE))




#Question 2


drift = rwf(Question_2, h = 4, drift = TRUE)
fitted(drift)
residuals(drift)
res = residuals(drift)

mean(res, na.rm = TRUE)
var(res, na.rm = TRUE)

autoplot(Question_2) + autolayer(fitted(drift))


#Question 3

#3.a Done in Excel

#Question 4

l1 = lag(Question_2, k = 1)
l2 = lag(Question_2, k = 2)
plot(Question_2, l1, type = "x")
plot(Question_2, l2, type = "x")

cor(Question_2[1:11], Question_2[2:12])
cor(Question_2[1:10], Question_2[3:12])

ggAcf(Question_2)


#Question 5

#Done on excel

#Question 6

library(fpp2)
goog_train = subset(goog, start = 1, end = 900) 
goog_test = window(goog, start = 901, end = 1000)

autoplot(goog_train, series = "Training") +
  autolayer(goog_test, series = "Test") + 
  xlab("Day") + ylab("Closing Price ($)") + 
  ggtitle("Google stock price (daily ending 12/6/2013)") + 
  guides(colour = guide_legend(title="Forecast"))


Naive_goog = naive(goog, h = 100)
Mean_goog = meanf(goog, h = 100)
Drift_goog = rwf(goog, h = 100, drift = TRUE)

autoplot(goog)+
  autolayer(Naive_goog, PI = FALSE, series = "Naive") +
  autolayer(Mean_goog, PI = FALSE, series = "Average") +
  autolayer(Drift_goog, PI = FALSE, series = "Drift") +
  xlab("Day") + ylab("Closing Price ($)") + 
  ggtitle("Google stock price (daily ending 12/6/2013)") + 
  guides(colour = guide_legend(title="Forecast"))

#Question 7

checkresiduals(Mean_goog)

#Question 8

accuracy(Naive_goog)
accuracy(Mean_goog)
accuracy(Drift_goog)






