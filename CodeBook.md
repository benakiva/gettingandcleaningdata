#Getting and Cleaning Data Project

##Description
This file describes the variables, the data, and any transformations performed to clean up the data.

##Data Source
The dataset used in this project was built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors and published in the research paper "Human Activity Recognition Using Smartphones Data Set" which was originally made available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

##Data Set Information
The aforementioned paper describes the data set as follows:
“The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. “

##Attribute Information

For each record in the dataset it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body  acceleration.
* Triaxial Angular velocity from the gyroscope.
* A 561-feature vector with time and frequency domain variables.
* Its activity label.
* An identifier of the subject who carried out the experiment.

##Transformations
1. All the files in the working directory (“~/Dropbox/Coursera/Getting and Cleaning Data/project/UCI HAR Dataset”) were imported into tables. Then, the training and test sets were merged together.
2. The mean and standard deviation of every measurement was extracted into a logical vector.
3. Merges the activity labels dataset with the training and test dataset to include descriptive activities names:
4. Cleans the variable names up using sub:
	* "StdDev"
  	* ”Mean"
  	* ”time"
  	* ”freq"
  	* ”Gravity"
  	* "Body"
  	* ”Gyro"
  	* ”AccMagnitude"
  	* ”BodyAccJerkMagnitude"
	* ”JerkMagnitude"
  	* ”GyroMagnitude"
5. Create a new independent tidy data set with the average of each variable for each activity and each subject. And, exports the tidy dataset into the file tidy.txt