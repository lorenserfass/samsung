samsung
=======

Analysis of samsung phone motion detector data for Getting and Cleaning Data course from Johns Hopkins.

From the assignment description: "You should also include a README.md in the repo with your scripts.  This repo [sic: README] explains how all of the scripts work and how they are connected."

So: There is only one script in this repo: run_analysis.R.

The script assumes that the UCI HAR Dataset folder is in the working directory.
Each of the steps listed below is labelled in the script.  Please see comments in the script for more explanation.

Step 1.
The script first reads in the features.txt file, which contains column names for the X_train.txt and X_test.txt files.

Step 2.
The script then reads in subject_test.txt, y_test.txt, subject_train.txt, and y_train.txt.  The subject and y pairs are column-binded.  The activities.txt file is read.  The test and train data for these four files are row-binded.

Step 3.
This step decides which features to read.  It does this by grep-ing for "mean(" and "std".  Aseries of calls to sub() and gsub() cleans up the variable names.  (See CodeBook.md for the eventual variable names).

Step 4.
This step reads the mean and std columns of the X_test and Y_train files.  It reads just the columns decided on in step 3.  It rbinds the test and training data to produce two data frames: mean.features and std.features.

Step 5.
This step combines the subject column, the activity column, the 33 mean features, and the 33 std features into one data frame called "everything".  The activity column is changed from numbers to the English descriptions of the activities.

Step 6.
The "everything" data frame is aggregated by its subject and activity columns, with FUN=mean.  A data frame called "aggregated" is produced.  This data frame is written to a file called "aggregated.txt".  This is the "tidy data set" that I upload for the assignment.
