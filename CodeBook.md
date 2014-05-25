From the assignment description: This file is "a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data...".

The features_info.txt file from the download describes the meaning of the following 17 basic items:

1. tBodyAcc-XYZ
2. tGravityAcc-XYZ
3. tBodyAccJerk-XYZ
4. tBodyGyro-XYZ
5. tBodyGyroJerk-XYZ
6. tBodyAccMag
7. tGravityAccMag
8. tBodyAccJerkMag
9. tBodyGyroMag
10. tBodyGyroJerkMag
11. fBodyAcc-XYZ
12. fBodyAccJerk-XYZ
13. fBodyGyro-XYZ
14. fBodyAccMag
15. fBodyAccJerkMag
16. fBodyGyroMag
17. fBodyGyroJerkMag

This list of 17 items actually represents 33 signals, since each "XYZ" item is actually three signals.  "Mag" stands for the magnitude obtained by combining the X, Y, and Z signals using the Euclidean distance formula.  So, in the original data set, the tBodyAcc-XYZ signals were combined to obtain the tBodyAccMag signal, etc.

The features_info.txt file goes on to say that from each of these 33 signals, a set of 17 statistical variables were estimated: mean, standard deviation, etc.  (17*33 = 561, the number of columns in the file).

The run_analysis.R script reads in the X_train.txt and Y_test.txt files, extracting only the 33 mean and 33 standard deviation columns.  The script expands some of the abbreviations in the column names (since the assignment asks for "English").  Once the script's "everything" data frame is completely built, it contains these columns:

 [1] "subject"                                       
 [2] "activity"                                      
 [3] "time.body.acceleration.mean.x"                 
 [4] "time.body.acceleration.mean.y"                 
 [5] "time.body.acceleration.mean.z"                 
 [6] "time.gravity.acceleration.mean.x"              
 [7] "time.gravity.acceleration.mean.y"              
 [8] "time.gravity.acceleration.mean.z"              
 [9] "time.body.acceleration.jerk.mean.x"            
[10] "time.body.acceleration.jerk.mean.y"            
[11] "time.body.acceleration.jerk.mean.z"            
[12] "time.body.gyro.mean.x"                         
[13] "time.body.gyro.mean.y"                         
[14] "time.body.gyro.mean.z"                         
[15] "time.body.gyro.jerk.mean.x"                    
[16] "time.body.gyro.jerk.mean.y"                    
[17] "time.body.gyro.jerk.mean.z"                    
[18] "time.body.acceleration.magnitude.mean"         
[19] "time.gravity.acceleration.magnitude.mean"      
[20] "time.body.acceleration.jerk.magnitude.mean"    
[21] "time.body.gyro.magnitude.mean"                 
[22] "time.body.gyro.jerk.magnitude.mean"            
[23] "fft.body.acceleration.mean.x"                  
[24] "fft.body.acceleration.mean.y"                  
[25] "fft.body.acceleration.mean.z"                  
[26] "fft.body.acceleration.jerk.mean.x"             
[27] "fft.body.acceleration.jerk.mean.y"             
[28] "fft.body.acceleration.jerk.mean.z"             
[29] "fft.body.gyro.mean.x"                          
[30] "fft.body.gyro.mean.y"                          
[31] "fft.body.gyro.mean.z"                          
[32] "fft.body.acceleration.magnitude.mean"          
[33] "fft.body.body.acceleration.jerk.magnitude.mean"
[34] "fft.body.body.gyro.magnitude.mean"             
[35] "fft.body.body.gyro.jerk.magnitude.mean"        
[36] "time.body.acceleration.std.x"                  
[37] "time.body.acceleration.std.y"                  
[38] "time.body.acceleration.std.z"                  
[39] "time.gravity.acceleration.std.x"               
[40] "time.gravity.acceleration.std.y"               
[41] "time.gravity.acceleration.std.z"               
[42] "time.body.acceleration.jerk.std.x"             
[43] "time.body.acceleration.jerk.std.y"             
[44] "time.body.acceleration.jerk.std.z"             
[45] "time.body.gyro.std.x"                          
[46] "time.body.gyro.std.y"                          
[47] "time.body.gyro.std.z"                          
[48] "time.body.gyro.jerk.std.x"                     
[49] "time.body.gyro.jerk.std.y"                     
[50] "time.body.gyro.jerk.std.z"                     
[51] "time.body.acceleration.magnitude.std"          
[52] "time.gravity.acceleration.magnitude.std"       
[53] "time.body.acceleration.jerk.magnitude.std"     
[54] "time.body.gyro.magnitude.std"                  
[55] "time.body.gyro.jerk.magnitude.std"             
[56] "fft.body.acceleration.std.x"                   
[57] "fft.body.acceleration.std.y"                   
[58] "fft.body.acceleration.std.z"                   
[59] "fft.body.acceleration.jerk.std.x"              
[60] "fft.body.acceleration.jerk.std.y"              
[61] "fft.body.acceleration.jerk.std.z"              
[62] "fft.body.gyro.std.x"                           
[63] "fft.body.gyro.std.y"                           
[64] "fft.body.gyro.std.z"                           
[65] "fft.body.acceleration.magnitude.std"           
[66] "fft.body.body.acceleration.jerk.magnitude.std" 
[67] "fft.body.body.gyro.magnitude.std"              
[68] "fft.body.body.gyro.jerk.magnitude.std"  

Next, the script aggregates the "everything" file by its subject and activity columns.  This produces the "aggregated" data frame.
Each line of the "aggregated" data frame has the average of every variable for a certain activity-subject combination.

For example, aggregated[1:3,1:3] gives the following:
  subject activity time.body.acceleration.mean.x
1       1  WALKING                     0.2773308
2       2  WALKING                     0.2764266
3       3  WALKING                     0.2755675

The "aggregated" data frame is written out as "aggregated.txt".
