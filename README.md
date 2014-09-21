# Coursera Assignment - Data Cleaning

##Step 1 - Data Read

The code starts with importing all relevant data from the foldersthe data itself (x_test and x_train) the Labels for the performed activity(y_test and y_train) and the file identifying the subject whose measureas are presented subject_test and Subject_train). The values appear in two data frames (one for test and one for train data) but with no column names.

##Step 2 - Labelling

Then it reads in the description of all available features. The form is a data frame with two coluns - sequence number and the feature. The code only retains the second column and clears it form any special symbols by replacing them with dashes. Afterwards, it assigns the values of the vector to the columns of the two data frames.

Then the description of the activities (6) is read in. Its columns are labelled.

The columns of the two additional data frames imported in step 1 (y_train and y_test) and (subject_test and Subject_train) are assigned to the two datasets imported 

##Step 3 - Combining

All data is the combined into two data frames - one for the test and pone for the train data

##Step 4 - Taking variables

From the two data  frames only variables that are measures for mean and standard deviation have been taken

##Step 5 - Assigning the activities proper explanation

Each vallue of the activity performed variable has been assigned a proper description. Merge has been used.


##Step 6- Combine all data into one

The two resulting data frames from the previous steps TestDataS2 and TrainDataS2 have been combined into one.

##Step 7 - Get the tidy Data and export

Tidy Data has been created as taking the mean of all variables by both activity and test subject. It has then been exported.



