
## Write a function named 'pollutantmean' that calculates the mean of a 
## pollutant (sulfate or nitrate) across a specified list of monitors.
## The function 'pollutantmean' takes three arguments: 'directory', 
## 'pollutant', and 'id'. Given a vector monitor ID numbers, 'pollutantmean' 
## reads that monitors' particulate matter data from the directory specified
## in the 'directory' argument and returns the mean of the pollutant across
## all of the monitors, ignoring any missing values coded as NA.

pollutantmean <- function(directory, pollutant, id = 1:332) {

  ## loop through the vector of ids to import each file 
  for (i in 1:length(id)) {
    
      ## create variable for the file number
      if (nchar(as.character(id[i])) != 3) {
        
          zeros  <- 3 - nchar(as.character(id[i]))
          id_new <- paste(strrep("0", zeros), id[i], sep = '')  
          
      } else {
        
          id_new <- as.character(id[i])  
      }
    
      ## create variable to hold the full filename
      file_i <- paste(paste(directory, id_new, sep = '/'), 'csv', sep = '.')

      ## import the 1st file in list
      if (i == 1) {
        
          data <- read.csv(file = file_i)
          
      ## import and append ith file in list
      } else {
        
          data_i <-read.csv(file = file_i)
          data <- rbind(data, data_i)
      }
  }
  
  ## subset the column and calculate the mean 
  var <- data[[pollutant]]
  mean(var, na.rm = TRUE)
}







# pollutantmean("C:/Users/castnerj/Desktop/Coursera/datasciencecoursera/data/specdata", "nitrate", 1:5)
