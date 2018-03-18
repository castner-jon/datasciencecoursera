

library(data.table)

## load in the data 
my_data <- fread("C:/Users/castnerj/Desktop/Coursera/datasciencecoursera/data/IdahoHousing.csv",
                 sep = ',',
                 header = TRUE,
                 colClasses = "character")

### number of properties worth more than $1MM 
nrow(my_data[VAL == 24,])



library(xlsx)

## load in the data 
my_data <- fread("C:/Users/castnerj/Desktop/Coursera/datasciencecoursera/data/Clean Data/Natural_Gas.xlsx",
                 sep = ',',
                 header = TRUE,
                 colClasses = "character")



library(XML)
url  <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

xml_data <- xmlParse(url, useInternalNodes = TRUE)
xml_root <- xmlRoot(xml_data)

xml_root[[1]][[1]]

xml_zipcode <- xpathSApply(xml_root, "//zipcode", xmlValue)

sum(xml_zipcode == "21231")



library(data.table)
data <- fread("C:/Users/castnerj/Desktop/Coursera/datasciencecoursera/data/Clean Data/Idaho.csv")
data[,mean(pwgtp15), by = SEX]
