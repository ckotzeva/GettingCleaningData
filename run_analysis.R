## Read in the test and train datasets
TestFile<-read.table("./UCI HAR Dataset/test/X_test.txt")
TestLabels<-read.table("./UCI HAR Dataset/test/y_test.txt")
TestSubject<-read.table("./UCI HAR Dataset/test/subject_test.txt")
## Read in the test and train datasets
TrainFile<-read.table("./UCI HAR Dataset/train/X_train.txt")
TrainLabels<-read.table("./UCI HAR Dataset/train/y_train.txt")
TrainSubject<-read.table("./UCI HAR Dataset/train/subject_train.txt")

## Read in the feature description
library("stringr")

Features<-read.table("./UCI HAR Dataset/features.txt")
f1<-as.character(Features[,2])
f2<-str_replace_all(f1, "[[:punct:]]", "_")
f3<-gsub("__","",f2)

colnames(TestFile)<-f3
colnames(TrainFile)<-f3

## Read in the activity description
Activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(Activity)<-c("V1", "TypeOfActivity")

## Combine into one
colnames(TestLabels)<-c("ActivityPerformed")
colnames(TrainLabels)<-c("ActivityPerformed")

colnames(TestSubject)<-c("TestSubject")
colnames(TrainSubject)<-c("TestSubject")

##combining all data into one 
TestData<-cbind(TestFile, TestLabels)
TrainData<-cbind(TrainFile, TrainLabels)

TestDataS<-cbind(TestData, TestSubject)
TrainDataS<-cbind(TrainData, TrainSubject)

#select the variables to retain

retainVars<-c(
  "tBodyAcc_mean_X",
  "tBodyAcc_mean_Y",
  "tBodyAcc_mean_Z",
  "tBodyAcc_std_X",
  "tBodyAcc_std_Y",
  "tBodyAcc_std_Z",
  "tGravityAcc_mean_X",
  "tGravityAcc_mean_Y",
  "tGravityAcc_mean_Z",
  "tGravityAcc_std_X",
  "tGravityAcc_std_Y",
  "tGravityAcc_std_Z",
  "tBodyAccJerk_mean_X",
  "tBodyAccJerk_mean_Y",
  "tBodyAccJerk_mean_Z",
  "tBodyAccJerk_std_X",
  "tBodyAccJerk_std_Y",
  "tBodyAccJerk_std_Z",
  "tBodyGyro_mean_X",
  "tBodyGyro_mean_Y",
  "tBodyGyro_mean_Z",
  "tBodyGyro_std_X",
  "tBodyGyro_std_Y",
  "tBodyGyro_std_Z",
  "tBodyGyroJerk_mean_X",
  "tBodyGyroJerk_mean_Y",
  "tBodyGyroJerk_mean_Z",
  "tBodyGyroJerk_std_X",
  "tBodyGyroJerk_std_Y",
  "tBodyGyroJerk_std_Z",
  "tBodyAccMag_mean",
  "tBodyAccMag_std",
  "tGravityAccMag_mean",
  "tGravityAccMag_std",
  "tBodyAccJerkMag_mean",
  "tBodyAccJerkMag_std",
  "tBodyGyroMag_mean",
  "tBodyGyroMag_std",
  "tBodyGyroJerkMag_mean",
  "tBodyGyroJerkMag_std",
  "fBodyAcc_mean_X",
  "fBodyAcc_mean_Y",
  "fBodyAcc_mean_Z",
  "fBodyAcc_std_X",
  "fBodyAcc_std_Y",
  "fBodyAcc_std_Z",
  "fBodyAccJerk_mean_X",
  "fBodyAccJerk_mean_Y",
  "fBodyAccJerk_mean_Z",
  "fBodyAccJerk_std_X",
  "fBodyAccJerk_std_Y",
  "fBodyAccJerk_std_Z",
  "fBodyGyro_mean_X",
  "fBodyGyro_mean_Y",
  "fBodyGyro_mean_Z",
  "fBodyGyro_std_X",
  "fBodyGyro_std_Y",
  "fBodyGyro_std_Z",
  "fBodyAccMag_mean",
  "fBodyAccMag_std",
  "fBodyBodyAccJerkMag_mean",
  "fBodyBodyAccJerkMag_std",
  "fBodyBodyGyroMag_mean",
  "fBodyBodyGyroMag_std",
  "fBodyBodyGyroJerkMag_mean",
  "fBodyBodyGyroJerkMag_std",
    "TestSubject",
    "ActivityPerformed")
TestDataS1<-TestDataS[, retainVars]
TrainDataS1<-TrainDataS[, retainVars]

## Give the activities decent explanation
TestDataS2<-merge(TestDataS1, Activity, by.x="ActivityPerformed", by.y="V1", all=TRUE)
TrainDataS2<-merge(TrainDataS1, Activity, by.x="ActivityPerformed", by.y="V1", all=TRUE)

TestDataS2$Dataset<-"Test"
TrainDataS2$Dataset<-"Train"

AllData<-rbind(TestDataS2,TrainDataS2)

library("reshape2")
molten<-melt(AllData[,1:69], id.vars=c("TestSubject","TypeOfActivity"))
TidyData<-dcast(molten,TestSubject+TypeOfActivity ~ variable ,mean , na.rm=TRUE)

TidyData$TypeOfActivity<-NULL
write.table(TidyData,"./UCI HAR Dataset/TidyData.txt" ,row.name=FALSE)
