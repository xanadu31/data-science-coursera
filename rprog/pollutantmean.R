pollutantmean <- function(directory, pollutant, id = 1:332){
  data <- data.frame()
  for (i in id){
    i <- sprintf("%03d", i)
    data <- rbind(read.csv(paste(directory,"/",i,".csv",sep="")),data)
  }
  
  data <- data[complete.cases(data[[pollutant]]),]
  
  mean(data[[pollutant]])
}
subm