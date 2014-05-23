CleaningDataProject
===================

## Getting and Cleaning Data Course Project

The purpose of this project is to take an existing dataset, clean it and then provide a new dataset of summary statistic.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## My script run_analysis.R does the following:

1) Reads in the relevant data described below:

- X.test: measurements of all variables for the test set

- Y.test: activity codes for the test set

- subject.test: subject numbers for the test set

- activity.labels: a table to translate activity codes to activity names

- feature.names: the names for the columns in X.test and X.train

- X:train: measurements for all variables for the training set

- Y:train: activity codes for the training set

- subject.train: subject numbers for the training set

2) Creates a vector of the columns we will ultimately be interested in. The instructions said to keep only the mean and std column. 
I chose to only inlude columns that contain either -std() or -mean() in their name. The remaining 66 columns are described in the codebook.

3) Combines the test and training data. Name the columns based on a slightly modified feature.names dataset. I removed () from colum names because they were being interpreted as functions.

4) Reduce this combined dataset to only those columns found in step 2.

5) Adds the subject and activity code as columns in the data set.

5) Replaces activity codes with activity names.

6) Creates a tidy.data dataset with column means for each subject and activity. Writes it to the file tidy.txt

## CodeBook.md contains the following

A description of the variables found in tidy.txt and processed by the file run_analysis.R

## Tidy.txt contains the following

For each subject and activity the means of each column described in the CodeBook
