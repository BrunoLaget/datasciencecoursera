###############################################################################################
# 'EXPLORATORY DATA ANALYSIS' COURSE ASSIGNMENT - WEEK 01 / ASSIGNMENT 01/ PART 01/04
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
#SET WORKING DIRECTORY TO DATASET DIRECTORY
setwd("C:\\Users\\bruno\\OneDrive\\Desktop\\COURSERA\\DS_JOHNSHOPKINS\\COURSE04\\WEEK1")
###############################################################################################
#TXT file to dataframe
GAP_Hist <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
###############################################################################################
#FIXING COLUMN FORMATS
# Fixing date format
GAP_Hist[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
# Fixing the numeric scale
GAP_Hist[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
###############################################################################################
#FILTERING THE DATAFRAME
GAP_Hist <- GAP_Hist[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
###############################################################################################
#SETTING THE PLOT WINDOW
png("plot1.png", width=480, height=480)
###############################################################################################
#PLOTTING
hist(GAP_Hist[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power, in kW", ylab="Frequency", col="Red")

dev.off()