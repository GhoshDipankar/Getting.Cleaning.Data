# Code Book corresponding to the Getting and Cleaning Data Course Assignment Project
This Code Book overviews the data sets used in this project and enumerates the process through which a tidy data set can be obtained from the given data sets. 

## Overview:
Human Activity Recognition Using Smartphones' Datasets are prepared through experiments involving a group of 30 volunteers falling within an age bracket of 19-48 years.  
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on their waist. Using its embedded accelerometer and gyroscope, different measurements were captured for each activity for each person.    
The obtained datasets have been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and the remaining 30% for the test data.

## Data Sets:
The R script "run_analysis.R" can automatically download and unzip the dataset. 
It can be also be downloaded directly from the website:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
In that case, the first part of the R script "Downloading and unzipping data files" must be commented.  
### Required Data Sets after unzipping:
#### Folder: UCI HAR Dataset
1. activity_labels.txt   : Labels and Names of 6 activities   
2. features.txt          : List of all measurements Labels and Names  
#### Folder: UCI HAR Dataset/test:  
3. subject_test.txt      : List of Test Subject IDs based on those who performed the activities  
4. y_test.txt            : List of Test Activity Labels  
5. X_test.txt            : Data for all the activities for all features performed by all Test Subject IDs  
#### Folder: UCI HAR Dataset/train:  
6. subject_train.txt     : List of Training Subject IDs based on those who performed the activities  
7. y_train.txt           : List of Training Activity Labels  
8. X_train.txt           : Data for all the activities for all features performed by all Training Subject IDs  
## Packages used:
Since the following packages are used in the R script, they must be downloaded from Cran site if they are not installed. 
1. dplyr   
2. reshape2 

## Methodology:
The raw data sets are converted into a tidy data set by the R script "run_analysis.R" through the following steps.  
### Downloading and unzipping data files:
The data sets are downloaded from the given website and unzipped.  

### Reading of data from the folders:  
- activity_labels   : Six activity labels and corresponding names like "Walking", "Standing" etc  
- measurements      : List of all measurements  
- subject_test      : List of Test Subject IDs based on those who performed the activities  
- activity_test     : List of Test Activity Labels  
- x_test            : Data for all activities for all measurements performed by all Test Subject IDs  
- subject_train     : List of Training Subject IDs based on those who performed the activities  
- activity_train    : List of Training Activity Labels  
- x_train           : Data for all activities for all measurements performed by all Training Subject IDs 

### Preparation of combined data from Test and Training Data Sets:  
Test and Training data sets are combined into a single data set.  
- subject           : Combined Test and Training Subject IDs  
- activity          : Combined list of Activity Labels  
- data              : Combined activities for all measurements performed by all Test and Training Subject IDs  
### Extraction of only the measurements on the mean and standard deviation for each measurement:  
Since only the measurements on the mean and standard deviation for each measurement are to be extracted, total number of measurements is 66 as given by:    
#### For each of the following signals, 2 measurements for Mean and Standard deviation for each X, Y & Z making a total of 6 measurements for each signal:
- "TimeBodyAccelerometer"        
- "TimeGravityAccelerometer"  
- "TimeBodyAccelerometerJerk"  
- "TimeBodyGyroscope"  
- "TimeBodyGyroscopeJerk"  
- "FrequencyBodyAccelerometer"  
- "FrequencyBodyAccelerometerJerk"  
- "FrequencyBodyGyroscope"   
Total 48 measurements
#### For each of the following signals 2 measurements for Mean and Standard deviation making a total of 2 measurements for each signal:  
- "TimeBodyAccelerometerMagnitude"  
- "TimeGravityAccelerometerMagnitude"  
- "TimeBodyAccelerometerJerkMagnitude"  
- "TimeBodyGyroscopeMagnitude"  
- "FrequencyBodyAccelerometerMagnitude"  
- "FrequencyBodyAccelerometerJerkMagnitude"  
- "FrequencyBodyGyroscopeMagnitude"  
- "FrequencyBodyGyroscopeJerkMagnitude"  
Total 16 measurements.  
Therefore, total 48+16 = 66 measurements are to be considered when only the measurements on the mean and standard deviation are extracted.  
With the help of gsub() and grep() commands, the dataset "selectedData" is prepared which contains only the measurements on the mean and standard deviation.  

### Labelling the data set appropriately with descriptive measurement names:  
Short measurement names are renamed into their description names by gsub() so that "t", "f", "Acc", "Gyro", "Mag" are renamed as "Time", "Frequency", "Accelerometer", "Gyroscope", "Magnitude" respectively.  
Column names are added to the selected dataset.  
Columns corresponding to Subject IDs and Activity labels are also added to the selected data set "selectedData".  

### Giving descriptive activity names to name the activities in the data set:
Different activity names that are already read from file as "activity_labels" are used to replace activity labels with the corresponding names.  

### Creation of an independent tidy data set with the mean of each variable for each activity and each subject  
- The selected data set "selectedData" is converted into a molten data frame called "molten_data" by the use of melt() of the package "reshape2".  
- Mean of each variable for each Activity and each Subject is estimated by dcast() and stored in a data frame called "tidy_set".  
- The tidy data set is written in a file called "tidyData.txt"
