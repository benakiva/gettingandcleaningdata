#############################################################################################
# This script is intended to solve the challenge posed by the Getting and Cleaning Data 
# Course Project. It will execute the following steps:
#
#
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.
#
#############################################################################################

setwd("~/Dropbox/Coursera/Getting and Cleaning Data/project/UCI HAR Dataset")

# Read in the data from files
features = read.table('./features.txt',header=FALSE);
activity_labels = read.table('./activity_labels.txt',header=FALSE);
subject_train = read.table('./train/subject_train.txt',header=FALSE);
x_train = read.table('./train/x_train.txt',header=FALSE);
y_train = read.table('./train/y_train.txt',header=FALSE);

# Assigin column names to the data imported above
colnames(activity_labels)  = c('activityId','activityType');
colnames(subject_train)  = "subjectId";
colnames(x_train) = features[,2]; 
colnames(y_train) = "activityId";

# Create combined training set by merging yTrain, subjectTrain, and xTrain
training_data = cbind(y_train, subject_train, x_train);

# Read in the test data
subject_test = read.table('./test/subject_test.txt',header=FALSE);
x_test = read.table('./test/x_test.txt',header=FALSE);
y_test = read.table('./test/y_test.txt',header=FALSE);

# Assign column names to the test data imported above
colnames(subject_test) = "subjectId";
colnames(x_test) = features[,2]; 
colnames(y_test) = "activityId";


# Create the combined test set by merging the x_test, y_test and subjectTest data
test_data = cbind(y_test, subject_test, x_test);


# Combine training and test data to create a final data set
final_data = rbind(training_data, test_data);

# Create a vector for the column names from the finalData, which will be used
# to select the desired mean() & stddev() columns
colNames  = colnames(final_data); 

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Create a logical vector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others
logical_vector = (grepl("activity..",colNames) | grepl("subject..",colNames) | 
                    grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | 
                    grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# Subset final_data table based on the logical_vector to keep only desired columns
final_data = final_data[logical_vector == TRUE];

# 3. Use descriptive activity names to name the activities in the data set

# Merge the final_data set with the acitivity_labels table to include descriptive activity names
final_data = merge(final_data, activity_labels,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames  = colnames(final_data); 

# 4. Appropriately label the data set with descriptive activity names. 

# Cleaning up the variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Reassigning the new descriptive column names to the finalData set
colnames(final_data) = colNames;

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Create a new table, no_activity without the activityType column
no_activity = final_data[,names(final_data) != 'activityType'];

# Summarizing the no_activity table to include just the mean of each variable for each activity and each subject
clean_data = aggregate(no_activity[,names(no_activity) != c('activityId','subjectId')],
                       by=list(activityId=no_activity$activityId,subjectId = no_activity$subjectId),mean);

# Merging the clean_data with activity_labels to include descriptive acitvity names
clean_data = merge(clean_data, activity_labels, by='activityId', all.x=TRUE);

# Export the clean_data set 
write.table(clean_data, './tidy.txt', row.names=TRUE, sep='\t');