The following are the descriptions of the steps in the run_analysis.R

1. Download the file to the working directory
2. Unzip the file
3. Move the train and test datasets in to the working directory
4. Read all the relevant data from the train dataset- subject_train, X_train, y_train text files
5. Read all the relevant data from the test dataset- subject_test, X_test, y_test text files
6. Read the features.txt to get the column names in the X_train and X_test files
7. Select the columns that has the measures of the mean and standard deviation
8. Set the column names to the data from the text files
9. Column bind and merge the training datasets
10. Column bind and merge the test datasets
11. Row bind and merge the training and test datasets
12. Label the activity with descriptive names in the merged dataset
13. Convert the short names on the variables to descriptive variable names in the merged dataset
14. Create a new tidy dataset with aggregating on subjects and activities
15. Write the new dataset into a new file
