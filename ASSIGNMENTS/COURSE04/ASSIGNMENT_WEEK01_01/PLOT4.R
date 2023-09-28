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
# Creating datetime column
GAP_Hist_2 <- GAP_Hist[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
# Fixing the numeric scale
GAP_Hist_3 <- GAP_Hist_2[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
###############################################################################################
#FILTERING THE DATAFRAME
GAP_Hist_4 <- GAP_Hist_3[(dateTime >= "2007-02-01 00:00:00") & (dateTime <= "2007-02-03 00:00:00")]
###############################################################################################
#SETTING THE PLOT WINDOW
png("plot4.png", width=480, height=480)
#SETTING A 4X4 WINDOW
par(mfrow=c(2,2))
###############################################################################################
#PLOTTING
# Plot 1
plot(GAP_Hist_4[, dateTime], GAP_Hist_4[, Global_active_power], 
     type="l", xlab="", ylab="Global Active Power")
# Plot 2
plot(GAP_Hist_4[, dateTime],GAP_Hist[, Voltage],
     type="l", xlab="datetime", ylab="Voltage")
# Plot 3
plot(GAP_Hist_4[, dateTime], GAP_Hist_4[, Sub_metering_1], 
     type="l", xlab="", ylab="Energy SubMetering")
lines(GAP_Hist_4[, dateTime], GAP_Hist_4[, Sub_metering_2], col="red")
lines(GAP_Hist_4[, dateTime], GAP_Hist_4[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), 
     c("SubMetering 1","SubMetering 2", "SubMetering 3"), lty=c(1,1), bty="n", cex=.8) 
# Plot 4
plot(GAP_Hist_4[, dateTime], GAP_Hist_4[,Global_reactive_power], 
     type="l", xlab="Date/Time", ylab="Global Reactive Power")
dev.off()