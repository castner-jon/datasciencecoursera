
## function "rankhospital" takes state, outcome, and num parameters  
## and returns the hospital name in the given state with the given rank 
## 30-day mortality rate for the given outcome  

rankall <- function (outcome = NULL, num = "best") {
  
  ## read the data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

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
  
  ## store outcome metric in variable
  if (outcome == "heart attack") {
    outcome.var <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" 
    
  } else if (outcome == "heart failure") {
    outcome.var <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure" 

  } else if (outcome == "pneumonia") {
    outcome.var <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia" 

  } else {}
  
  ## state list
  list.states <- unique(data$State)

  ## subset data by non missing outcome 
  data.subset <- data[!is.na(as.numeric(data[,eval(outcome.var)])), ] 
    
  ## check that num argument is less than the number of hospitals in the subset
  if (is.numeric(num) && num > nrow(data.subset)) {
    return(NA)
    stop()
  }

  ## create ranking variable within state
  data.subset <- data.subset[order(data.subset$State, as.numeric(data.subset[,eval(outcome.var)]), data.subset$Hospital.Name), ]
  data.subset$rankbest  <- ave(data.subset$Hospital.Name, data.subset$State, FUN = seq_along)
  
  data.subset <- data.subset[order(data.subset$State, as.numeric(data.subset[,eval(outcome.var)]), data.subset$Hospital.Name, decreasing = TRUE), ]
  data.subset$rankworst <- ave(data.subset$Hospital.Name, data.subset$State, FUN = seq_along)
  
  ## pull hospitals based on rank for each state
  if (num == "best") {
    data.state <- data.subset[data.subset$rankbest == 1, ]
    
  } else if (num == "worst") {
    data.state <- data.subset[data.subset$rankworst == 1, ]
    
  } else {
    data.state <- data.subset[data.subset$rankbest == num, ]
    
  }
  
  ## return dataset containing all states and hospital names mathcing outome rank 
  final.data <- merge(x = as.data.frame(list.states), y = data.state, by.x = "list.states", by.y = "State", all.x = TRUE)
  final.data <- final.data[, c("Hospital.Name", "list.states")]
  colnames(final.data) <- c("hospital", "state")
  final.data
  
}