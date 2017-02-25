

#we load the libraries required for the script

library("dplyr")
library(data.table)


##the data from the files X_test and X_train is loaded to work with them in R
##The labels from train and test files are also loaded in their own data.frame
X_test <- read.table("UCI HAR Dataset\\test\\X_test.txt")
Y_test <- read.table("UCI HAR Dataset\\test\\Y_test.txt")
subject_test <- read.table("UCI HAR Dataset\\test\\subject_test.txt")

X_train <- read.table("UCI HAR Dataset\\train\\X_train.txt")
Y_train <- read.table("UCI HAR Dataset\\train\\Y_train.txt")
subject_train <- read.table("UCI HAR Dataset\\train\\subject_train.txt")

activity_labes <- read.table("activity_labels.txt")

#To make it more readable, we load the features.txt that contains the labes this is also so we can select
#only the mean and the std later on
labels_files <- read.table("features.txt")

#The labesl that were loaded are assigned to the data.frames from train and test so it is meaningfull in the result
#we preserve the same labels from the original data so it remains like in the origin and further reference may be done

names(X_test) <- labels_files$V2
names(X_train) <- labels_files$V2

## the labels that identify each activity in the dataframe are added to each one as a new column
 X_test$activity <- as.character(Y_test$V1)
X_train$activity <- as.character(Y_train$V1)


## The labels that identify the subject is also added to each of the data frame before merge them
X_test$subject <- as.character(subject_test$V1)
X_train$subject <- as.character(subject_train$V1)

#now that we have both test and train tables with the same variables we merge them in one data.frame
# named mergedData so we can group and work with it
mergeData <- rbind.data.frame(X_test, X_train)
myDT <- data.table(mergeData)

#we create another data set with only the mean and standar deviation of the measurements
# we subset the mergedData by selecting only the columns that are standar deviation or mean
myDTsubset <- subset(myDT, select = grep("subject|activity|mean|std", names(myDT)))

#we mutate the data set to change teh variable names to a more descriptive readable name
myDTsubset[which(myDTsubset$activity==1)]$activity <- activity_labes$V2[activity_labes$V1==1]
myDTsubset[which(myDTsubset$activity==2)]$activity <- activity_labes$V2[activity_labes$V1==2]
myDTsubset[which(myDTsubset$activity==3)]$activity <- activity_labes$V2[activity_labes$V1==3]
myDTsubset[which(myDTsubset$activity==4)]$activity <- activity_labes$V2[activity_labes$V1==4]
myDTsubset[which(myDTsubset$activity==5)]$activity <- activity_labes$V2[activity_labes$V1==5]
myDTsubset[which(myDTsubset$activity==6)]$activity <- activity_labes$V2[activity_labes$V1==6]


#we group the DT by subject and activity and apply the mean to obtain the average on each variable per group 
myNewTidyData <- aggregate(myDTsubset[,1:79], list(myDTsubset$subject,myDTsubset$activity), mean )


