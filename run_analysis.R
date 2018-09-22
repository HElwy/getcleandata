suppressMessages(library(dplyr))
suppressMessages(library(tidyr))

#0. Read Data####

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "UCI HAR Dataset.zip"
folder <- "UCI HAR Dataset"

if (!file.exists(file)){
    download.file(url, file)
}

if (!file.exists(folder)) { 
    unzip(file) 
}

setwd(folder)

#1. Merge Data####

subjectTrain <- read.table("train/subject_train.txt")
yTrain <- read.table("train/y_train.txt")
xTrain <- read.table("train/X_train.txt")

trainDataframe <- cbind(subjectTrain, yTrain, xTrain)

subjectTest <- read.table("test/subject_test.txt")
yTest <- read.table("test/y_test.txt")
xTest <- read.table("test/X_test.txt")

testDataframe <- cbind(subjectTest, yTest, xTest)

mergedDataframe <- rbind(trainDataframe, testDataframe)

# not required, just to avoid reserving unnecessary tables
rm(subjectTrain, xTrain, yTrain, trainDataframe, 
   subjectTest, xTest, yTest, testDataframe)

#2. Extracts the mean and standard deviation for each measurement####

features <- read.table("features.txt")
features$extract <- grepl("mean|std", features[,2])

# This is done because the merged dataframe first two columns
# are the subject column and the activity label column
features[,1] <- features[,1] + 2
extractFeatures <- features[features[,"extract"], 1]

# Here I'm extracting the first column (subjects) the second column
# (activities) and matching features from the training sets 
mergedDataframe <- mergedDataframe[,c(1, 2, extractFeatures)]

#3. descriptive activity names####

activities <- read.table("activity_labels.txt")
mergedDataframe[,2] <- as.factor(mergedDataframe[,2])
levels(mergedDataframe[,2]) <- activities[,2]

#4. label the data set with descriptive variable names#### 

setsNames <- features[features[,"extract"], 2]
setsNames <- gsub('\\-|\\(\\)', '', setsNames)
setsNames <- sub('mean', 'Mean', setsNames)
setsNames <- sub('std', 'Std', setsNames)
colnames(mergedDataframe) <- c("subject", "activity", setsNames)

#5. create a second tidy data set with the average of#### 
#each variable for each activity and each subject.###

tidyDataset <- group_by(mergedDataframe, subject, activity) %>% summarise_all(mean)
setwd("../")
write.table(tidyDataset, "tidy_dataset.txt", row.names = FALSE)