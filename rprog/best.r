best <- function(state, outcome) {
  results <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  results <- results[results$State == state, ]
  
  if(nrow(results) == 0){
    stop("invalid state")
  }
  
  if(outcome == "heart failure"){
    # "Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    results <- results[order(as.numeric(results$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure), results$Hospital.Name), ]
    return(results$Hospital.Name[1])
    
  }else if(outcome == "heart attack"){
    # "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"    
    results <- results[order(as.numeric(results$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), results$Hospital.Name), ]
    return(results$Hospital.Name[1])
    
  }else if(outcome == "pneumonia"){
    # "Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    results <- results[order(as.numeric(results$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia), results$Hospital.Name), ]
    return(results$Hospital.Name[1])
    
  }else{
    stop("invalid outcome")
  }
}