The following analysis is based on the Samsung data that were presented by: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto. More specificaly the dataset and all relevant files are based on:

Human Activity Recognition Using Smartphones Dataset
Version 1.0
by:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

All relevant data is first extracted in our R working directory. Then we run the script contained in the run_analysis.R file found on this repository. 

The script performs the following transformations:

First we load the data from the train and test data sets. Next we assign names to the train and test data. The data consists of:
a subject_test and subject_train vector containing an identifier of the 30 persons that took part in the measurements, 
a y_train and y_test vector with an identifier of the 6 activities measured,
a X_train and X_test table of the measurements.

We then assign names to the columns of all the R data frames we just loaded.

Using cbind and rbind we construct one big dataset that contains the subject id, activity and all measurements from both the "train" and "test" datasets. We call the new dataset "alldata".

Then we filter the "big" dataset and create two subsets. One contains all the columns with header ending in mean() and the other the ones with header ending in std().  We then combine the two resulting data frames with the subject_id and activity columns from the "big" data set to create a new data set containing only measurements of means and standard deviations. We call this new data frame "subset_alldata". 

We then replace the identifiers of the activity column with their descriptive names.

We then transform the headers of the variables in an attempt to make them more "human readable". The transformations are as follows:
We convert all headers to lowercase. We replace any "t" at the start of the header with "time" and any "f" at the start of the header with "frequency". We then delete any underscore, dash or parenthesis found in the headers. We replace "gyro" with "gyroscope", "acc" with "acceleration", "mag" with "magnitude" and "freq" with "frequency". 

We do not perform any transformations to the units of measurement or the data as such at this stage.

Further descriptions on each variable can be found README.txt and features.txt files of the original dataset.

We then use the package "reshape2" to create a new dataset with the average of each variable for each activity and each subject. 
