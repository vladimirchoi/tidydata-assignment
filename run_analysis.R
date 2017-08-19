clean <- function() {
  library(dplyr)
  
  #load features
  features <- tbl_df(read.table("features.txt",header=FALSE))
  
  #load activity labels
  activitylab <- tbl_df(read.table("activity_labels.txt",header=FALSE))
  
  #load training data
  train <- tbl_df(read.table("train/X_train.txt",header=FALSE,col.names=features$V2))
  trainlab <- tbl_df(read.table("train/y_train.txt",header=FALSE))
  trainsub <- tbl_df(read.table("train/subject_train.txt",header=FALSE))
  
  #load test data
  test <- tbl_df(read.table("test/X_test.txt",header=FALSE,col.names=features$V2))
  testlab <- tbl_df(read.table("test/y_test.txt",header=FALSE))
  testsub <- tbl_df(read.table("test/subject_test.txt",header=FALSE))
  
  #add subjects and activity labels to training data
  train2 <- cbind(trainsub,trainlab,train)
  colnames(train2) <- c("subject","activity",as.character(features$V2))

  #add subjects and activity labels to test data
  test2 <- cbind(testsub,testlab,test)
  colnames(test2) <- c("subject","activity",as.character(features$V2))

  #merge training and test data
  comb <- rbind(train2,test2)
  
  #extract only mean and std variables
  meanfeat <- grep("mean", features$V2)
  stdfeat <- grep("std", features$V2)
  combfeat <- c(meanfeat,stdfeat)
  combfeat <- c(1,2,combfeat + 2)
  comb <- comb[,combfeat]
  comb <- tbl_df(comb)

  #name the activities
  comb2 <- mutate(comb, activity = activitylab$V2[activity])
  comb2 <- tbl_df(comb2)
  print(comb2)
  
  #create second dataset with average of each variable for each activity and each subject
  comb3 <- group_by(comb2, subject, activity)
  comb3 <- summarise_all(comb3, .funs=mean)
  print(comb3)
  
  write.table(comb3, file="tidydataset.txt", row.names=FALSE)

}