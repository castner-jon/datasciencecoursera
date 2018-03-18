
## libraries
library(tidyverse)

## read in the data
data <- read_csv("C:/Users/castnerj/desktop/coursera/datasciencecoursera/data/quiz1_data/hw1_data.csv")

str(data)
head(data)
tail(data)

data[47,]

missing <- !complete.cases(data)
data[missing,]

summary(data)

summary(filter(data, Ozone > 31 & Temp > 90))

summary(filter(data, Month == 6))

summary(filter(data, Month == 5))
