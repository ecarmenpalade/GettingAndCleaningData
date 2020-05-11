# You will be required to submit: 
# 1) a tidy data set as described below, 
# 2) a link to a Github repository with your script for performing the analysis, and 
# 3) a code book that describes the variables, the data, and any transformations or work that you performed 
# to clean up the data called CodeBook.md. 
# 
# You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.




# Here are the data for the project:
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following.
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.

# Load any required library

library(dplyr)
library(tidyr)

#Reading activity labels and features into dataframes
        activity_labels<- read.csv("./UCI HAR Dataset/activity_labels.txt", header=FALSE, col.names="activity_names")
        activity_labels <-mutate(activity_labels, activity_id = 1:6)
        
        features<- read.csv("./UCI HAR Dataset/features.txt", header=FALSE, sep="")
        names(features)<-c("feature_id","feature_name")
#Reading the subjects' data
        subject_train<- read.csv("./UCI HAR Dataset/train/subject_train.txt",header=FALSE, sep="",col.names = "subject")
        subject_test<- read.csv("./UCI HAR Dataset/test/subject_test.txt",header=FALSE, sep="",col.names = "subject")
        #merge the train and test data
        total_subjects <- rbind(subject_train,subject_test)
#Reading sets
        x_train<- read.csv("./UCI HAR Dataset/train/X_train.txt",header=FALSE,sep="")
        x_test<- read.csv("./UCI HAR Dataset/test/X_test.txt",header=FALSE,sep="")
        #merge the train and test data
        total_set <- rbind(x_train,x_test)
        #add column names the total set
        names(total_set)<-features$feature_name
#Reading activity
        y_train<- read.csv("./UCI HAR Dataset/train/y_train.txt",header=FALSE,sep="",col.names = "movement")
        y_test<- read.csv("./UCI HAR Dataset/test/y_test.txt",header=FALSE,sep="",col.names = "movement")
        #merge the train and test data
        total_activity <- rbind(y_train,y_test)
        
#Merges the training and the test sets to create one data set.
        my_data <-cbind(total_activity,total_set,total_subjects)

#Extracts only the measurements on the mean and standard deviation for each measurement.
        mean_std <- grep("mean|std", features[,2])
        my_result<- subset(total_set, select = mean_std)
        
# Uses descriptive activity names to name the activities in the data set
        my_result <-cbind(my_result,total_activity)
        my_result <-merge(activity_labels,my_result, by.x="activity_id",by.y="movement")
        
 # Appropriately labels the data set with descriptive variable names.
        my_result <- cbind(my_result,total_subjects)
        #tidy up columns that we don't use
        my_result$activity_id<-NULL
        
 #From the data set in step 4, creates a second, independent tidy data set with the average of 
 # each variable for each activity and each subject.      
        my_result<- my_result %>% group_by(activity_names, subject) %>% summarise_each(funs = (mean))
