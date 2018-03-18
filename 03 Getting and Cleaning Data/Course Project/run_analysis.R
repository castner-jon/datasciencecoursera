
### Directions:
###
### 1. Merges the training and the test sets to create one data set.
### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
### 3. Uses descriptive activity names to name the activities in the data set
### 4. Appropriately labels the data set with descriptive variable names.
### 5. From the data set in step 4, creates a second, independent tidy data set with the average 
###    of each variable for each activity and each subject.
###


setwd("C:/Users/castnerj/Desktop/Coursera/datasciencecoursera/03 Getting and Cleaning Data/Course Project")
library(tidyverse)


### import activity labels dataset and create column names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("ActivityId", "ActivityName")


### import features dataset, create column names, and create unique values for feature name
features <- read.table("UCI HAR Dataset/features.txt")
colnames(features) <- c("FeatureId", "FeatureName")
features <- features %>%
  mutate(FeatureName2 = paste("V", FeatureId, "_", FeatureName, sep = ""))


### import test subjects dataset and create column names
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(test_subject) <- c("SubjectId")


### import the test set and test labels datasets and create columns names
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/Y_test.txt")
colnames(test_x) <- features$FeatureName2
colnames(test_y) <- c("ActivityId")


### join the activity name to the label dataset
test_y <- left_join(test_y, activity_labels, by = "ActivityId")


### append the test datasets together
test <- cbind(test_subject, test_y, test_x) %>%
  select("SubjectId", "ActivityName", contains("std()"), contains("mean()"))


### clear workspace
remove(test_subject, test_x, test_y)


### import train subjects dataset and create column names
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(train_subject) <- c("SubjectId")


### import the train set and train labels datasets and create columns names
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/Y_train.txt")
colnames(train_x) <- features$FeatureName2
colnames(train_y) <- c("ActivityId")


### join the activity name to the label dataset
train_y <- left_join(train_y, activity_labels, by = "ActivityId")


### append the test datasets together
train <- cbind(train_subject, train_y, train_x) %>%
  select("SubjectId", "ActivityName", contains("std()"), contains("mean()"))


### clear workspace
remove(train_subject, train_x, train_y, features, activity_labels)


### combine the test and train datasets 
data <- rbind(test, train)


### rename the variables 
headers <- colnames(data)

str_sub(headers[3:length(headers)], 1, str_locate(headers[3:length(headers)], "_")[,1]) = ""

headers <- headers %>% 
  str_replace_all("[-,'('')']", "") 

headers <- if_else(!is.na(str_match(headers, "std")),
                   paste("Std", str_replace(headers, "std", ""), sep = "_"),
                   headers)

headers <- if_else(!is.na(str_match(headers, "mean")),
                   paste("Mean", str_replace(headers, "mean", ""), sep = "_"),
                   headers)

headers[66:68] <- str_replace(headers[66:68], "Body", "")
headers[33:35] <- str_replace(headers[33:35], "Body", "")

colnames(data) <- headers

remove(headers, test, train)


### calculate summary
data_summary <- data %>%
  group_by(SubjectId, ActivityName) %>%
  summarise_all(funs(mean))






# test_body_acc_x <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
# test_body_acc_y <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
# test_body_acc_z <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
# 
# test_body_gyro_x <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
# test_body_gyro_y <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
# test_body_gyro_z <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
# 
# test_total_acc_x <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
# test_total_acc_y <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
# test_total_acc_z <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")


# train_body_acc_x <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
# train_body_acc_y <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
# train_body_acc_z <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
# 
# train_body_gyro_x <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
# train_body_gyro_y <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
# train_body_gyro_z <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
# 
# train_total_acc_x <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
# train_total_acc_y <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
# train_total_acc_z <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")



