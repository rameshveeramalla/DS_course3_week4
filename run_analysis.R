 library(dplyr) 
 
 ## Set the working directory to the location where I downloaded UCI HAR Dataset
 
 ## Read the X training and test datasets using read.table function, and merge the datasets using rbind 
 X_train <- read.table("train/X_train.txt")
 X_test <- read.table("test/X_test.txt")
 X_merged <- rbind(X_train, X_test)
 
  ## Read the Y training and test datasets using read.table function, and merge the datasets using rbind 
 y_train <- read.table("train/y_train.txt")
 y_test <- read.table("test/y_test.txt")
 y_merged <- rbind(y_train, y_test)
 ## assign readable name to the column
 names(y_merged) <- c("ActivityID")
 
  ## Read the Subject training and test datasets using read.table function, and merge the datasets using rbind 
 subject_train <- read.table("train/subject_train.txt")
 subject_test <- read.table("test/subject_test.txt")
 subject_merged <- rbind(subject_train, subject_test)
 ## assign readable name to the column
 names(subject_merged) <- c("SubjectID")
 
 
 ## read the features dataset using the read.table function
 features_table <- read.table("features.txt")
 
 ## read the activity_labels dataset using the read.table function, and assign readable names to columns
 activity_labels <- read.table("activity_labels.txt")
 names(activity_labels) <- c("ActivityID", "ActivityName")
 
 ## Use the names in features table to assign names to columns in X
 names(X_merged) <- features_table[,2]
 
 ## extract only the measurements on the mean and standard deviation for each measurement
 ## Use grep to filter the columns using "mean()" and "std()"
 X_merged_filtered <- X_merged[, grep('mean()', colnames(X_merged), fixed=TRUE)]
 X_merged_filtered <-cbind(X_merged_filtered, X_merged[, grep('std()', colnames(X_merged), fixed=TRUE)])
 
 ## add Y label column to the X dataset using cbind. This will help with grouping in the end
 X_Y_merged_filtered <- cbind(X_merged_filtered, y_merged)
 
 ## add Subject column to the X dataset using cbind. This will also help with grouping in the end
 X_Y_Subject_merged_filtered <- cbind(X_Y_merged_filtered, subject_merged)

## to specify descriptive names for activities in the dataset, merge X dataset with the activity labels dataset by ActivityID
X_Y_Subject_merged_filtered = merge(X_Y_Subject_merged_filtered, activity_labels, by.x="ActivityID", sort=F)

## to create the final tidy dataset, first group by the SubjectID and Activity ID as specified in step 5, and summarise all rows for mean 
final_tidy_data <- data.frame(X_Y_Subject_merged_filtered %>% group_by(SubjectID, ActivityName) %>% summarise_all(funs(mean)))

## write the tidy data set to a file
write.table(final_tidy_data, file="final_tidy_data.txt", row.name=FALSE)