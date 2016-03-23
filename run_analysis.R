#Loading data into R
subj_test <- read.table("test/subject_test.txt")
subj_train <- read.table("train/subject_train.txt")
features <- read.table("features.txt")
y_test <- read.table("test/y_test.txt")
y_train <- read.table("test/y_train.txt")
x_test <- read.table("test/x_test.txt")
x_train <- read.table("train/x_train.txt")

#Labeling the activity colum with the corresponding activity name
names(y_test) <- "activity"
names(y_train) <- "activity"
for(i in 1:nrow(y_test)){
  if(y_test$activity[i]==1){
    y_test$activity[i] <- "walking"
  }else if(y_test$activity[i]==2){
    y_test$activity[i] <- "walking_upstairs"
  }else if(y_test$activity[i]==3){
    y_test$activity[i] <- "walking_downstairs"
  }else if(y_test$activity[i]==4){
    y_test$activity[i] <- "sitting"
  }else if(y_test$activity[i]==5){
    y_test$activity[i] <- "standing"
  }else if(y_test$activity[i]==6){
    y_test$activity[i] <- "laying"
  }
}
for(i in 1:nrow(y_train)){
  if(y_train$activity[i]==1){
    y_train$activity[i] <- "walking"
  }else if(y_train$activity[i]==2){
    y_train$activity[i] <- "walking_upstairs"
  }else if(y_train$activity[i]==3){
    y_train$activity[i] <- "walking_downstairs"
  }else if(y_train$activity[i]==4){
    y_train$activity[i] <- "sitting"
  }else if(y_train$activity[i]==5){
    y_train$activity[i] <- "standing"
  }else if(y_train$activity[i]==6){
    y_train$activity[i] <- "laying"
  }
}

#Removing some features and labeling the columns of x_test and x_train
library(dplyr)
test <- select(x_test, 1:302, 345:381, 424:460, 503:561)
train <- select(x_train, 1:302, 345:381, 424:460, 503:561)
out <- grepl("bandsEnergy", features$V2)
f <- features[!out, ]
f$V2 <- gsub("-", "", f$V2)
f$V2 <- tolower(f$V2)
names(test) <- f$V2
names(train) <- f$V2

#Getting the mean and std variables
i <- grep("mean", names(test))
means <- select(test, i)
j <- grep("std", names(test))
stds <- select(test, j)
k <- grep("mean", names(train))
means2 <- select(train, k)
l <- grep("std", names(train))
stds2 <- select(train, l)

#Creating data frames for test and train sets and merging them into one

df <- cbind(subj_test, y_test, means, stds)
df2 <- cbind(subj_train, y_train, means2, stds2)
names(df)[1] <- "subject"
names(df2)[1] <- "subject"
dataframe <- rbind(df, df2)

#For step 5 first I split the dataframe by subject and then apply the mean for each activity with tapply

#Creating the new matrix with 180(30 subject * 6 activities) rows and 88(subject, activity, 86 vars of mean and std) columns and spliting data by subject

m <- matrix(nrow = 180, ncol = 88)
s <- split(dataframe, dataframe$subject)
m[, 1] <- rep(1:30, each = 6)
vect <- rep(c("walking", "walking_upstairs", "walking_dowstairs", "sitting", "standing", "laying"), 30)
m[, 2] <- vect

#Calculating the average for each variable

row <- 1
for(i in 1:30){
  for(j in 3:88){
    m[row:(row+5), j] <- tapply(e[[i]][, j], e[[i]]$activity, mean)
  }
  row <- row+6
}

#Labeling the columns

names(m)[1] <- "subject"
names(m)[2] <- "activity"
names(m)[3:88] <- names(dataframe)[3:88]
m <- as.data.frame(m)

#Writing the new data frame into a file

write.table(m, file = "data_set.txt", row.names = FALSE)
