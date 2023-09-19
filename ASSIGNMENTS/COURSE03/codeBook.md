###############################################################################################
# 'GETTING AND CLEANING DATA' COURSE PROJECT
# PART OF THE DATA SCIENCE SPECIALIZATION FROM JOHNS HOPKINS UNIVERSITY VIA COURSERA
###############################################################################################
# AUTHOR: BRUNO LAGET MERINO
###############################################################################################

The main codebooks employed were the activity labels, and the features measured.

# ACTIVITY LABELS
Listed in the CB_ACTIVITY_LABELS file, these are the activities the participants undertook, and are coded as follows:

ActivityClass,ActivityName
1,WALKING
2,WALKING_UPSTAIRS
3,WALKING_DOWNSTAIRS
4,SITTING
5,STANDING
6,LAYING

The labels were simply placed in lieu of the original code in the test and training datasets.

# FEATURES

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
Various measures (Body and Gravity acceleration, and so on) were taken, relative to the spatial axis XYZ.
Finally, a set of variables was estimated from each measurement for each axis, and the original nomenclature was, for example,

13 tBodyAcc-min()-X
14 tBodyAcc-min()-Y
15 tBodyAcc-min()-Z

This label was treated to remove the special characters (), and only std and mean measurements were filtered and considered. 
With the transformations described above, the features codebook was saved as CB_FEATURES, and it is as below:

tBodyAcc-mean-X
tBodyAcc-mean-Y
tBodyAcc-mean-Z
tBodyAcc-std-X
tBodyAcc-std-Y
tBodyAcc-std-Z
tGravityAcc-mean-X
tGravityAcc-mean-Y
tGravityAcc-mean-Z
tGravityAcc-std-X
tGravityAcc-std-Y
tGravityAcc-std-Z
tBodyAccJerk-mean-X
tBodyAccJerk-mean-Y
tBodyAccJerk-mean-Z
tBodyAccJerk-std-X
tBodyAccJerk-std-Y
tBodyAccJerk-std-Z
tBodyGyro-mean-X
tBodyGyro-mean-Y
tBodyGyro-mean-Z
tBodyGyro-std-X
tBodyGyro-std-Y
tBodyGyro-std-Z
tBodyGyroJerk-mean-X
tBodyGyroJerk-mean-Y
tBodyGyroJerk-mean-Z
tBodyGyroJerk-std-X
tBodyGyroJerk-std-Y
tBodyGyroJerk-std-Z
tBodyAccMag-mean
tBodyAccMag-std
tGravityAccMag-mean
tGravityAccMag-std
tBodyAccJerkMag-mean
tBodyAccJerkMag-std
tBodyGyroMag-mean
tBodyGyroMag-std
tBodyGyroJerkMag-mean
tBodyGyroJerkMag-std
fBodyAcc-mean-X
fBodyAcc-mean-Y
fBodyAcc-mean-Z
fBodyAcc-std-X
fBodyAcc-std-Y
fBodyAcc-std-Z
fBodyAccJerk-mean-X
fBodyAccJerk-mean-Y
fBodyAccJerk-mean-Z
fBodyAccJerk-std-X
fBodyAccJerk-std-Y
fBodyAccJerk-std-Z
fBodyGyro-mean-X
fBodyGyro-mean-Y
fBodyGyro-mean-Z
fBodyGyro-std-X
fBodyGyro-std-Y
fBodyGyro-std-Z
fBodyAccMag-mean
fBodyAccMag-std
fBodyBodyAccJerkMag-mean
fBodyBodyAccJerkMag-std
fBodyBodyGyroMag-mean
fBodyBodyGyroMag-std
fBodyBodyGyroJerkMag-mean
fBodyBodyGyroJerkMag-std