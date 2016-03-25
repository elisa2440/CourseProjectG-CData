# CodeBook.Rmd

## Data
The Data used in the script comes from the folder *UCI HAR Dataset*. I used the features.txt file and the *subjects*, *y*, and *X* files from the *test* and *train* folders.
The script loades the data make a series of transformations explained below and puts together a data frame with the average of each variable(on mean and std) for each activity and each subject.

## Variables
I use a lot variables to store data while transoforming the raw data. 
*subj_test*, *subj_train*, *features*, *y_test*, *y_train*, *x_test*, *x_train*.
Then the *means* and *stds* variables hold the subset columns from test and train that corresponds to variables on the mean and std.
Finally after using *cbind* to put together all the columns I store the final data frame into a variable called *dataframe*.
For step 5, I use the following variables:
- *m*, a matrix as the independent data set
- *s*, as list of dataframes split by subjects

This data set has 88 columns and 180 rows.
The rows correspond to the 30 subjects with the 6 activities each.
The columns correspond to the subjects, the activities and the average of the 82 variables measured on the mean and standard deviation.


## Transformations
The transformations performed on the original data where the following:  
- assigning descriptive labels to the columns  
- removing the "-" characters from the features  
- turning to lower case the features  
- searching and selecting only the features on mean's and std's  
- merging al the data together
- split data by subject and activity
- calculating the average of each variable for each activity for each subject
