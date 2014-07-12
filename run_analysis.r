# Read in test and training data
datadir <- "UCI HAR Dataset"
x.train<-read.table(paste(datadir,"/train/X_train.txt", sep=""))
x.test<-read.table(paste(datadir,"/test/X_test.txt", sep=""))
y.train<-read.table(paste(datadir,"/train/y_train.txt", sep=""))
y.test<-read.table(paste(datadir,"/test/y_test.txt", sep=""))
subject.train<-read.table(paste(datadir,"/train/subject_train.txt", sep=""))
subject.test<-read.table(paste(datadir,"/test/subject_test.txt", sep=""))


# Merge the datasets 
x.all <-rbind(x.train,x.test)
y.all <-rbind(y.train,y.test)
subject.all <-rbind(subject.train,subject.test)

# Attach column names to the datasets
features<-read.table(paste(datadir,"/features.txt", sep=""))
colnames(x.all) <-features[,2]
colnames(y.all) <- "Label"
colnames(subject.all) <- "subject"

# only select mean and std column
x.selected<-x.all[,grep("mean|std",colnames(x.all),fixed=TRUE)]

# bind all datasets together
data.all <- cbind(subject.all, y.all, x.all)

#Write data to file for first assignment
write.table(data.all, "data.txt" , sep = ";")


#Aggregate data
data.tidy <- aggregate( data.all[,3] ~ subject+Label, data = data.all, FUN= "mean" )

#Write data to file for final assignment
write.table(data.tidy, "final.txt" , sep = ";")

print(data.tidy)