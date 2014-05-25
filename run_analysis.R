# This script does not download and unzip files in this script.
# The script assumes that the UCI HAR Dataset folder is in the working directory.


## Step 1
# read features.txt.  This file contains the column names for the X_train.txt and X_test.txt files.
features <- read.table("UCI HAR Dataset/features.txt",
                       header=F,
                       colClasses=c("NULL", "character")) # skip first column, it's just line numbers
features <- features$V2 # make it just a vector

## Step 2
# Read subject and activity files.  These single-column files correspond line-by-line-
# to the X_ files and will eventually by cbind-ed with them.
test.subjects.activities <- data.frame(subject=scan("UCI HAR Dataset/test/subject_test.txt"),
                                       activitycode=scan("UCI HAR Dataset/test/y_test.txt"))
train.subjects.activities <- data.frame(subject=scan("UCI HAR Dataset/train/subject_train.txt"),
                                        activitycode=scan("UCI HAR Dataset/train/y_train.txt"))

# Get the text descriptions of the activity codes (1 is WALKING, etc).
activities <- read.table("UCI HAR Dataset/activity_labels.txt",
                         col.names=c("activitycode", "activity"))

# getting an idea for the data so far
# table(test.subjects.activities)
# table(train.subjects.activities)

# rbind the test and training data
subjects.activities <- rbind(test.subjects.activities, train.subjects.activities)
# clean up
rm(list=c("test.subjects.activities", "train.subjects.activities"))

# table(subjects.activities)

## Step 3
# of the 561 features, find the 33 means and the 33 std's.
mean.features <- grep("mean\\(", features)
std.features <- grep("std", features)

# Making the feature names a bit cleaner and more self-explanatory.
# These substitutions remove extraneous punctuation, change things to
# lower case, and expand abbreviations.  (They don't work on all 561 columns,
# but they work on the 66 columns we care about.)
# I am using . to separate the parts of each name.
features <- sub("\\(\\)", "", features)
features <- sub("Acc", ".acceleration", features)
features <- sub("^t", "time", features)
features <- sub("^f", "fft", features)
features <- sub("Mag", ".magnitude", features)
features <- gsub("Body", ".body", features)
features <- sub("Gravity", ".gravity", features)
features <- sub("Jerk", ".jerk", features)
features <- sub("Gyro", ".gyro", features)
features <- sub("-mean", ".mean", features)
features <- sub("-std", ".std", features)
features <- sub("-X", ".x", features)
features <- sub("-Y", ".y", features)
features <- sub("-Z", ".z", features)

# Step 4
# reading in just the 33 mean columns of the X_test and X_train files.
colClasses.to.read <- rep("numeric", times=length(features))
colClasses.to.read[-mean.features] <- "NULL" # "NULL" causes skipping non-mean columns
test.mean.features <- read.table("UCI HAR Dataset/test/X_test.txt",
                                 colClasses=colClasses.to.read,
                                 header=F,
                                 col.names=features)

train.mean.features <- read.table("UCI HAR Dataset/train/X_train.txt",
                                  colClasses=colClasses.to.read, # "NULL" causes skipping non-mean columns
                                  header=F,
                                  col.names=features)

mean.features <- rbind(test.mean.features, train.mean.features)
rm(list=c("test.mean.features", "train.mean.features"))

# read in just the 33 std columns of the X_test and X_train files.
colClasses.to.read <- rep("numeric", times=length(features))
colClasses.to.read[-std.features] <- "NULL"
test.std.features <- read.table("UCI HAR Dataset/test/X_test.txt",
                                colClasses=colClasses.to.read,
                                header=F,
                                col.names=features)
train.std.features <- read.table("UCI HAR Dataset/train/X_train.txt",
                                 colClasses=colClasses.to.read,
                                 header=F,
                                 col.names=features)

std.features <- rbind(test.std.features, train.std.features)
rm(list=c("test.std.features", "train.std.features"))

# Step 5
# cbind the mean and std columns together, along with the correct
# subject and activity code for each line.
everything <- cbind(subjects.activities, mean.features, std.features)
rm(list=c("mean.features", "std.features", "subjects.activities"))

# Change the activity code column to the English word describing
# the activity ("WALKING" instead of 1).
everything$activitycode <- factor(everything$activitycode)
levels(everything$activitycode) <- activities$activity
names(everything)[2] <- "activity"

# clean up
rm(list=c("colClasses.to.read", "activities", "features"))

everything$subject <- factor(everything$subject)

# Step 6
aggregated <- aggregate(everything[-(1:2)], # we are aggregating everything except the first 2 columns
                 by=list(everything$subject, everything$activity), # we are aggregating by the first 2 cols
                 FUN="mean")
names(aggregated)[1:2] <- c("subject", "activity")

write.table(aggregated, file="aggregated.txt", sep="\t", row.names=F)
