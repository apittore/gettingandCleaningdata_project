library(data.table)
library(dplyr)
library("microbenchmark")
library("matrixStats")
setwd("UCI HAR Dataset")
if(!file.exist("./R/data")){dir.create("./R/data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile<-file.path(getwd(),"./R/data/dati.zip")
download.file(fileUrl,destfile)

destfile<-file.path(getwd(),"train/X_train.txt")
train<-read.table(destfile)
destfile<-file.path(getwd(),"test/X_test.txt")
test<-read.table(destfile)
destfile<-file.path(getwd(),"train/Y_train.txt")
Y_train<-read.table(destfile)
destfile<-file.path(getwd(),"test/Y_test.txt")
Y_test<-read.table(destfile)

destfile<-file.path(getwd(),"features.txt")
features <- read.table(destfile)
destfile<-file.path(getwd(),"activity_labels.txt")
activities <- read.table(destfile)

measure_X <- rbind(train,test)
label_Y<-rbind(Y_train,Y_test)
#data_set_label<-cbind(label_Y,measure_X)
DTrow<-length(measure_X)
feature_delete <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
feature_delete_table<-data.frame(feature_delete)

feature_subset<-measure_X[,feature_delete]
names(feature_subset[,1])<-"activity"
feature_subset_label<-features[feature_delete,1]
features[,1]<-paste("V",features[,1],sep="")
feature_delete<-paste("V",feature_delete,sep="")
features_row<-features[feature_delete_table[,1],]
names(feature_subset)<-features_row[,2]

names(feature_subset)<-activities[,2]
for(i in 1:length(feature_subset)){
  mean_feature<-colMeans(feature_subset)
}
write.table(feature_subset, "data_set_merged.txt")
write.table(mean_feature,"data_set_average.txt")