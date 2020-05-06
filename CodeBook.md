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
