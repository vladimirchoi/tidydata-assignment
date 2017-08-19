# tidydata-assignment
This script takes the data from a [study on wearable data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and creates a tidy dataset which meets the following conditions:
- A single dataset that combines training and test data
- Only the columns with mean and std values are included
- Descriptive activity names and variables are used
- Each row is a unique subject/activity combination
- The columns have been summarized using the `mean` function

## Script walkthrough
1. All the relevant raw data files (features, activity labels, training and test datasets with labels) are loaded into separate data frames.
2. The subjects and activity levels are added to the training and test data frames.
3. Both training and test data frames are merged into a single data frame.
4. The columns with "mean" and "std" in the variable names are subsetted into the `comb` data frame.
5. The activity numbers are replaced with the descriptive activity labels in the `comb2` data frame.
6. The `comb2` data frame is grouped by subject and activity, and summarized using the `mean` function to create the final `comb3` data frame for export.
