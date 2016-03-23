# CodeBook.Rmd

## Variables
The data set has 88 columns and 180 rows.
The rows correspond to the 30 subjects with the 6 activities each.
The columns correspond to the subjects, the activities and the average of the 82 variables measured on the mean and standard deviation.

## Data
So the data of the data set corresponds to the average of each variable for each activity and each subject.
First I split into subjects and then into activities while calculating the mean.

## Transformations
The transformations performed on the original data where the following:  
1. assigning descriptive labels to the columns  
2. removing the "-" characters from the features  
3. turning to lower case the features  
4. searching and selecting only the features on mean's and std's  
5. merging al the data together
