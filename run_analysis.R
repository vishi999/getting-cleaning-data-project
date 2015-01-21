library(plyr)

folderPath = "UCI HAR Dataset/"
getFilePath <- function(filepath) {
  paste(folderPath, filepath, sep="")
}

xTrainData <- read.table(getFilePath("train/X_train.txt"))
xTestData <- read.table(getFilePath("test/X_test.txt"))
xData <- rbind(xTrainData, xTestData)
yTrainData <- read.table(getFilePath("train/y_train.txt"))
yTest <- read.table(getFilePath("test/y_test.txt"))
yData <- rbind(yTrainData, yTest)

subjectTrainData <- read.table(getFilePath("train/subject_train.txt"))
subjectTestData <- read.table(getFilePath("test/subject_test.txt"))
subjectData <- rbind(subjectTrainData, subjectTestData)

features <- read.table(getFilePath("features.txt"))
keptMesurePositions <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
xData <- xData[, keptMesurePositions]

names(xData) <- features[keptMesurePositions, 2]
names(xData) <- gsub("\\(|\\)", "", names(xData))
names(xData) <- tolower(names(xData))

activityLabels <- read.table(getFilePath("activity_labels.txt"))
activityLabels[, 2] = gsub("_", "", tolower(as.character(activityLabels[, 2])))
yData[,1] = activityLabels[yData[,1], 2]
names(yData) <- "activity"

names(subjectData) <- "subjectnumber"
merged <- cbind(subjectData, yData, xData)

excludedColumns = which(names(merged) %in% c("subjectnumber", "activity"))
result <- ddply(merged, .(subjectnumber, activity), .fun=function(x){ colMeans(x[,-excludedColumns]) })

write.table(merged, "tidy_data.txt", row.name=FALSE)