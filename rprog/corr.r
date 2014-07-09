corr <- function(directory, threshold = 0) {
  
  results <- vector('numeric')
  for (file in list.files(directory)){
    dataset <- read.csv(paste(directory,"/",file,sep=""))
    dataset <- dataset[complete.cases(dataset),]
    if(nrow(dataset) > threshold) {
      results <- rbind(results, cor(dataset$nitrate, dataset$sulfate))
    }
  }
  
return(results)

}