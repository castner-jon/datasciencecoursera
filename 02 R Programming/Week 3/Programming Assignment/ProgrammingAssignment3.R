
## read in the data 

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

head(outcome)
class(outcome)
str(outcome)
dim(outcome)
colnames(outcome)


## histogram of mortality rates from heart attacks

outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)


