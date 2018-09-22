# Getting and Cleaning Data Course Project

This Repository contains the required files for the [Getting and Cleaning Data Course Project](https://www.coursera.org/learn/data-cleaning/home/welcome).

Files Dictionary:

- `Codebook.pdf`: containing a data dictionary for the extracted tidy dataset and summary of R script's process.
- `README.md`: an explanatory introduction to what is this repository, a files dictionary and summary of R script's process.
- `run_analysis.R`: the R script that merges and cleans the data retrieved from the UCI website and extracts a tidy dataset.
- `tidy_dataset.txt`: the tidy dataset that was extracted after running the R script.

Data Preparation Process:

1. Download zip file from UCI website and extract its contents
2. Merge the train and test datasets into one large dataset
3. Extract a list of features that is required (Mean and Standard Deviation features)
4. Filter out the unneeded columns (features) from the merged data frame
5. Give the activity labels column their descriptive names (from the provided activity list)
6. Label the column names with tidy names
7. Group the data frame by the Subject and Activity columns in a new data frame
8. Get the mean for each column according to the newly assigned groups