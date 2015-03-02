library(data.table)
library(tidyr)
library(stringi)
library(stringr)

## The file retieving was tested under Linux. I guess it works like this under BSD unix as well
## For windows you might have to change some slashes else manual download manually
## The file is downloaded in the working directory and unzipped from there.
## The ropt directory of the dataset is renamed to "dataset"
if (!file.exists("./dataset")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile="./Dataset.zip", method = "curl")
        unzip("./Dataset.zip")
        file.remove("./Dataset.zip")
        file.rename("./UCI\ HAR\ Dataset","dataset")# to change in a easier dir
        }
# Since it was asked for an endproduct containg means and sd's only I decided not to
# include data from the inertial signals subdirs. Their means are contained in the
# X-test/train data sets.
#1. read in the files
# first the header file of the dataset.It ontains the names of all columns of 
# the big datasets
featnames<-read.table("./dataset/features.txt",colClasses=c("integer","character"))[,2]
# Construct a logic vector for selection ot those columns that contain averages 
# and standard devations I decided to also include the mean frequencies since it 
# is information not extractable from the other mean values
# featmeans<-grepl("mean\\(|std",featnames,fixed=FALSE,perl=FALSE)
featmeans<-grepl("mean|std",featnames,fixed=FALSE,perl=FALSE)
############### Test-gtoup  dataset########################
# read in the test group's data frame and set the column names. Note that fread
# from the data.table package crashes onthese files.
datatest<-read.table("./dataset/test/X_test.txt", colClasses="numeric", nrows = 2947)
# get the person id per row of the test dataset 
person <- read.table("./dataset/test/subject_test.txt",col.names="person", colClasses="integer", nrows = 2947)
# load the activity code per row 
activity <- read.table("./dataset/test/y_test.txt",col.names="activity", colClasses="integer", nrows = 2947)
# combine the last two row identifiers and bind them to the dataset 
datatest <- cbind(person, activity, datatest)
# name the dataset with the headers
setnames(datatest,3:563, featnames)
############# Train Group dataset ##########################
# the step are identical as for the test group
datatrain<-read.table("./dataset/train/X_train.txt", colClasses="numeric", nrows = 7352)
person <- read.table("./dataset/train/subject_train.txt",col.names="person", colClasses="integer", nrows = 7352)
activity <- read.table("./dataset/train/y_train.txt",col.names="activity", colClasses="integer", nrows = 7352)
datatrain <- cbind(person, activity, datatrain)
setnames(datatrain,3:563, featnames)
##############Combining####Selection####(re)naming#####
#  bind the two dataframes columnwise
data<-rbind(datatest,datatrain)
# correct the selectionvector for the two added columns and select the chosen ones 
# and turn the frame into a data.table
featmeans <- c(c(TRUE,TRUE),featmeans)
data<-data.table(data[,featmeans])
# read the activitynames , make them titlecase and apply them in place to the 
# activity ccolumn
act<-read.table('dataset/activity_labels.txt',stringsAsFactors = FALSE)
activitynames <- stri_trans_totitle(act[,2])
data[, activity:=activitynames[activity]]
# and tydying up the feature names removing score  to CamelCase where needed
# cleaning up stepwise to make it easier to comment
oldnames <- names(data)
newnames <- str_replace_all(oldnames,'-mean','Mean')
newnames <- str_replace_all(newnames,'-std','Std')
newnames <- str_replace_all(newnames, '\\(\\)', '')  # getting rid of ()
newnames <- str_replace_all(newnames, '-', '')        # some are left
newnames <- str_replace_all(newnames, 'BodyBody', 'Body') # unnecessary doubling
newnames <- str_replace_all(newnames, '^t', 'Time')  # Is easy to overlook otherwise
newnames <- str_replace_all(newnames, '^f', 'Freq')   # same
setnames(data, oldnames, newnames)  
#############Tidying##########
# We average over the rows per person and per activity
setkeyv(data,c("person","activity"))
data<-data[,lapply(.SD,mean), by = key(data)]
#and write the tidy data.table
write.table(data,'ActUsingPhones.txt',row.names = FALSE)


