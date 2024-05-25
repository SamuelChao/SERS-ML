# SERS-ML
- This is the revised code from MasterThesisCode
- Conference Published Version

## Purpose
Analysis the high-throughput SERS-microwell bacteria spectra data by machine learning and deep learning

## Database establish
- MySQL
- Records of multiple steps of data preprocessing, models and dataset size variation
- Note: Only record datapath (spectra and image data too large)

## Data preprocessing
- Remove baseline of raw spectra data
- Set the range for analyzing and remove unnecessary wavenumber signals
- Data cleaning based on void characteristic peak signal of SERS substrate
- Normalization spectra signal intensity to between 0 and 1
- Labeled the data with number representation classes
- Split the dataset into  to training and testing set 9:1

## Data visualization 
- PCA: linear transformation 
- T-SNE: non-linear, more relative relationships information

## Machine learning analysis of SERS spectra
- Random Forest (RF)
- Support Vector Machine (SVM)
- K-nearest neighbors (KNN)
- Convolutional Neural Network (CNN)

## Report
- See SERS-ML report.pdf
