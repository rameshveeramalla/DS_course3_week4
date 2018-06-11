# DS_course3_week4

This repo contains 3 files 
- README.md
- run_analysis.R
- CodeBook.md

## run_analysis.R
This file contains script that executes all steps specified in DataScience Specialization, Course 3 ('Getting and Cleaning Data') peer-review assignment 

The 'UCI HAR Dataset' zip file provided as part of this assignment is first downloaded and unzipped into a directory on the location machine

The analysis script first loads the training (X_train.txt) and test (X_test.txt) files and merges the datasets using rbind function
The labels for training (y_train.txt) and test (y_test.txt) files are loaded and merged 
The subject infromation in training(subject_train.txt) and test (subject_test.txt) files are loaded and merged

The features.txt file is used to determine the column names for the combined train/test datasets

The activity_labels.txt file is used to determine the descriptive information for activity which maps to the labels in Y dataset above.

To extract only the measurements on mean and standard deviation, subset the dataset using grep command to search for 'mean()' or 'std()'

To determine the average of each variable for each activity and each subject, first group by activity and subject, and then pass the output to summarise mean and store it in a file using write.table function

