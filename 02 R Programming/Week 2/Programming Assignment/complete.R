
## Write a function that reads a directory full of files and
## reports the number of completely observed cases in each 
## data file. The function should return a data frame where
## the first column is the name of the file and the second 
## column is the number of complete cases. 

complete <- function(directory, id = 1:332) {

  ## initalize vector to hold complete cases metric
  complete <- as.vector(length(id))
  
  ## loop through ids
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
      data_i <- read.csv(file = file_i)
      
      ## calculate complete cases
      complete[i] <- sum(complete.cases(data_i))
  }
  
  as.data.frame(cbind(id, complete))
}