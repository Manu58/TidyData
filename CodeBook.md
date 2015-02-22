---
title: "CodeBook for a summarizing dataset extracted from the Human Activity Recognition Using Smartphones Dataset
Version 1.0"
author: "Marc Emanuel"
date: "02/22/2015"
output: html_document
---

# Introduction
This is a codebook that describes as an update the codebook that comes with the Human Activity Recognition Using Smartphones Dataset originating from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 
It describes the tidy data file that was produced, and the procedure how it was produced 


The data set is in a text file with spaces as delimiter end a "\\n" line break. It consists of 180 observations and 81 variables of which the first two are keying variables, that together enumerate the observations. The other 79 variables are the mean values and standard deviations from the original dataset averaged over their appearance in both training group's and the test group's tables.   

Since the original datset contained in total 10299 observations it means a  `r round(10299/180)` fold reduction in data per observed statistic. The values for each feature were normalized in the original data set such that its span is the closed interval $[-1,1]$ and thus are dimensionless. To resale them the data provided in the original data sets "Inertial Signals" directory can be used, which at least for observations in the time domain is not complicated.

# Description of the data set
The data set can be read in R using the read.table() function. Now follows a description of the variables. We differentiate between the following types of variables:

### The key's
Each observation is labeled by a unique combination of one of the 30 persons and 1 out of 6 activities.  

- 1 **person** 30 persons participated    
- 2 **activity** a length 6 vector with the values **Walking, Walking Upstairs, Walking Downstairs,Sitting, Standin, Laying**           

### Time domain mean sensor readings differentiated per direction and their standard deviations

As well translational as rotational degrees of freedom

- 3-5:	**TimeBodyAccMeanX,  TimeBodyAccMeanY,  TimeBodyAccMeanZ**   
- 7-8:	**TimeBodyAccStdX,   TimeBodyAccStdY,   TimeBodyAccStdZ**  
- 9-11:	**TimeGravityAccMeanX TimeGravityAccMeanY, TimeGravityAccMeanZ**  
- 12-14:	**TimeGravityAccStdX, TimeGravityAccStdY, TimeGravityAccStdZ**  
- 15-17:	**TimeBodyAccJerkMeanX, TimeBodyAccJerkMeanY,  TimeBodyAccJerkMeanZ**  
- 18-20:	**TimeBodyAccJerkStdX, TimeBodyAccJerkStdY, TimeBodyAccJerkStdZ**
- 21-23:	**TimeBodyGyroMeanX, TimeBodyGyroMeanY, TimeBodyGyroMeanZ**
- 24-26:	**TimeBodyGyroStdX, TimeBodyGyroStdY, TimeBodyGyroStdZ**
- 27-29	**TimeBodyGyroJerkMeanX,	TimeBodyGyroJerkMeanY,	TimeBodyGyroJerkMeanZ**
- 30-32	**TimeBodyGyroJerkStdX,	TimeBodyGyroJerkStdY, TimeBodyGyroJerkStdZ**

### Time domain mean sensor magnitude readings and their standard deviations

- 33,34	**TimeBodyAccMagMean,	TimeBodyAccMagStd**	
- 35,36 **TimeGravityAccMagMean,  TimeGravityAccMagStd**
- 37,38	**TimeBodyAccJerkMagMean,  TimeBodyAccJerkMagStd**
- 39,40	**TimeBodyGyroMagMean,     TimeBodyGyroMagStd**
- 41,42	**TimeBodyGyroJerkMagMean,  TimeBodyGyroJerkMagStd**  

### Frequency domain (Fourier transformed) directional Counterparts  

- 43-45	**FreqBodyAccMeanX, FreqBodyAccMeanY FreqBodyAccMeanZ**
- 46-48	**FreqBodyAccStdX,	FreqBodyAccStdY	FreqBodyAccStdZ**
- 49-51	**FreqBodyAccMeanFreqX,FreqBodyAccMeanFreqY FreqBodyAccMeanFreqZ**
- 52-54	**FreqBodyAccJerkMeanX, FreqBodyAccJerkMeanY FreqBodyAccJerkMeanZ**
- 55-57	**FreqBodyAccJerkStdX, FreqBodyAccJerkStdY FreqBodyAccJerkStdZ**
- 58-60	**FreqBodyAccJerkMeanFreqX, FreqBodyAccJerkMeanFreqY FreqBodyAccJerkMeanFreqZ**
- 61-63	**FreqBodyGyroMeanX, FreqBodyGyroMeanY FreqBodyGyroMeanZ**
- 64-66	**FreqBodyGyroStdX, FreqBodyGyroStdY FreqBodyGyroStdZ**
- 67-69	**FreqBodyGyroMeanFreqX, FreqBodyGyroMeanFreqY FreqBodyGyroMeanFreqZ**

### Frequency domain magnitude counterparts and two mean frequency variables

- 70-71	**FreqBodyAccMagMean, FreqBodyAccMagStd**
- 72-73	**FreqBodyAccMagMeanFreq, FreqBodyAccJerkMagMean**
- 74-75	**FreqBodyAccJerkMagStd, FreqBodyAccJerkMagMeanFreq**
- 76-77	**FreqBodyGyroMagMean, FreqBodyGyroMagStd**
- 78	**FreqBodyGyroMagMeanFreq**
- 79-80	**FreqBodyGyroJerkMagMean, FreqBodyGyroJerkMagStd**
- 81	**FreqBodyGyroJerkMagMeanFreq**

# Construction of the dataset

The dataset is downloaded as a zip archive from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip amd was unzipped in the work directory. The directory the archive created containing the data was renamed from *UCI HAR Dataset* to *dataset*.
The accompanying run_analysis.R script takes care of this if the directory is nor present, at least on Unix systems. If not on UNIX then you will have to download and unpack the archive manually.
the resulting directory structure is:  

$$
\begin{array}{llll}
dataset  & &&\\
& \text{test}&&\\
&&   \text{Inertial Signals} &\\
&&& \cdots (raw data files)\\
&& \text{subject_test.txt  (person id's for X_test.x)}   &\\
&& \text{X_test.x (main data)}  &\\
&& \text{y_test.txt (activities for X_test.x)}&\\
& \text{train}&&\\
&&   \text{Inertial Signals} &\\
&&& \cdots (raw data files)\\
&& \text{subject_train.txt  (person id's for rows of X_train.x)}   &\\
&& \text{X_train.x (main data)}  &\\
&& \text{y_train.txt  (activities for rows of X_train.x)}&\\
&  \text{activity_labels.txt (the activity names)}&&\\
&  \text{features.txt (feature names for main data)}&&\\
&  \text{features_info.txt}&&\\
&  \text{README.txt}&&\\
\end{array}
$$

I decided not to make use of the raw data in the *Inertial Signals* directories, since their means are already included in the main dat file.
The data files are all read in using read.table(), since fread() crashed on the larger datasets.  

A logic vector is constructed for selection of those columns that contain averages 
and standard deviations. I decided to also include the mean frequencies since it 
is information not  from the other mean values  

first is the test groups data.frame prepared. The subject id file and   the activity code file are attached using cbind, as column 1 resp. 2, to the data.frame that was read in  from X_test.txt. Next is the content of featurenames.txt used to name the columns, except for the first two, using the setnames function from data.table.  

After having undergone the same procedure the training group data and the test group data are stacked  using rbind. The resulting data.frame is at that occasion transformed into a data.table.

With the first two columns set as key, the average of the rows was easily obtained using the data.table .DT selection 

Now the logic vector prepared was used to retain only those columns that I considered necessary.  
and activity codes were translated into the names obtained from "activity_labels.txt". The names were first slightly modified into title-case and then in place added to the activity column.

Then the feature names are beautify d changing dashes into Camel Case, removing unnecessary symbols.

Finally the rows were reduced drastically by averaging over all rows with equal subject and activity and the file is written to disk

If you are longing for more detail, the R-script is extensively commented.

