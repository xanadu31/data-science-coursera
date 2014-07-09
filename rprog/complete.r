complete <- function(directory, id = 1:332) {
  results<-data.frame()
  for (i in id){
    i <- sprintf("%03d", i)
    data <- read.csv(paste(directory,"/",i,".csv",sep=""))
    observations <- sum(complete.cases(data))
    results<-rbind(results,data.frame(id=i, nobs=observations))
  }
  colnames(results) <- c("id","nobs")
  results
}

