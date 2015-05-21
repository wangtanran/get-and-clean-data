# download and unzip data
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "project.zip")
unzip("project.zip")

# combine test sets with activity labels and subject number
test_sets <- read.table("UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_sets <- cbind(test_sets, test_labels, test_subjects)

# combine train sets with activity labels and subject number
train_sets <- read.table("UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_sets <- cbind(train_sets, train_labels, train_subjects)

# merge test sets and train sets
mergedData <- rbind(test_sets, train_sets)

# label variables with descriptive label names
cname <- read.table("UCI HAR Dataset/features.txt") # extract column name from features
names(mergedData) <- cname[,2]  # rename the first 561 columns of mergedData
names(mergedData)[562:563] <- c("activity", "subject")  # rename the last 2 columns of mergedData

# subset useful data
# I only selected entries that include mean() and std() at the end, since only these signals are used to estimate variables of the feature vector for each pattern
narrowMD <- mergedData[, grep("(mean)|(std)|(activity)|(subject)", colnames(mergedData))]   # select columns with names containing "mean" and "std", while still remain the last 2 columns
narrowMD <- narrowMD[, -grep("meanFreq", colnames(narrowMD))]  # exclude columns with names containing "meanFreq"

# replace the numbers in activity column with descriptive activity names
narrowMD$activity <- sapply(narrowMD$activity, switch, "1" = "WALKING", "2" = "WALKING_UPSTAIRS", "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING", "5" = "STANDING", "6" = "LAYING")

# reshape data and calculate the average of each variable according to activity and subject
library(reshape2)
narrowMelt <- melt(narrowMD, id = c("activity", "subject"), measures.vars = names(narrowMD)[1:66])
tidyData <- dcast(narrowMelt, activity + subject ~ variable, mean)

