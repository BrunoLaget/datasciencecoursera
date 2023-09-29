###############################################################################################
# 'EXPLORATORY DATA ANALYSIS' COURSE ASSIGNMENT - WEEK 04 / ASSIGNMENT 01/ PART 02/06
# PART OF THE DATA SCIENCE SPECIALIZATION FROM JOHNS HOPKINS UNIVERSITY VIA COURSERA
###############################################################################################
# AUTHOR: BRUNO LAGET MERINO
###############################################################################################

###############################################################################################
#ASSESSMENT CRITERIA
###############################################################################################
#You must address the following questions and tasks in your exploratory analysis. 
#For each question/task you will need to make a single plot. 
#Unless specified, you can use any plotting system in R to make your plot.
#-----------------------------------[PLOT 2]---------------------------------------------------
#   Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
#   from 1999 to 2008? Use the base plotting system to make a plot answering this question.
###############################################################################################

###############################################################################################
#LOADING REQUIRED PACKAGES
library("reshape2")
library("data.table")
library("dplyr")
library("lubridate")
library("ggplot2")
###############################################################################################
#SET WORKING DIRECTORY TO DATASET DIRECTORY
setwd("C:\\Users\\bruno\\OneDrive\\Desktop\\COURSERA\\DS_JOHNSHOPKINS\\COURSE04\\WEEK4\\DATASOURCE")
###############################################################################################
#LOAD DATAFRAMES
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
###############################################################################################
#FIXING COLUMN FORMATS
# Fix the numeric scale
NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
###############################################################################################
#DATAFRAME TRANSFORMATIONS
#Summarizing Emissions by year
totalNEI <- NEI[fips=='24510', 
                lapply(.SD, sum, na.rm = TRUE), 
                .SDcols = c("Emissions"), by = year]
###############################################################################################
#SETTING THE PLOT WINDOW
png("plot2.png", width=480, height=480)
###############################################################################################
barplot(totalNEI[, Emissions]
        , names = totalNEI[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the years in Baltimore",
        col="#330033")
abline(lsfit(1:4,totalNEI[, Emissions]),col="#FF0066",lwd=5,lty="dashed")
dev.off()