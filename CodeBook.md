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
- 2 **activity** a length 6 vector with the values **Walking, Walking Upstairs, Walking Downstairs,Sitting, Standing, Laying**           

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

