# This R script can be used to do the following:  
# 1. To download and unzip Samsung Galaxy S smartphone data.
# 2. To merge the training and the test sets to create one data set.
# 3. To extract only the measurements on the mean and standard deviation 
#               for each measurement.
# 4. To label the data set appropriately with descriptive variable names.
# 5. To use descriptive activity names to name the activities in the data set.
# 6. To create a second, independent tidy data set with the average of 
#              each variable for each activity and each subject.
###############################################################################
# Prerequisites:  
# Loading two packages: 1.dplyr and 2.reshape2: 
  library(dplyr) 
  library(reshape2)
#
# % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
# 1. Downloading and unzipping data files:
# Given URL:
  zipped.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# Giving a name to the downloading file:
  samsungdata <- "destfile.zip"
# Downloading and saving the data:
  download.file(zipped.url,samsungdata)
# Unzipping data file:
  unzip(samsungdata)
# After unzipping a folder called "UCI HAR Dataset" is extracted which contains
#       information about data and two more folders called "test" and "train" 
#       containing data collected from test and train subjects respectively.
#
# % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
# Reading of data from the folders:
#
# Reading of 6 activitiy labels and corresponding names like "Walking", "Standing" etc:    
  activitiy_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
# Reading of the list of all measurements:
  measurements <- read.table("UCI HAR Dataset/features.txt")[,2]
#
# Use of Test Set:
# List of Test Subject ID who performed the activities: 
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")  
# List of Activitiy Labels:  
  activity_test <- read.table("UCI HAR Dataset/test/y_test.txt")   # Test Labels
# Data for all the activites for all measurements performed by all Test Subject IDs:
  x_test <- read.table("UCI HAR Dataset/test/X_test.txt")   
#
# Use of Training Set:
# List of Training Subject ID who performed the activities: 
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
# List of Activitiy Labels:
  activity_train <- read.table("UCI HAR Dataset/train/y_train.txt")
# Data for all the activites for all measurements performed by all Training Subject IDs:  
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
#
# % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
# 2. Preparation of combined data from Test and Training Data Sets:
#
# Combning Test and Training Subject IDs:  
  subject <- rbind(subject_test, subject_train)
# Adding Column Name as "SubjectID"  
  names(subject) <- "SubjectID"
# Combning List of Activitiy Labels from Test and Training Sets:
  activity <- rbind(activity_test, activity_train)
# Adding Column Name as "Activity" 
  names(activity) <- "Activity"
# Combining of all the activites for all measurements performed by 
#     all Test and Training Subject IDs:
  data <- rbind(x_test, x_train)  
#
# % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
# 3. Extracting only the measurements on the mean and standard deviation 
  #               for each measurement:
#
# Avoiding meanFreq during pattern matching:
  measurements <- gsub("meanFreq", "avgFreq", measurements)
# Capturing only the measurements on the mean and standard deviation: 
  mean_std_measurements <- grep("mean|std", measurements)
# Capturing Names of only the measurements on the mean and standard deviation:  
  selectedMeasurementsNames <- measurements[mean_std_measurements] 
# Selection of Data corresponding to measurements 
#              on the mean and standard deviation:  
  selectedData <- data[, mean_std_measurements]
#
# % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
# 4. Labeling the data set appropriately with descriptive measurement names:
  selectedMeasurementsNames <- 
      selectedMeasurementsNames %>%
      gsub("^t", "Time", .) %>%                # Renaming t to Time
      gsub("^f", "Frequency", .) %>%           # Renaming f to Frequency
      gsub("Acc", "Accelerometer", .) %>%      # Renaming Acc to Accelerometer
      gsub("Gyro", "Gyroscope", .)  %>%        # Renaming Gyro to Gyroscope
      gsub("BodyBody", "Body", .)  %>%         # Renaming BodyBody to Body
      gsub("Mag", "Magnitude", .)  %>%         # Renaming Mag to Magnitude
      gsub("()", "", ., fixed = TRUE)          # Removing () 
# Adding column names to the selested data:  
  colnames(selectedData) <- selectedMeasurementsNames
# Adding Subject IDs and Activity labels to the selested data:
  selectedData <- cbind(subject, activity, selectedData)
#
# % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
# 5. Giving descriptive activity names to name the activities in the data set:
  selectedData$Activity <- factor(selectedData$Activity, labels = activitiy_labels[,2])
#
# % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
# 6. Creation of an independent tidy data set with the average of 
#                    each variable for each activity and each subject:
# Converting selectedData into a molten data frame called molten_data:
  molten_data <- melt(selectedData, id = c("SubjectID", "Activity"))
# Estimating Mean of each variable for each Activity and each Subject:
  tidy_set <- dcast(molten_data, SubjectID+Activity ~ variable, mean)
# Writing the tidy data set in a file called "tidyData.txt":
  write.table(tidy_set, "tidyData.txt")
# #############################################################################
