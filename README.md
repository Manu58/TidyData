# TidyData
Project for getting_data
The target of this project was to analyze and dissect the data set from
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
on Human Activity Recognition Using Smartphones by Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Italy


There are next to this file three files in this repository: :

1 ActUsingPhones.txt : the tidy dataset that summarizes the original dataset 

2 CodeBook.md file that explains the data and variables.

3 run_analysis.R  An  R script that performs the whole process from the original data to the tidy data file, Wholly automatic, and with some luck it even downloads the file for you. t'is a miracle. It is furthermore in detail commented and feel free to copy and modify it.


# Construction of the dataset

The dataset is downloaded as a zip archive from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip amd was unzipped in the work directory. The directory the archive created containing the data was renamed from *UCI HAR Dataset* to *dataset*.
The accompanying run_analysis.R script takes care of this if the directory is nor present, at least on Unix systems. If not on UNIX then you will have to download and unpack the archive manually.
the resulting directory structure is:  

$$
\begin{array}{lll}
\text{test}&&\\
&   \text{Inertial Signals} &\\
&& \cdots (raw data files)\\
& \text{subject_test.txt  (person id's for X_test.x)}   &\\
& \text{X_test.x (main data)}  &\\
& \text{y_test.txt (activities for X_test.x)}&\\
 \text{train}&&\\
&   \text{Inertial Signals} &\\
&& \cdots (raw data files)\\
& \text{subject_train.txt  (person id's for rows of X_train.x)}   &\\
& \text{X_train.x (main data)}  &\\
& \text{y_train.txt  (activities for rows of X_train.x)}&\\
  \text{activity_labels.txt (the activity names)}&&\\
  \text{features.txt (feature names for main data)}&&\\
  \text{features_info.txt}&&\\
  \text{README.txt}&&\\
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
