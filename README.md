---
output: html_document
---

# Getting and Cleaning Data - Week 4 

## Description of Data


Human Activity Recognition Using Smartphones Dataset
Version 1.0

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

## Variables of the feature vector:


* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

## The set of variables that were estimated from these signals are: 


* mean(): Mean value
* std(): Standard deviation

## Getting and Cleaning the data:

1. Read the activity labels and features into dataframe
    * activity_labels
    * features
2. Read the subjects' data
    * subject_train
    * subject_test
3. Merge the train and test subjects
    * total_subjects
4. Read the set data
    * x_train
    * x_test
5. Merge the train and test sets
    * total_set
6. Read the movement data
    * y_train
    * y_test
7. Merge the train and test movement data
    * total_activity
        
8. Merges the training and the test sets to create one data set.
    * my_data <-cbind(total_activity,total_set,total_subjects)

9. Extracts only the measurements on the mean and standard deviation for each measurement.
    * mean_std <- grep("mean|std", features[,2])
    * my_result<- subset(total_set, select = mean_std)
        
10. Uses descriptive activity names to name the activities in the data set
    * my_result <-cbind(my_result,total_activity)
    * my_result <-merge(activity_labels,my_result, by.x="activity_id",by.y="movement")
        
11. Appropriately labels the data set with descriptive variable names.
    * my_result <- cbind(my_result,total_subjects)
        
12. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.      
    * my_result<- my_result %>% group_by(activity_names, subject) %>% summarise_each(funs = (mean))

