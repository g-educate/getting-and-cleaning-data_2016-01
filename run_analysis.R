# Download and Unzip the file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "Dataset.zip", method = "internal")
unzip("Dataset.zip")

# Read the training dataset
train_subject <- read.csv("subject_train.txt", sep="", header = FALSE)
train_X <- read.csv("X_train.txt", sep="", header = FALSE)
train_Y <- read.csv("y_train.txt", sep="", header = FALSE)

# Read the test dataset
test_subject <- read.csv("subject_test.txt", sep="", header = FALSE)
test_X <- read.csv("X_test.txt", sep="", header = FALSE)
test_Y <- read.csv("y_test.txt", sep="", header = FALSE)

# Read the features of the dataset
features <- read.csv("features.txt", sep="", header = FALSE)

# Select only the columns that has mean and standard deviation measures
col_names <- sqldf("select * from features where V2 like '%mean()%' or V2 like '%std()%'")

# Assign column names to the training and test datasets
colnames(train_X) <- features[,2]
colnames(test_X) <- features[,2]

colnames(train_subject) <- "subject_id"
colnames(test_subject) <- "subject_id"

colnames(train_Y) <- "activity_label"
colnames(test_Y) <- "activity_label"

# Column bind and merge the subject, X and Y variables of the training and test dataset
# Select only those columns that has measures of mean and standard deviation
train <- cbind(train_subject, train_X[col_names[,1]], train_Y)
test <- cbind(test_subject, test_X[col_names[,1]], test_Y)

# Row bind and merge training and test dataset that has measures of mean and standard deviation
merged_data <- rbind(train, test)

# Descriptive activity names in the merged dataset
class(merged_data$activity_label)
merged_data$activity_label <- as.factor(merged_data$activity_label)
activity_label <- read.csv("activity_labels.txt", sep="", header = FALSE)
levels(merged_data$activity_label) <- activity_label[,2]

# Descriptive variable names
names(merged_data) <- gsub("\\.", "", names(merged_data))
names(merged_data) <- gsub("std", "standarddeviation", names(merged_data))
names(merged_data) <- gsub("Acc", "acceleration", names(merged_data))

# Independent tidy dataset with the average of each variable for each activity and eachs subject
new_dataset <- aggregate(.~activity_label+subject_id, data = merged_data, FUN =mean)

# Write the tidy dataset into a file using write.table() with row.names as FALSE
write.table(new_dataset, file = "aggregated_dataset.csv", sep = ",", row.names = FALSE)

