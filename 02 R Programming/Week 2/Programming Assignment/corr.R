
## Write a function that takes a directory of data files and a 
## threshold for complete cases and calculates the correlation 
## between sulfate and nitrate for monitor locations where the
## number of completely observed cases (on all variables) is
## greater than the threshold. The function should return a vector
## of correlations for the monitors that meet the threshold 
## requirement. If no monitors meet the threshold requirement, then
## the function should return a numeric vector of length 0.

coor <- function(directory, threshold = 0) {
  
  ## number of files in directory
  num_files <- list.files(directory)
  
  ## initalize datatframe
  data <- as.vector(1)
  
  ## loop through the files 
  for (i in 1:length(num_files)) {
    
      file_i <- paste(directory, num_files[i], sep = '/')
      data_i <- read.csv(file_i)
      complete <- sum(complete.cases(data_i))
      data_i <- data_i[complete.cases((data_i)),]
      
      if (complete > threshold) {
          coor <- cor(data_i$sulfate, data_i$nitrate)
          data <- rbind(data, coor)
      }
  }
  
  if (length(data) != 1) {
      as.vector(data)[2:length(data)]
    
  } else {
      vector(mode = "numeric", length=0)
  }
}

