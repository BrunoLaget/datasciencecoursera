###############################################################################################
# 'EXPLORATORY DATA ANALYSIS' COURSE ASSIGNMENT - WEEK 04 / ASSIGNMENT 01/ PART 04/06
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
#-----------------------------------[PLOT 4]---------------------------------------------------
#Across the United States, how have emissions from 
# coal combustion-related sources changed from 1999–2008?
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
combustion <- grepl("comb", SCC[, SCC.Level.One], ignore.case=TRUE)
coal <- grepl("coal", SCC[, SCC.Level.Four], ignore.case=TRUE) 
combustionSCC <- SCC[combustion & coal, SCC]
combustionNEI <- NEI[NEI[,SCC] %in% combustionSCC]
#summarizing by year to allow for plotting a trendline
combustionNEI_yearly <- combustionNEI[, 
                            lapply(.SD, sum, na.rm = TRUE), 
                            .SDcols = c("Emissions"), by = year]
###############################################################################################
#SETTING THE PLOT WINDOW
png("plot4.png")
###############################################################################################
#PLOTTING
ggplot(combustionNEI_yearly,aes(year,Emissions)) +
    geom_bar(stat="identity", fill ="#3333CC", width=0.8) +
    geom_smooth(aes(group=1), method=lm, col="#FF0066",alpha=0.7, linewidth=1) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission")) + 
    labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across the US, 1999-2008"))
dev.off()