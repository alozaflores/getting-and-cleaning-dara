# getting-and-cleaning-dara
Repo for the course project Getting and Cleaning Data Coursera

Getting and Cleaning your Data Course Project.

This script relates to the project of week 4 on the coursera about Getting and Cleaning Data, it works with the activity data provided on the assigment (see below for details) and it created a final text file with the resulting data 

Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

Prerequisites
-You must download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
-You must decompress the data on your working directory of R
-The script will try to load the data.table library and the dplyr library. You must have these two package installed or an error / warning may be trown and the script may not work or will give bad results 


Processing 

The files containing the data for test, train, subject and activity are loaded into a separate table each

X_test.txt
Y_test.txt
subject_test.txt
X_train.txt
Y_train.txt
subject_train.txt

Then the script reads the labels so they can be assigned to the apropiate table, the labels are important because the names of the columns will be used to subset the data for the std and the mean

The subject and activity variables are added to the X_test and X_train data frames to have a way of knowing the data when it is manipulated
particularly so we can group by the subject and the activity later 

An rbind is performed to merge the train and test data that already have the names of the labels from the last step

The dataframe is transformed to a Data.table and then it is subset using the names to select only the columsn in which the name includes the std and the mean,  

As the last step the aggregate fnction is used to create the final data.table and we group by subject and activity 




