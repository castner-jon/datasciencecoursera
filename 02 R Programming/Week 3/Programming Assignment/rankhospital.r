
## function "rankhospital" takes state, outcome, and num parameters  
## and returns the hospital name in the given state with the given rank 
## 30-day mortality rate for the given outcome  

rankhospital <- function (state = NULL, outcome = NULL, num = "best") {
  
  ## read the data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

  ## check for valid state
  valid.states <- unique(data$State)
  
  if (!(state %in% valid.states)) {
    stop("invalid state")
  }
  
  ## check for valid outcome
  valid.outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  if (!(outcome %in% valid.outcomes)) {
    stop("invalid outcome")
  }
  
  ## check for valid num
  valid.num <- c("best", "worst")
  
  if (!(num %in% valid.num) && !is.numeric(num)) {
    stop("invalid num")
  }

  ## subset data by state and non missing outcome 
  data.subset <- data[data$State == state, ]
  
  if (outcome == "heart attack") {
    data.subset <- data.subset[!is.na(as.numeric(data.subset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)), ] 
    
  } else if (outcome == "heart failure") {
    data.subset <- data.subset[!is.na(as.numeric(data.subset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)), ] 
    
  } else if (outcome == "pneumonia") {
    data.subset <- data.subset[!is.na(as.numeric(data.subset$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)), ] 
    
  } else {}
  
  ## order the rows by outcome, hospital name
  if (outcome == "heart attack") {
    data.subset <- data.subset[order(as.numeric(data.subset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), data.subset$Hospital.Name), ]
    
  } else if (outcome == "heart failure") {
    data.subset <- data.subset[order(as.numeric(data.subset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure), data.subset$Hospital.Name), ]
    
  } else if (outcome == "pneumonia") {
    data.subset <- data.subset[order(as.numeric(data.subset$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia), data.subset$Hospital.Name), ]
    
  } else {}
  
  ## check that num argument is less than the number of hospitals in the subset
  if (is.numeric(num) && num > nrow(data.subset)) {
    return(NA)
    stop()
  }
  
  ## create rank variable from num argument
  if (num == "best") {
    rank <- 1
    
  } else if (num == "worst") {
    rank <- nrow(data.subset)
    
  } else {
    rank <- num
    
  }

  ## return the hospital name
  print(data.subset[rank, "Hospital.Name"])
  # View(data.subset)
}