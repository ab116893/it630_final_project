rm(list = ls())
dir = "~/Box/DS 768 CG/Week 5/NBA Twitter/"
getwd(
)
setwd("C:/Users/Luc Ravenelle/Downloads")
Harden_Wiki = read.csv("Harden_New.csv", header=TRUE, stringsAsFactors = FALSE)

Date = as.character(Harden_Wiki$Date)
Year = substr(Date, 1, 4)
Month = substr(Date,5,6)
Day = substr(Date,7,8)

Date_new = paste(Year,Month,Day,sep="-")
Date_new = as.Date(Date_new)
Harden_Wiki$Date = Date_new

Harden_Opponent = read.csv("Harden_Opponent.csv", header=TRUE, stringsAsFactors = FALSE)
GameDate = as.character(Harden_Opponent$YYYYMMDD)
Year = substr(GameDate,1,4)
Month = substr(GameDate,5,6)
Day = substr(GameDate,7,8)
GameDate = paste(Year,Month,Day,sep="-")
GameDate = as.Date(GameDate)
Harden_Opponent$Date = GameDate
Harden_Opponent = Harden_Opponent[,-5]
Harden_Game = merge(Harden_Wiki, Harden_Opponent, by = "Date", all = TRUE)

install.packages("xts")
library(xts)
library(fpp2)
install.packages('fpp2', dependencies = TRUE)
library(forecast)
Harden_ts = ts(Harden_Wiki[,2], frequency = 365.25, start = 2016.0)
autoplot(Harden_ts)

Game_Day = Harden_Game$Wiki.pageview[!is.na(Harden_Game$Opponent)]
Off_Day = Harden_Game$Wiki.pageview[is.na(Harden_Game$Opponent)]

hist(Game_Day, col = "black")
hist(Off_Day, add = TRUE, col = "red")

plot(Game_Day)
points(Off_Day, pch = 21, col = "red")




#Moving average
MA_12 = ma(Harden_ts,12)

autoplot(Harden_ts, series="Pageviews") +
  autolayer(MA_12, series="12-MA") +
  xlab("Year") + ylab("Pageviews") +
  ggtitle("Wikipedia Pageviews (Harden) ") +
  scale_colour_manual(values=c("Pageviews"="grey","12-MA"="red"),
                      breaks=c("Pageviews","12-MA"))



#Exponential Smoothing
SES_Harden = ses(Harden_ts, h = 1)
autoplot(Harden_ts, series="Pageviews") +
  autolayer(fitted(SES_Harden), series="SES") +
  xlab("Year") + ylab("Pageviews") +
  ggtitle("Wikipedia Pageviews (Harden) ") +
  scale_colour_manual(values=c("Pageviews"="grey","SES"="red"),
                      breaks=c("Pageviews","SES"))


Hardenfc_pt5 <- ses(Harden_ts, h=5, alpha = .5)

#sqaure the residuals and total them

sum( Hardenfc_pt5$residuals^2 )

library(dplyr)
Harden_Wiki$Game_Prev_Night = lag(Harden_Wiki$Game)
Regression_Model = lm(Wiki.pageview ~ Game_Prev_Night, data = Harden_Wiki)
summary(Regression_Model)
#leave out alpha and R will give best option

Harden_fc <-ses(Harden_ts, h = 5)
Harden_fc
Harden_fc$model

sum( Harden_fc$residuals^2 )


autoplot(Harden_fc) +
  autolayer(fitted(Harden_fc), series="Fitted") +
  ylab("Wikipedia Pageviews") + xlab("Day")
Harden_ts
train = window(Harden_ts, end = 2016.91667)
test = window(Harden_ts, start = 2016.91667)

train_smooth = window(MA_12, end = 2016.91667)
test_smooth = window(MA_12, start = 2016.91667)


autoplot(train_smooth) + autolayer(test_smooth)


SES_Harden_train = ses(train, h = 30)
autoplot(train, series="raw pageviews") +
  autolayer(fitted(SES_Harden_train), series="smooth pageviews") +
  autolayer(forecast(SES_Harden_train, h = 30), series = "forecast")+
  autolayer(test, series = "raw pageviews test")+
  xlab("Year") + ylab("Pageviews") +
  ggtitle("Wikipedia Pageviews (Harden) ") +
  scale_colour_manual(values=c("smooth pageviews" = "black", "forecast"="blue", "raw pageviews"="light gray", "raw pageviews test" = "light gray" ),
                      breaks=c("smooth pageviews","forecast", "raw pageviews", "raw pageviews test"))

accuracy(SES_Harden_train, test)


ARMA = auto.arima(train)
forecast_ARMA = forecast(ARMA, h = 31) 
forecast_ARMA$mean = forecast_ARMA$mean + 1700*Harden_Wiki$Game_Prev_Night[336:366] 
forecast_ARMA$lower = forecast_ARMA$lower + 1700*Harden_Wiki$Game_Prev_Night[336:366]
forecast_ARMA$upper = forecast_ARMA$upper + 1700*Harden_Wiki$Game_Prev_Night[336:366]


autoplot(train, series="raw pageviews") +
  autolayer(fitted(SES_Harden_train), series="smooth pageviews") +
  autolayer(forecast(ARMA, h = 31), series = "forecast")+
  autolayer(test, series = "raw pageviews test")+
  xlab("Year") + ylab("Pageviews") +
  ggtitle("Wikipedia Pageviews (Harden) ") +
  scale_colour_manual(values=c("smooth pageviews" = "black", "forecast"="blue", "raw pageviews"="light gray", "raw pageviews test" = "light gray" ),
                      breaks=c("smooth pageviews","forecast", "raw pageviews", "raw pageviews test"))

ARMA
accuracy(forecast(ARMA,h=31), test)


#Final ARMA with Days off taken into account

autoplot(train, series="raw pageviews") +
  autolayer(fitted(SES_Harden_train), series="smooth pageviews") +
  autolayer(forecast_ARMA, series = "forecast")+
  autolayer(test, series = "raw pageviews test")+
  xlab("Year") + ylab("Pageviews") +
  ggtitle("Wikipedia Pageviews (Harden) ") +
  scale_colour_manual(values=c("smooth pageviews" = "black", "forecast"="blue", "raw pageviews"="light gray", "raw pageviews test" = "light gray" ),
                      breaks=c("smooth pageviews","forecast", "raw pageviews", "raw pageviews test"))

accuracy(forecast_ARMA, test)
checkresiduals(forecast_ARMA, test)

autoplot(train, series="raw pageviews") + autolayer(naive(train, h = 31)) + autolayer(test, series = "raw pageviews test")

naive_forecast = naive(train, h = 31)
res <- residuals(naive_forecast)
checkresiduals(res)
accuracy(naive_forecast, test)

