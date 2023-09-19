###############################################################################################
# 'GETTING AND CLEANING DATA' COURSE PROJECT
# PART OF THE DATA SCIENCE SPECIALIZATION FROM JOHNS HOPKINS UNIVERSITY VIA COURSERA
###############################################################################################
# AUTHOR: BRUNO LAGET MERINO
###############################################################################################



###############################################################################################
#ASSESSMENT CRITERIA
###############################################################################################
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###############################################################################################



###############################################################################################
#LOADING REQUIRED PACKAGES
library("reshape2")
library("data.table")
library("dplyr")
library("lubridate")
###############################################################################################
#DOWLOADING AND UNZIPPING RAW DATA
rawData <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
path <- getwd()
download.file(rawData, file.path(path, "RAWFILES.zip"))
unzip(zipfile = "RAWFILES.zip")
###############################################################################################
#READING AND EXTRACTING LABELS
labelsDir = paste(trimws(path), "/UCI HAR Dataset", sep="")
activity_labels <- fread(
    file.path(labelsDir, "activity_labels.txt"),
        col.names = c("ActivityClass", "ActivityName")
)
#READING AND EXTRACTING FEATURES
features <- fread(file.path(labelsDir, "features.txt")
                  , col.names = c("index", "featureNames"))
featuresFiltered <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- gsub('[()]', '', features[featuresFiltered, featureNames])
###############################################################################################
#LOADING TEST AND TRAINING DATASETS SEPARATELY
#declaring more subdirectory paths for greater code maintainability
pathTest <- paste(trimws(path), "/UCI HAR Dataset/test", sep="")
pathTrain <- paste(trimws(path), "/UCI HAR Dataset/train", sep="")
#loading raw datasets
test_raw <- fread(file.path(pathTest, "X_test.txt"))[, featuresWanted, with = FALSE]
train_raw <- fread(file.path(pathTrain, "X_train.txt"))[, featuresWanted, with = FALSE]
#loading the activities and subjects
testActivities <- fread(file.path(pathTest, "Y_test.txt"), col.names = c("Activity"))
trainActivities <- fread(file.path(pathTrain, "Y_train.txt"), col.names = c("Activity"))                        
testSubjects <- fread(file.path(pathTest, "subject_test.txt"), col.names = c("SubjectID"))
trainSubjects <- fread(file.path(pathTrain, "subject_train.txt"), col.names = c("SubjectID"))
#renaming the measurements from the codebook
data.table::setnames(test_raw, colnames(test_raw), measurements)
data.table::setnames(train_raw, colnames(train_raw), measurements)
###############################################################################################
#GENERATING THE FINAL TEST AND TRAIN DATASETS AND JOINING THEM
testDS <- cbind(testSubjects, testActivities, test_raw)
trainDS <- cbind(trainSubjects, trainActivities, train_raw)
joinedDS <- rbind(test,train)
#LABEL CONVERSION FOR BETTER DATA READABILITY
joinedDS[["Activity"]] <- factor(joinedDS[, Activity]
                              , levels = activity_labels[["ActivityClass"]]
                              , labels = activity_labels[["ActivityName"]])
#CREATING A SECOND, TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE PER SUBJECT+ACTIVITY
joinedDS <- reshape2::melt(data = joinedDS, id = c("SubjectID", "Activity"))
aggregateDS <- reshape2::dcast(data = joinedDS, SubjectID + Activity ~ variable, fun.aggregate = mean)
###############################################################################################
#SAVING THE RESULTS
#SAVING AGGREGATE DATA TO FILE
data.table::fwrite(x = aggregateDS, file = "tidyData.txt", quote = FALSE)
#SAVING CODEBOOKS EMPLOYED IN THE TIDY DATAFILE
data.table::fwrite(x = activity_labels, file = "CB_ACTIVITY_LABELS.txt", quote = FALSE)
data.table::fwrite(x = as_tibble(measurements), file = "CB_FEATURES.txt", quote = FALSE)