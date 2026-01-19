# PolishEquity.Analytics.Trainer
This directory contains the core machine learning logic, data ingestion, preprocessing pipeline for the project. 

## Directory structure
- `Data/` - contains raw, labeled and preprocessed datasets. These files serve as the primary input for the training pipeline after being exported from the database. (see `data/README.md`)
- `ETL/` - holds the SQL scripts (PostgreSQL) responsible for data extraction, joining financial tables, and initial cleaning before the machine learning phase.
- `Preprocessing/` - defines the ML.NET Estimator Chain.
- `Utils/` - contains DataLoader responsible for lazy-loading data into IDataView and managing file system paths.
- `Training/` - contains the script for LightGBM multiclass classification configuration, hyperparameter settings,
