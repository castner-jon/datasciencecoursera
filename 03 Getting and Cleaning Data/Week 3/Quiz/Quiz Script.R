
setwd("C:/Users/castnerj/Desktop/Coursera/datasciencecoursera/03 Getting and Cleaning Data/Week 3/Quiz")

library(tidyverse)
library(jpeg)

### Question 1
idaho <- read_csv("ss06hid.csv")

agricultureLogical <- idaho$ACR == 3 & idaho$AGS == 6
which(agricultureLogical)

### Question 2
pic <- readJPEG("jeff.jpg", native = TRUE)
quantile(pic, prob = seq(0, 1, .1))

### Question 3
Country <- read_csv("EDSTATS_Country.csv") 

GDP <- read_csv("GDP.csv", skip = 4) %>%
  select(X1, X2, X4, X5)

colnames(GDP) <- c("country", "ranking", "economy", "dollars")

GDP <- GDP[!is.na(GDP$country), ]

inner_join(GDP, Country, by = c("country" = "CountryCode"))
View(arrange(GDP, desc(as.numeric(ranking))))

### Question 4
inner_join(GDP, Country, by = c("country" = "CountryCode"), copy = TRUE) %>%
  group_by(`Income Group`) %>%
  summarize(avg = mean(as.numeric(ranking), na.rm = TRUE))

### Question 5
q5 <- inner_join(GDP, Country, by = c("country" = "CountryCode"), copy = TRUE) %>%
  mutate(GDP_Rank = cut(as.numeric(ranking), 
                        breaks = quantile(as.numeric(ranking),
                                          probs = seq(0, 1, .2),
                                          na.rm = TRUE)))

table(q5$`Income Group`, q5$GDP_Rank)


