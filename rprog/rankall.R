rankall <- function(outcome, num = "best") {
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

  splittedResults <- split(data, data$State)
  names <- names(splittedResults)
  dataFrame <- data.frame()
  if(outcome == "heart failure"){
    # "Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    i <- 1
    for(results in splittedResults){
       results <- results[order(as.numeric(results$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure), results$Hospital.Name), ]
       results <- results[results$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure != "Not Available", ]
      
       if(num == "best"){
         selectNum <- 1
       }else if (num == "worst"){
         selectNum <- nrow(results)
       }else{
         selectNum <- num
       }
       dataFrame<-rbind(dataFrame,data.frame(hospital=results$Hospital.Name[selectNum], state=names[i]))
       i <- i+1
    } 
    return(dataFrame) 
  }else if(outcome == "heart attack"){
    # "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"    
    i <- 1
    for(results in splittedResults){
      results <- results[order(as.numeric(results$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), results$Hospital.Name), ]
      results <- results[results$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack != "Not Available", ]
      
      if(num == "best"){
        selectNum <- 1
      }else if (num == "worst"){
        selectNum <- nrow(results)
      }else{
        selectNum <- num
      }
      dataFrame<-rbind(dataFrame,data.frame(hospital=results$Hospital.Name[selectNum], state=names[i]))
      i <- i+1
    } 
    return(dataFrame) 
    
  }else if(outcome == "pneumonia"){
    # "Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    i <- 1
    for(results in splittedResults){
      results <- results[order(as.numeric(results$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia), results$Hospital.Name), ]
      results <- results[results$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia != "Not Available", ]
      
      if(num == "best"){
        selectNum <- 1
      }else if (num == "worst"){
        selectNum <- nrow(results)
      }else{
        selectNum <- num
      }
      dataFrame<-rbind(dataFrame,data.frame(hospital=results$Hospital.Name[selectNum], state=names[i]))
      i <- i+1
    } 
    return(dataFrame) 
    
  }else{
    stop("invalid outcome")
  }
  
}