
## function "best" takes state and outcome and returns 
## the hospital name in the given state with the lowest 
## 30-day mortality rate for the given outcome  

best <- function (state = NULL, outcome = NULL) {
  
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
  
  ## subset data by state and non missing outcome 
  data.subset <- data[data$State == state, ]
  
  if (outcome == "heart attack") {
    data.subset <- data.subset[!is.na(as.numeric(data.subset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)), ] 
    
  } else if (outcome == "heart failure") {
    data.subset <- data.subset[!is.na(as.numeric(data.subset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)), ] 
    
  } else if (outcome == "pneumonia") {
    data.subset <- data.subset[!is.na(as.numeric(data.subset$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)), ] 
    
  } else {}
  
  ## return hospital name for lowest 30 day mortality rate given state and outcome
  if (outcome == "heart attack") {
    data.subset <- data.subset[order(as.numeric(data.subset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), data.subset$Hospital.Name), ]
    
  } else if (outcome == "heart failure") {
    data.subset <- data.subset[order(as.numeric(data.subset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure), data.subset$Hospital.Name), ]
    
  } else if (outcome == "pneumonia") {
    data.subset <- data.subset[order(as.numeric(data.subset$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia), data.subset$Hospital.Name), ]
    
  } else {}

  print(data.subset[1, "Hospital.Name"])
  # View(data.subset)
}