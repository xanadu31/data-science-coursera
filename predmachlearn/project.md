Predicting patterns of Dumbbell Biceps Curl in five different fashions
========================================================

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement  a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. 

6 test subjects were asked to perform barbell lifts correctly and incorrectly in 5 different ways. In this project, the goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of these 6 participants to predict how they were doing the excercise. 

More information is available from the website here: http://groupware.les.inf.puc-rio.br/har (see the section on the Weight Lifting Exercise Dataset). 




```
## Loading required package: lattice
## Loading required package: ggplot2
## Loading required package: grid
## Loading required package: zoo
## 
## Attaching package: 'zoo'
## 
## The following objects are masked from 'package:base':
## 
##     as.Date, as.Date.numeric
## 
## Loading required package: sandwich
## Loading required package: strucchange
## Loading required package: modeltools
## Loading required package: stats4
```

# Data
Data is supplied by Groupware@LES. Both a training dataset and a final test dataset is available. In order to avoid fitting the model to the final testing set the training set is splitted into a train (60%) and test (40%) set.


```r
data.train <- read.csv("pml-training.csv")
data.test <- read.csv("pml-testing.csv")

trainIndex <- createDataPartition(data.train$classe, list=FALSE, p=.6)
train.train = data.train[trainIndex,]
train.test = data.train[-trainIndex,]
```

## Cleaning Data
A quick glance on the summary of the datasets shows that the data isn't very tidy. There are numerous empty or NA values. Variables containing many NA or empty values will be removed from the dataset. Also variables that do not offer any predictive value such as the user_name, X (ID column) and the various time-related variables will be removed .


```r
removeColumns <- sapply(train.train, function(x) {
  sum(is.na(x)) || sum(!is.na(x) & x=="")
})

train.train  <- train.train[!removeColumns]

train.train <- train.train[,!(names(train.train) %in% c("X","user_name","raw_timestamp_part_1","raw_timestamp_part_2","cvtd_timestamp"))]
```

# Prediction model
For building a prediction model the caret package is used. The algorithm which will be used is the random forest algorithm since they are quite fast and usually provide very good results.. 


```r
model <- train(classe ~ ., data=train.train, method="rf", ntree=75)
model
```

```
## Random Forest 
## 
## 11776 samples
##    54 predictors
##     5 classes: 'A', 'B', 'C', 'D', 'E' 
## 
## No pre-processing
## Resampling: Bootstrapped (25 reps) 
## 
## Summary of sample sizes: 11776, 11776, 11776, 11776, 11776, 11776, ... 
## 
## Resampling results across tuning parameters:
## 
##   mtry  Accuracy  Kappa  Accuracy SD  Kappa SD
##   2     1         1      0.003        0.004   
##   30    1         1      0.002        0.002   
##   50    1         1      0.003        0.004   
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was mtry = 28.
```


# Model evaluation
The model is evaluated by calculating the in sample prediction accuracy (on the 60% splitted part of the training set)

```r
prediction.inSample <- predict(model, train.train) 
```

```
## Loading required package: randomForest
## randomForest 4.6-7
## Type rfNews() to see new features/changes/bug fixes.
```

```r
mean(prediction.inSample == train.train$classe)
```

```
## [1] 1
```

and by calculating the prediction accuracy on the out of sample test split (the other 40% of the supplied training data)

```r
prediction.outSample <- predict(model, train.test) 
mean(prediction.outSample == train.test$classe)
```

```
## [1] 0.9972
```

We can see that the model performance is very good. It achieves 99% acuracy on the out of sample dataset.

## Confusion Matrix: 

```r
confusionMatrix(train.test$classe, prediction.outSample)
```

```
## Warning: package 'e1071' was built under R version 3.1.1
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 2232    0    0    0    0
##          B    6 1508    4    0    0
##          C    0    2 1366    0    0
##          D    0    0    6 1279    1
##          E    0    0    0    3 1439
## 
## Overall Statistics
##                                         
##                Accuracy : 0.997         
##                  95% CI : (0.996, 0.998)
##     No Information Rate : 0.285         
##     P-Value [Acc > NIR] : <2e-16        
##                                         
##                   Kappa : 0.996         
##  Mcnemar's Test P-Value : NA            
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity             0.997    0.999    0.993    0.998    0.999
## Specificity             1.000    0.998    1.000    0.999    1.000
## Pos Pred Value          1.000    0.993    0.999    0.995    0.998
## Neg Pred Value          0.999    1.000    0.998    1.000    1.000
## Prevalence              0.285    0.192    0.175    0.163    0.184
## Detection Rate          0.284    0.192    0.174    0.163    0.183
## Detection Prevalence    0.284    0.193    0.174    0.164    0.184
## Balanced Accuracy       0.999    0.999    0.996    0.998    0.999
```

# Test dataset


```r
result <- predict(model, data.test)
result
```

```
##  [1] B A A A A E D B A A B C B A E E A B B B
## Levels: A B C D E
```
