
library(tidyverse)
library(sqldf)
library(XML)

setwd("C:/Users/castnerj/Desktop/Coursera/datasciencecoursera/03 Getting and Cleaning Data/Week 2/Quiz")

### Question 2
acs <- read_csv("ss06pid.csv")

sqldf("select PWGTP from acs where AGEP < 50")

### Question 3 
length(unique(acs$AGEP))

nrow(sqldf("select distinct AGEP from acs"))

### Question 4  
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
html <- readLines(connection)
close(connection)

nchar(html[10])
nchar(html[20])
nchar(html[30])
nchar(html[100])

### Question 5 
mydata <- read_fwf(file = "wksst8110.for",
                   skip = 4,
                   fwf_widths(c(12, 7, 4, 9, 4, 9, 4, 9, 4)))

sum(mydata[, 4])



