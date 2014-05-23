directory = getwd()

## 1. Read data from files

## Read in testing and training DataFiles
X.test <- read.table(paste0(directory,"/UCI HAR Dataset/test/X_test.txt"), quote="\"", header=FALSE)
Y.test <- read.table(paste0(directory,"/UCI HAR Dataset/test/y_test.txt"), quote="\"", header=FALSE)

X.train <- read.table(paste0(directory,"/UCI HAR Dataset/train/x_train.txt"), quote="\"", header=FALSE)
Y.train <- read.table(paste0(directory,"/UCI HAR Dataset/train/y_train.txt"), quote="\"", header=FALSE)

subject.test<- read.table(paste0(directory,"/UCI HAR Dataset/test/subject_test.txt"), quote="\"", header=FALSE)
subject.train <- read.table(paste0(directory,"/UCI HAR Dataset/train/subject_train.txt"), quote="\"", header=FALSE)

## Read in datafiles containing feature and activity labels
feature.names <-read.table(paste0(directory,"/UCI HAR Dataset/features.txt"), quote="\"", header=FALSE)
activity.labels <- read.table(paste0(directory,"/UCI HAR Dataset/activity_labels.txt"), quote="\"", header=FALSE)

## 2. Get list of columns we are interested in. I.e. those that contain the strings -std() or -mean(): stdmean.col
std.col<- grep("-std()",feature.names[,2], fixed=TRUE)
mean.col<- grep("-mean()",feature.names[,2], fixed=TRUE)
stdmean.col <- sort(c(std.col,mean.col)) ## The columns we will ultimately use

## 3. Combine the X test and X train into one dataset and set column names: ds.combined
ds.combined<-rbind(X.test,X.train)
## remove () from column names and apply to ds.combined
feature.names[,2]<-gsub("\\(\\)","",feature.names[,2])
colnames(ds.combined)<-feature.names[,2]

## 4. Reduce ds.combined to only std and mean columns
ds.combined<- ds.combined[,stdmean.col]

## 5. add the Subject and Activity Info as columns to to the data set

## Bind subject rows and activity rows, then cbind together
subject.all <- rbind(subject.test,subject.train)
activity.all <-rbind(Y.test,Y.train)

## Get existing names, so we can add the new ones on
cur.col.names <- names(ds.combined)
## Bind them to the existing dataset
ds.combined <-cbind(ds.combined, subject.all,activity.all)

## Name new columns
names(ds.combined)<- c(cur.col.names,"SubjectName","Activity")

## 5. replace Activities with Activity Names
library(plyr)
colnames(activity.labels)=c("Activity","ActivityName")
## Join ActivityName
ds.combined <- join(ds.combined, activity.labels, by = "Activity")

## Remove Activity
ds.combined<-subset(ds.combined, select=-Activity)


## 6. write tidy data with column means for each subject and activty to file
tidy.data<-ddply(ds.combined, .(SubjectName, ActivityName),  numcolwise(mean))
filename<-"tidy.txt"
write.table(tidy.data, file=filename,row.names=FALSE, sep=",")