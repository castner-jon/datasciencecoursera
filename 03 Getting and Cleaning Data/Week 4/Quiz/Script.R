
setwd("C:/Users/castnerj/Desktop/Coursera/datasciencecoursera/03 Getting and Cleaning Data/Week 4/Quiz")

library(tidyverse)

### Question 1 
data <- read_csv("ss06hid.csv")

names <- names(data)
strsplit(names, "wgtp")[123]


### Question 2
data2 <- read_csv("GDP.csv", col_names = FALSE)

A <- function(x) {gsub(",", "", x)}
data2$X5 <- as.numeric(lapply(data2$X5, A))

data2.subset <- filter(data2, !is.na(as.numeric(X2)))
mean(data2.subset$X5, na.rm = TRUE)


### Question 3
grep("^United", data2$X4)


### Question 4
GDP     <- read_csv("GDP.csv", col_names = FALSE)
EdStats <- read_csv("EDSTATS_Country.csv", col_names = TRUE)

rows <- grep("^Fiscal(.*)[Jj]une", EdStats$`Special Notes`)
EdStates.subset <- EdStats[rows,]

nrow(inner_join(x = EdStates.subset, y = GDP, by = c("CountryCode" = "X1")))


### Question 5
library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN", auto.assign=FALSE)
sampleTimes = index(amzn)

sum(year(sampleTimes) == 2012)


