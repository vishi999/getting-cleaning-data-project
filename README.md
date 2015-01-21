About the project
The work for the course project for course "Getting and Cleaning data" is contained in this repository.

About the provided raw data
The attributes of the provided raw data are unlabeled and and present in the "X_test.txt". The activity labels are in file "y_test.txt". The test subjects are in the "subject_test.txt" file.
The training set also contains similar data files

How did I create the tidy data
The run_analysis.R script will merge the test and training sets together. The steps are mentioned below:
First the testing and training data is loaded into tabular data. After merging testing and training, labels are added and only columns that have to do with mean and standard deviation are kept. Next, the script creates a tidy data containing the means of all the columns per test subject and per activity. This tidy data is written to a tab-delimited file called tidy.txt

About the Code Book
The CodeBook.md file explains the transformations performed and the resulting data and variables.