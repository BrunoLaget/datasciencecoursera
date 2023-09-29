###############################################################################################
# 'EXPLORATORY DATA ANALYSIS' COURSE ASSIGNMENT - WEEK 04 / ASSIGNMENT 01/ PART 05/06
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
#-----------------------------------[PLOT 5]---------------------------------------------------
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
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
# Filtering data on SCC df and using it as a filter to the NEI df
vehiclesSCC <- SCC[grepl("vehicle", SCC.Level.Two, ignore.case=TRUE), SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC2]
#Filtering the dataframe for Baltimore
vehiclesNEI_Baltimore <- vehiclesNEI[fips=='24510', 
                            lapply(.SD, sum, na.rm = TRUE), 
                            .SDcols = c("Emissions"), by = year]
vehiclesNEI_Baltimore_y <- vehiclesNEI_Baltimore[, city := c("Baltimore")]
#Filtering the dataframe for LA
vehiclesNEI_LA <- vehiclesNEI[fips=='06037', 
                            lapply(.SD, sum, na.rm = TRUE), 
                            .SDcols = c("Emissions"), by = year]
vehiclesNEI_LA_y <- vehiclesNEI_LA[, city := c("Los Angeles")]
vehiclesLANEI <- vehiclesNEI[fips == "06037",]
vehiclesLANEI[, city := c("Los Angeles")]
# Combine data.tables into one data.table
cities_comparison <- rbind(vehiclesNEI_LA_y,vehiclesNEI_Baltimore_y)
###############################################################################################
#SETTING THE PLOT WINDOW
png("plot6.png")
###############################################################################################
#PLOTTING
ggplot(vehiclesNEI_yearly,aes(year,Emissions)) +
    geom_bar(stat="identity", fill ="#FFCC66", width=0.8) +
    geom_smooth(aes(group=1), method=lm, col="#330033",alpha=0.3, linewidth=1) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission")) + 
    labs(title=expression("PM"[2.5]*" Vehicle Source Emissions in Baltimore, 1999-2008"))
dev.off()