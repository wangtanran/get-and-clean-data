# Codebook - Human Activity Recognition Using Smartphones

## activity
    activities performed in the experiments:
    * WALKING
    * WALKING_UPSTAIRS
    * WALKING_DOWNSTAIRS
    * SITTING
    * STANDING
    * LAYING

## subject
    1-30 indicating 30 different volunteers

## other variables
    All the remaining variables indicate signals received.
    Variables starting with a "t" are time domain signals, while others which start with a "f" mean Fast Fourier Transform.
    "X"s, "Y"s, "Z"s at the end of the variable names indicate whether the signal is at X-axial, Y-axial or Z-axial.
    std means standard deviation
    Acc means accelerometer
    Gyro means gyroscope
     
## Notes:
    The original data was downloaded from the following URL:
    http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    After unzipping the data, the following steps were conducted:
    * combine test sets with activity labels and subject number
    * combine train sets with activity labels and subject number
    * merge test sets and train sets
    * label variables with descriptive label names
    * selected entries that include mean() and std() at the end, since only these signals are used to estimate variables of the feature vector for each pattern
    * replace the numbers in activity column with descriptive activity names
    * reshape data and calculate the average of each variable according to activity and subject
