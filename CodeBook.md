# Code Book corresponding to the Getting and Cleaning Data Course Assignment Project
 This Code Book overviews the data sets used in this project and the guides the process through which a tidy data set can be obtained from the given data sets. 

## Overview:
Human Activity Recognition Using Smartphones Datasets are prepared through experiments with a group of 30 volunteers within an age bracket of 19-48 years.  
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, different measurements are captured for each activity for each person  
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

## Data Sets:
The the R script "run_analysis.R" can automatically download and unzip the dataset. 
It can be also be downloaded directly from the website:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
In that case, the first part of the R script "Downloading and unzipping data files" must be commented.  
### Required Data Sets after unzipping:
#### Folder:UCI HAR Dataset
1. activity_labels.txt   : Labels and Names of 6 activities   
2. features.txt          : List of all measurements Labels and Names  
#### Folder:UCI HAR Dataset/test:  
3. subject_test.txt      : List of Test Subject ID who performed the activities  
4. y_test.txt            : List of Test Activitiy Labels  
5. X_test.txt            : Data for all the activites for all features 
                           performed by all Test Subject IDs  
#### Folder:UCI HAR Dataset/train:  
6. subject_train.txt     : List of Training Subject ID who performed the activities  
7. y_train.txt           : List of Training Activitiy Labels  
8. X_train.txt           : Data for all the activites for all features 
                           performed by all Training Subject IDs  
## Packages used:
Since the following packages are used in the R script, if they are not installed, then they must be downloaded from Cran site. 
1. dplyr   
2. reshape2 

## Methodology:
The raw data sets are converted into a tidy data set by the R script "run_analysis.R" through the following steps.  
### Downloading and unzipping data files:
The data sets are downloaded from the give website and unzipped.  

### Reading of data from the folders:  
- activitiy_labels  : Six activitiy labels and corresponding names like "Walking", "Standing" etc  
- measurements      : List of all measurements  
- subject_test      : List of Test Subject ID who performed the activities  
- activity_test     : List of Test Activitiy Labels  
- x_test            : Data for all activites for all measurements performed by all Test Subject IDs  
- subject_train     : List of Training Subject ID who performed the activities  
- activity_train    : List of Training Activitiy Labels  
- x_train           : Data for all activites for all measurements performed by all Training Subject IDs 

### Preparation of combined data from Test and Training Data Sets:  
Test and Training data sets are combined into a single data set.  
- subject           : Combined Test and Training Subject IDs  
- activity          : Combined list of Activitiy Labels  
- data              : Combined activites for all measurements performed by all Test and Training Subject IDs  
### Extraction of only the measurements on the mean and standard deviation for each measurement:  
Since only the measurements on the mean and standard deviation for each measurement are to be extracted, total number of measurements are 66 as given by:    
#### For each of the following signals 2 measurements for Mean and Standard deviation for each X, Y & Z making a total of 6 measurements for each signal:
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
With the help of gsub() and grep() commands, the dataset "selectedData" is prepared which containes only the measurements on the mean and standard deviation.  
