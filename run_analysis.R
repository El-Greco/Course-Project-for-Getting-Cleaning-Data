# make sure all relevant Samsung data is extracted in the working directory

activity_labels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")
y_train <- read.table("./train/y_train.txt")
X_train <- read.table("train/X_train.txt")
y_test <- read.table("./test/y_test.txt")
X_test <- read.table("./test/X_test.txt")
subject_train <- read.table("./train/subject_train.txt")
subject_test <- read.table("./test/subject_test.txt")

names(y_train) <- c("activity")
names(X_train) <- features$V2
names(subject_train) <- c("subject_id")
names(y_test) <- c("activity")
names(X_test) <- features$V2
names(subject_test) <- c("subject_id")

alltrain <- cbind(subject_train, y_train, X_train) 
alltest <- cbind(subject_test, y_test, X_test)
alldata <- rbind(alltest, alltrain)

mean_cols <- grep("^.*mean()", as.character(features$V2), perl=TRUE, value=TRUE)
std_cols <- grep("^.*std()", as.character(features$V2), perl=TRUE, value=TRUE)

subset_mean <- alldata[,mean_cols]
subset_std <- alldata[,std_cols]

subject_id <- alldata$subject_id
activity <- alldata$activity
subset_alldata <- cbind(subject_id, activity, subset_mean, subset_std)

subset_alldata$activity <- as.character(subset_alldata$activity)
subset_alldata$activity <- sub("1","walking",subset_alldata$activity)
subset_alldata$activity <- sub("2","walkingupstairs",subset_alldata$activity)
subset_alldata$activity <- sub("3","walkingdownstairs",subset_alldata$activity)
subset_alldata$activity <- sub("4","sitting",subset_alldata$activity)
subset_alldata$activity <- sub("5","standing",subset_alldata$activity)
subset_alldata$activity <- sub("6","laying",subset_alldata$activity)

subset_alldata$activity <- as.factor(subset_alldata$activity)

allnames <- names(subset_alldata)

newnames <- tolower(allnames)
newnames <- gsub("^t","time",newnames)
newnames <- gsub("^f","frequency",newnames)
newnames <- gsub("_","",newnames)
newnames <- gsub("-","",newnames)
newnames <- gsub("[()]","",newnames)
newnames <- gsub("gyro","gyroscope",newnames)
newnames <- gsub("acc","acceleration",newnames)
newnames <- gsub("mag","magnitude",newnames)
newnames <- gsub("freq","frequency",newnames)

names(subset_alldata) <- newnames

my_colNames <- names(subset_alldata)
my_colNames <- my_colNames[-(1:2)]

library(reshape2)
alldata_melt <- melt(subset_alldata, id=c("subjectid","activity"),
 measure.vars=my_colNames)

tidy <- dcast(alldata_melt, subjectid + activity ~ variable, mean)

write.table(tidy, "./tidy.txt", row.names = FALSE)

