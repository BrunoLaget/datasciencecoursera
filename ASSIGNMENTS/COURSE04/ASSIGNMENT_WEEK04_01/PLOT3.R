###############################################################################################
# 'EXPLORATORY DATA ANALYSIS' COURSE ASSIGNMENT - WEEK 04 / ASSIGNMENT 01/ PART 03/06
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
#-----------------------------------[PLOT 3]---------------------------------------------------
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
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
#Filtering dataframe by fips and summarizing by year
baltimore_NEI <- NEI[fips=='24510', 
                lapply(.SD, sum, na.rm = TRUE), 
                .SDcols = c("Emissions"), by = year]
###############################################################################################
#SETTING THE PLOT WINDOW
png("plot3.png")
###############################################################################################
ggplot(baltimore_NEI,aes(factor(year),Emissions,fill=type)) +
    geom_bar(stat="identity") +
    guides(fill=FALSE)+
    facet_wrap(~ type)+
    geom_smooth(aes(group=1), method=lm, col="black", linewidth=1) +
    ylim(0,1800)+
    labs(x="year", y=expression("Total Emission, in T")) + 
    labs(title=expression("PM"[2.5]*" Emissions in Baltimore City 1999-2008 by Source Type"))
dev.off()